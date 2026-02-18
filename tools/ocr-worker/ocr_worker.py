#!/usr/bin/env python3
import argparse
import json
import re
import sqlite3
import subprocess
from dataclasses import dataclass
from typing import List, Optional

DEFAULT_DB = "CocktailChooser.Data/Data/CocktailChooser.db"

AMOUNT_PREFIX_RE = re.compile(
    r"^\s*(?P<amount>(\d+(?:\.\d+)?|\d+/\d+|to\s+\w+|dash(?:es)?|bar\s+spoon|teaspoon|tablespoon|oz|fl\s*oz)\b[^,;-]*)[\s,;-]+(?P<name>.+)$",
    flags=re.IGNORECASE,
)


@dataclass
class ParsedIngredient:
    sort_order: int
    raw_line: str
    raw_amount: Optional[str]
    raw_ingredient_name: Optional[str]
    confidence: Optional[float]
    parse_warnings: Optional[str]


@dataclass
class ParsedStep:
    step_number: int
    instruction: str
    confidence: Optional[float]


@dataclass
class ParsedRecipe:
    cocktail_name: str
    source_recipe_name: Optional[str]
    method_text: Optional[str]
    parser_version: str
    confidence: Optional[float]
    parse_warnings: Optional[str]
    ingredients: List[ParsedIngredient]
    steps: List[ParsedStep]


class OcrWorker:
    def __init__(self, db_path: str):
        self.db_path = db_path

    def _conn(self):
        conn = sqlite3.connect(self.db_path)
        conn.row_factory = sqlite3.Row
        conn.execute("PRAGMA foreign_keys = ON")
        return conn

    def create_import(self, source_id: int, name: str, import_type: str, file_name: Optional[str], notes: Optional[str]):
        with self._conn() as conn:
            cur = conn.execute(
                """
                INSERT INTO OcrImports (RecipeSourceId, ImportName, ImportType, FileName, Status, Notes)
                VALUES (?, ?, ?, ?, 'Pending', ?)
                """,
                (source_id, name, import_type, file_name, notes),
            )
            conn.commit()
            print(f"Created import id={cur.lastrowid}")

    def add_item(self, import_id: int, item_key: Optional[str], text: str, raw_json: Optional[str], confidence: Optional[float]):
        with self._conn() as conn:
            cur = conn.execute(
                """
                INSERT INTO OcrImportItems (OcrImportId, ItemKey, RawText, RawOcrJson, Confidence, Status)
                VALUES (?, ?, ?, ?, ?, 'Pending')
                """,
                (import_id, item_key, text, raw_json, confidence),
            )
            conn.commit()
            print(f"Created item id={cur.lastrowid}")

    def run_pending(self, import_id: Optional[int], ocr_cmd_template: Optional[str]):
        with self._conn() as conn:
            sql = """
                SELECT Id, ItemKey, RawText, RawOcrJson
                FROM OcrImportItems
                WHERE Status IN ('Pending', 'Parsing')
            """
            params = []
            if import_id is not None:
                sql += " AND OcrImportId = ?"
                params.append(import_id)
            sql += " ORDER BY Id"

            rows = conn.execute(sql, params).fetchall()
            if not rows:
                print("No pending items found.")
                return

            for row in rows:
                item_id = row["Id"]
                print(f"Processing item {item_id}...")
                conn.execute("UPDATE OcrImportItems SET Status='Parsing' WHERE Id=?", (item_id,))
                conn.commit()

                raw_text = row["RawText"] or ""
                raw_json = row["RawOcrJson"]

                if (not raw_text.strip()) and ocr_cmd_template and row["ItemKey"]:
                    raw_text, raw_json = self._run_ocr_command(ocr_cmd_template, row["ItemKey"])
                    conn.execute(
                        "UPDATE OcrImportItems SET RawText=?, RawOcrJson=? WHERE Id=?",
                        (raw_text, raw_json, item_id),
                    )
                    conn.commit()

                if not raw_text.strip():
                    conn.execute("UPDATE OcrImportItems SET Status='Failed' WHERE Id=?", (item_id,))
                    conn.commit()
                    print(f"  Failed: empty text and no OCR output for item {item_id}")
                    continue

                parsed = parse_recipe_text(raw_text)
                replace_candidates(conn, item_id, parsed)
                conn.execute("UPDATE OcrImportItems SET Status='Parsed' WHERE Id=?", (item_id,))
                conn.commit()
                print(f"  Parsed item {item_id} into {len(parsed)} candidate recipe(s)")

    def show_candidates(self, item_id: int):
        with self._conn() as conn:
            candidates = conn.execute(
                """
                SELECT Id, CocktailName, SourceRecipeName, MethodText, ParserVersion, Confidence, ParseWarnings
                FROM OcrRecipeCandidates
                WHERE OcrImportItemId = ?
                ORDER BY Id
                """,
                (item_id,),
            ).fetchall()

            if not candidates:
                print("No candidates found.")
                return

            for c in candidates:
                print(f"\nCandidate {c['Id']}: {c['CocktailName']}")
                if c["SourceRecipeName"]:
                    print(f"  Source name: {c['SourceRecipeName']}")
                if c["Confidence"] is not None:
                    print(f"  Confidence: {c['Confidence']}")
                if c["ParseWarnings"]:
                    print(f"  Warnings: {c['ParseWarnings']}")

                ingredients = conn.execute(
                    """
                    SELECT SortOrder, RawLine, RawAmount, RawIngredientName
                    FROM OcrIngredientCandidates
                    WHERE OcrRecipeCandidateId = ?
                    ORDER BY SortOrder, Id
                    """,
                    (c["Id"],),
                ).fetchall()
                print("  Ingredients:")
                for ing in ingredients:
                    print(f"    {ing['SortOrder']}. {ing['RawLine']}")

                steps = conn.execute(
                    """
                    SELECT StepNumber, Instruction
                    FROM OcrStepCandidates
                    WHERE OcrRecipeCandidateId = ?
                    ORDER BY StepNumber
                    """,
                    (c["Id"],),
                ).fetchall()
                print("  Steps:")
                for step in steps:
                    print(f"    {step['StepNumber']}. {step['Instruction']}")

    def publish_candidate(
        self,
        candidate_id: int,
        require_approved: bool,
        create_cocktail: bool,
        create_ingredients: bool,
    ):
        with self._conn() as conn:
            cur = conn.cursor()
            candidate = cur.execute(
                """
                SELECT
                    c.Id,
                    c.OcrImportItemId,
                    c.CocktailName,
                    c.SourceRecipeName,
                    c.MethodText,
                    c.Status,
                    i.OcrImportId,
                    imp.RecipeSourceId
                FROM OcrRecipeCandidates c
                JOIN OcrImportItems i ON i.Id = c.OcrImportItemId
                JOIN OcrImports imp ON imp.Id = i.OcrImportId
                WHERE c.Id = ?
                """,
                (candidate_id,),
            ).fetchone()

            if not candidate:
                raise RuntimeError(f"Candidate {candidate_id} not found.")

            status = (candidate["Status"] or "").lower()
            if require_approved and status not in {"approved", "published"}:
                raise RuntimeError(
                    f"Candidate {candidate_id} has status '{candidate['Status']}'. "
                    "Set status to Approved first, or pass --no-require-approved."
                )

            cocktail_name = (candidate["CocktailName"] or "").strip()
            if not cocktail_name:
                raise RuntimeError(f"Candidate {candidate_id} has no cocktail name.")

            source_recipe_name = (candidate["SourceRecipeName"] or cocktail_name).strip()
            recipe_source_id = candidate["RecipeSourceId"]

            conn.execute("BEGIN")
            try:
                cocktail_id = self._resolve_or_create_cocktail(cur, cocktail_name, create_cocktail)
                recipe_id = self._upsert_recipe(
                    cur=cur,
                    cocktail_id=cocktail_id,
                    recipe_source_id=recipe_source_id,
                    source_recipe_name=source_recipe_name,
                    method_text=candidate["MethodText"],
                )

                cur.execute("DELETE FROM RecipeIngredients WHERE RecipeId = ?", (recipe_id,))
                cur.execute("DELETE FROM RecipeSteps WHERE RecipeId = ?", (recipe_id,))

                self._publish_ingredients(cur, candidate_id, recipe_id, create_ingredients)
                self._publish_steps(cur, candidate_id, recipe_id)

                cur.execute("UPDATE OcrRecipeCandidates SET Status='Published' WHERE Id=?", (candidate_id,))
                cur.execute(
                    "UPDATE OcrImportItems SET Status='Published' WHERE Id=?",
                    (candidate["OcrImportItemId"],),
                )

                conn.commit()
            except Exception:
                conn.rollback()
                raise

            print(f"Published candidate {candidate_id} -> recipe {recipe_id} (cocktail {cocktail_id})")

    def _resolve_or_create_cocktail(self, cur: sqlite3.Cursor, cocktail_name: str, create_cocktail: bool) -> int:
        row = cur.execute(
            "SELECT Id FROM Cocktails WHERE lower(Name) = lower(?) ORDER BY Id LIMIT 1",
            (cocktail_name,),
        ).fetchone()
        if row:
            return row["Id"]

        if not create_cocktail:
            raise RuntimeError(
                f"Cocktail '{cocktail_name}' does not exist. "
                "Use --create-cocktail to allow creating missing cocktails."
            )

        cur.execute(
            """
            INSERT INTO Cocktails (Name, Description, Method, GlassTypeId, TimePeriodId, IsPopular, CocktailSourceID)
            VALUES (?, NULL, NULL, NULL, NULL, 0, NULL)
            """,
            (cocktail_name,),
        )
        return cur.lastrowid

    def _upsert_recipe(
        self,
        cur: sqlite3.Cursor,
        cocktail_id: int,
        recipe_source_id: int,
        source_recipe_name: str,
        method_text: Optional[str],
    ) -> int:
        existing = cur.execute(
            """
            SELECT Id
            FROM Recipes
            WHERE CocktailId = ?
              AND RecipeSourceId = ?
              AND ifnull(SourceRecipeName, '') = ifnull(?, '')
            ORDER BY Id
            LIMIT 1
            """,
            (cocktail_id, recipe_source_id, source_recipe_name),
        ).fetchone()

        if existing:
            recipe_id = existing["Id"]
            cur.execute(
                """
                UPDATE Recipes
                SET Method = ?,
                    UpdatedUtc = strftime('%Y-%m-%dT%H:%M:%fZ', 'now')
                WHERE Id = ?
                """,
                (method_text, recipe_id),
            )
            return recipe_id

        cur.execute(
            """
            INSERT INTO Recipes
            (
                CocktailId,
                RecipeSourceId,
                SourceRecipeName,
                AttributionText,
                SourceUrl,
                Method,
                Notes,
                IsUserSubmitted,
                UpdatedUtc
            )
            VALUES
            (
                ?,
                ?,
                ?,
                NULL,
                NULL,
                ?,
                ?,
                0,
                strftime('%Y-%m-%dT%H:%M:%fZ', 'now')
            )
            """,
            (
                cocktail_id,
                recipe_source_id,
                source_recipe_name,
                method_text,
                f"Published from OCR candidate {source_recipe_name}",
            ),
        )
        return cur.lastrowid

    def _publish_ingredients(
        self,
        cur: sqlite3.Cursor,
        candidate_id: int,
        recipe_id: int,
        create_ingredients: bool,
    ):
        rows = cur.execute(
            """
            SELECT
                SortOrder,
                RawAmount,
                RawIngredientName,
                NormalizedAmountId,
                NormalizedIngredientId
            FROM OcrIngredientCandidates
            WHERE OcrRecipeCandidateId = ?
            ORDER BY SortOrder, Id
            """,
            (candidate_id,),
        ).fetchall()

        inserted = 0
        skipped = 0
        for row in rows:
            ingredient_id = row["NormalizedIngredientId"]
            if ingredient_id is None and row["RawIngredientName"]:
                match = cur.execute(
                    "SELECT Id FROM Ingredients WHERE lower(Name) = lower(?) ORDER BY Id LIMIT 1",
                    (row["RawIngredientName"].strip(),),
                ).fetchone()
                if match:
                    ingredient_id = match["Id"]
                elif create_ingredients:
                    cur.execute(
                        """
                        INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription)
                        VALUES (?, NULL, NULL, 'Created by OCR publish utility')
                        """,
                        (row["RawIngredientName"].strip(),),
                    )
                    ingredient_id = cur.lastrowid

            if ingredient_id is None:
                skipped += 1
                continue

            amount_id = row["NormalizedAmountId"]
            if amount_id is None and row["RawAmount"]:
                amount = cur.execute(
                    "SELECT Id FROM Amounts WHERE lower(MeasurementName) = lower(?) ORDER BY Id LIMIT 1",
                    (row["RawAmount"].strip(),),
                ).fetchone()
                if amount:
                    amount_id = amount["Id"]

            cur.execute(
                """
                INSERT INTO RecipeIngredients (RecipeId, IngredientId, AmountId, SortOrder)
                VALUES (?, ?, ?, ?)
                """,
                (recipe_id, ingredient_id, amount_id, row["SortOrder"]),
            )
            inserted += 1

        print(f"  Ingredients inserted: {inserted}, skipped: {skipped}")

    def _publish_steps(self, cur: sqlite3.Cursor, candidate_id: int, recipe_id: int):
        steps = cur.execute(
            """
            SELECT StepNumber, Instruction
            FROM OcrStepCandidates
            WHERE OcrRecipeCandidateId = ?
            ORDER BY StepNumber
            """,
            (candidate_id,),
        ).fetchall()

        for step in steps:
            cur.execute(
                """
                INSERT INTO RecipeSteps (RecipeId, StepNumber, Instruction)
                VALUES (?, ?, ?)
                """,
                (recipe_id, step["StepNumber"], step["Instruction"]),
            )

    def _run_ocr_command(self, cmd_template: str, item_key: str):
        cmd = cmd_template.replace("{input}", item_key)
        # TODO: Support richer OCR metadata extraction; for now we retain command/stdout only.
        proc = subprocess.run(cmd, shell=True, capture_output=True, text=True)
        if proc.returncode != 0:
            raise RuntimeError(f"OCR command failed: {proc.stderr.strip()}")
        return proc.stdout.strip(), json.dumps({"command": cmd}, ensure_ascii=True)


def parse_recipe_text(raw_text: str) -> List[ParsedRecipe]:
    lines = [ln.strip() for ln in raw_text.replace("\r\n", "\n").split("\n") if ln.strip()]
    if not lines:
        return []

    title = lines[0]
    ingredient_lines: List[str] = []
    method_lines: List[str] = []
    warnings: List[str] = []

    mode = "unknown"
    for line in lines[1:]:
        lower = line.lower()
        if lower in {"ingredients", "ingredient", "ingredients:"}:
            mode = "ingredients"
            continue
        if lower in {"method", "method:", "directions", "instructions", "preparation"}:
            mode = "method"
            continue

        if mode == "unknown":
            if looks_like_ingredient(line):
                ingredient_lines.append(line)
            else:
                method_lines.append(line)
        elif mode == "ingredients":
            ingredient_lines.append(line)
        else:
            method_lines.append(line)

    if not ingredient_lines:
        warnings.append("No explicit ingredient lines were detected.")
    if not method_lines:
        warnings.append("No explicit method/instruction lines were detected.")

    ingredients = [parse_ingredient_line(line, idx + 1) for idx, line in enumerate(ingredient_lines)]
    steps = parse_steps(method_lines)

    return [
        ParsedRecipe(
            cocktail_name=title,
            source_recipe_name=title,
            method_text=" ".join(method_lines) if method_lines else None,
            parser_version="heuristic-v1",
            confidence=0.6,
            parse_warnings=" | ".join(warnings) if warnings else None,
            ingredients=ingredients,
            steps=steps,
        )
    ]


def looks_like_ingredient(line: str) -> bool:
    if AMOUNT_PREFIX_RE.match(line):
        return True
    lower = line.lower()
    return " oz" in lower or lower.startswith("dash") or " to top" in lower


def parse_ingredient_line(line: str, sort_order: int) -> ParsedIngredient:
    m = AMOUNT_PREFIX_RE.match(line)
    if m:
        return ParsedIngredient(
            sort_order=sort_order,
            raw_line=line,
            raw_amount=m.group("amount").strip(),
            raw_ingredient_name=m.group("name").strip(),
            confidence=0.65,
            parse_warnings=None,
        )

    return ParsedIngredient(
        sort_order=sort_order,
        raw_line=line,
        raw_amount=None,
        raw_ingredient_name=line,
        confidence=0.4,
        parse_warnings="Could not split amount from ingredient.",
    )


def parse_steps(method_lines: List[str]) -> List[ParsedStep]:
    if not method_lines:
        return []

    merged = " ".join(method_lines)
    chunks = [c.strip() for c in merged.split(".") if c.strip()]
    if not chunks:
        chunks = method_lines

    return [
        ParsedStep(step_number=i + 1, instruction=chunk, confidence=0.55)
        for i, chunk in enumerate(chunks)
    ]


def replace_candidates(conn: sqlite3.Connection, item_id: int, parsed_recipes: List[ParsedRecipe]):
    cur = conn.cursor()
    cur.execute("DELETE FROM OcrRecipeCandidates WHERE OcrImportItemId = ?", (item_id,))

    for recipe in parsed_recipes:
        cur.execute(
            """
            INSERT INTO OcrRecipeCandidates
            (OcrImportItemId, CocktailName, SourceRecipeName, MethodText, ParserVersion, Confidence, Status, ParseWarnings)
            VALUES (?, ?, ?, ?, ?, ?, 'Pending', ?)
            """,
            (
                item_id,
                recipe.cocktail_name,
                recipe.source_recipe_name,
                recipe.method_text,
                recipe.parser_version,
                recipe.confidence,
                recipe.parse_warnings,
            ),
        )
        candidate_id = cur.lastrowid

        for ing in recipe.ingredients:
            cur.execute(
                """
                INSERT INTO OcrIngredientCandidates
                (OcrRecipeCandidateId, SortOrder, RawLine, RawAmount, RawIngredientName, Confidence, ParseWarnings)
                VALUES (?, ?, ?, ?, ?, ?, ?)
                """,
                (
                    candidate_id,
                    ing.sort_order,
                    ing.raw_line,
                    ing.raw_amount,
                    ing.raw_ingredient_name,
                    ing.confidence,
                    ing.parse_warnings,
                ),
            )

        for step in recipe.steps:
            cur.execute(
                """
                INSERT INTO OcrStepCandidates
                (OcrRecipeCandidateId, StepNumber, Instruction, Confidence)
                VALUES (?, ?, ?, ?)
                """,
                (candidate_id, step.step_number, step.instruction, step.confidence),
            )


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="OCR worker utility for cocktail recipe staging")
    parser.add_argument("--db", default=DEFAULT_DB, help="Path to SQLite database")

    sub = parser.add_subparsers(dest="command", required=True)

    create_import = sub.add_parser("create-import", help="Create a new OCR import batch")
    create_import.add_argument("--source-id", type=int, required=True)
    create_import.add_argument("--name", required=True)
    create_import.add_argument("--type", required=True)
    create_import.add_argument("--file")
    create_import.add_argument("--notes")

    add_item = sub.add_parser("add-item", help="Add an OCR item to an import")
    add_item.add_argument("--import-id", type=int, required=True)
    add_item.add_argument("--item-key")
    add_item.add_argument("--text", required=True)
    add_item.add_argument("--raw-json")
    add_item.add_argument("--confidence", type=float)

    run_pending = sub.add_parser("run-pending", help="Parse all pending OCR items")
    run_pending.add_argument("--import-id", type=int)
    run_pending.add_argument(
        "--ocr-cmd",
        help="External OCR command template. Use {input} placeholder for ItemKey path.",
    )

    show_candidates = sub.add_parser("show-candidates", help="Show parsed candidates for an item")
    show_candidates.add_argument("--item-id", type=int, required=True)

    publish_candidate = sub.add_parser(
        "publish-candidate",
        help="Publish a parsed OCR candidate into Recipes/RecipeIngredients/RecipeSteps",
    )
    publish_candidate.add_argument("--candidate-id", type=int, required=True)
    publish_candidate.add_argument(
        "--require-approved",
        action=argparse.BooleanOptionalAction,
        default=True,
        help="Require OCR candidate status to be Approved/Published (default: true).",
    )
    publish_candidate.add_argument(
        "--create-cocktail",
        action=argparse.BooleanOptionalAction,
        default=True,
        help="Create cocktail row if missing (default: true).",
    )
    publish_candidate.add_argument(
        "--create-ingredients",
        action=argparse.BooleanOptionalAction,
        default=True,
        help="Create ingredient rows if missing (default: true).",
    )

    return parser


def main():
    args = build_parser().parse_args()
    worker = OcrWorker(args.db)

    try:
        if args.command == "create-import":
            worker.create_import(args.source_id, args.name, args.type, args.file, args.notes)
        elif args.command == "add-item":
            worker.add_item(args.import_id, args.item_key, args.text, args.raw_json, args.confidence)
        elif args.command == "run-pending":
            worker.run_pending(args.import_id, args.ocr_cmd)
        elif args.command == "show-candidates":
            worker.show_candidates(args.item_id)
        elif args.command == "publish-candidate":
            worker.publish_candidate(
                candidate_id=args.candidate_id,
                require_approved=args.require_approved,
                create_cocktail=args.create_cocktail,
                create_ingredients=args.create_ingredients,
            )
    except Exception as exc:
        print(f"Error: {exc}")
        raise SystemExit(1)


if __name__ == "__main__":
    main()
