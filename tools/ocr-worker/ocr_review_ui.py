#!/usr/bin/env python3
import argparse
import json
import sqlite3
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from urllib.parse import urlparse

DEFAULT_DB = "CocktailChooser.Data/Data/CocktailChooser.db"


def make_handler(db_path: str):
    class Handler(BaseHTTPRequestHandler):
        def _conn(self):
            conn = sqlite3.connect(db_path)
            conn.row_factory = sqlite3.Row
            conn.execute("PRAGMA foreign_keys = ON")
            return conn

        def _send_json(self, payload, status=200):
            data = json.dumps(payload, ensure_ascii=True).encode("utf-8")
            self.send_response(status)
            self.send_header("Content-Type", "application/json; charset=utf-8")
            self.send_header("Content-Length", str(len(data)))
            self.end_headers()
            self.wfile.write(data)

        def _send_html(self, html, status=200):
            data = html.encode("utf-8")
            self.send_response(status)
            self.send_header("Content-Type", "text/html; charset=utf-8")
            self.send_header("Content-Length", str(len(data)))
            self.end_headers()
            self.wfile.write(data)

        def do_GET(self):
            parsed = urlparse(self.path)
            path = parsed.path

            if path == "/":
                self._send_html(INDEX_HTML)
                return

            try:
                if path == "/api/imports":
                    self._send_json(self._get_imports())
                    return

                if path.startswith("/api/imports/") and path.endswith("/items"):
                    import_id = int(path.split("/")[3])
                    self._send_json(self._get_items(import_id))
                    return

                if path.startswith("/api/items/") and path.endswith("/candidates"):
                    item_id = int(path.split("/")[3])
                    self._send_json(self._get_candidates(item_id))
                    return

                if path.startswith("/api/candidates/"):
                    candidate_id = int(path.split("/")[3])
                    self._send_json(self._get_candidate_detail(candidate_id))
                    return

                if path == "/api/time-periods":
                    self._send_json(self._get_time_periods())
                    return

                self._send_json({"message": "Not found"}, 404)
            except Exception as exc:
                self._send_json({"message": str(exc)}, 500)

        def do_PUT(self):
            parsed = urlparse(self.path)
            path = parsed.path
            if not path.startswith("/api/candidates/"):
                self._send_json({"message": "Not found"}, 404)
                return

            try:
                candidate_id = int(path.split("/")[3])
                body_len = int(self.headers.get("Content-Length", "0"))
                body = self.rfile.read(body_len).decode("utf-8")
                payload = json.loads(body) if body else {}
                self._save_candidate(candidate_id, payload)
                self._send_json({"ok": True})
            except Exception as exc:
                self._send_json({"message": str(exc)}, 500)

        def log_message(self, fmt, *args):
            return

        def _get_imports(self):
            with self._conn() as conn:
                rows = conn.execute(
                    """
                    SELECT Id, ImportName, ImportType, Status, CreatedUtc
                    FROM OcrImports
                    ORDER BY Id DESC
                    """
                ).fetchall()
                return [dict(row) for row in rows]

        def _get_items(self, import_id: int):
            with self._conn() as conn:
                rows = conn.execute(
                    """
                    SELECT
                        i.Id,
                        i.ItemKey,
                        i.Status,
                        i.Confidence,
                        i.CreatedUtc,
                        (SELECT COUNT(*) FROM OcrRecipeCandidates c WHERE c.OcrImportItemId = i.Id) AS CandidateCount
                    FROM OcrImportItems i
                    WHERE i.OcrImportId = ?
                    ORDER BY i.Id
                    """,
                    (import_id,),
                ).fetchall()
                return [dict(row) for row in rows]

        def _get_candidates(self, item_id: int):
            with self._conn() as conn:
                rows = conn.execute(
                    """
                    SELECT
                        Id,
                        CocktailName,
                        SourceRecipeName,
                        ParsedTimePeriod,
                        ParsedFlavorProfile,
                        Status,
                        Confidence
                    FROM OcrRecipeCandidates
                    WHERE OcrImportItemId = ?
                    ORDER BY Id
                    """,
                    (item_id,),
                ).fetchall()
                return [dict(row) for row in rows]

        def _get_candidate_detail(self, candidate_id: int):
            with self._conn() as conn:
                c = conn.execute(
                    """
                    SELECT
                        Id,
                        OcrImportItemId,
                        CocktailName,
                        SourceRecipeName,
                        ParsedTimePeriod,
                        ParsedFlavorProfile,
                        MethodText,
                        ParserVersion,
                        Confidence,
                        Status,
                        ParseWarnings
                    FROM OcrRecipeCandidates
                    WHERE Id = ?
                    """,
                    (candidate_id,),
                ).fetchone()
                if not c:
                    raise RuntimeError(f"Candidate {candidate_id} not found.")

                ingredients = conn.execute(
                    """
                    SELECT
                        Id,
                        SortOrder,
                        RawLine,
                        RawAmount,
                        RawIngredientName,
                        NormalizedAmountId,
                        NormalizedIngredientId,
                        Confidence,
                        ParseWarnings
                    FROM OcrIngredientCandidates
                    WHERE OcrRecipeCandidateId = ?
                    ORDER BY SortOrder, Id
                    """,
                    (candidate_id,),
                ).fetchall()

                steps = conn.execute(
                    """
                    SELECT
                        Id,
                        StepNumber,
                        Instruction,
                        Confidence
                    FROM OcrStepCandidates
                    WHERE OcrRecipeCandidateId = ?
                    ORDER BY StepNumber
                    """,
                    (candidate_id,),
                ).fetchall()

                payload = dict(c)
                payload["Ingredients"] = [dict(row) for row in ingredients]
                payload["Steps"] = [dict(row) for row in steps]
                return payload

        def _get_time_periods(self):
            with self._conn() as conn:
                rows = conn.execute(
                    """
                    SELECT Id, Name
                    FROM CocktailTimePeriods
                    ORDER BY Name
                    """
                ).fetchall()
                return [dict(row) for row in rows]

        def _save_candidate(self, candidate_id: int, payload: dict):
            candidate = payload.get("Candidate", {})
            ingredients = payload.get("Ingredients", [])
            steps = payload.get("Steps", [])

            with self._conn() as conn:
                cur = conn.cursor()
                cur.execute("BEGIN")
                try:
                    cur.execute(
                        """
                        UPDATE OcrRecipeCandidates
                        SET
                            CocktailName = ?,
                            SourceRecipeName = ?,
                            ParsedTimePeriod = ?,
                            ParsedFlavorProfile = ?,
                            MethodText = ?,
                            Status = ?,
                            ParseWarnings = ?,
                            Confidence = ?
                        WHERE Id = ?
                        """,
                        (
                            candidate.get("CocktailName", "").strip(),
                            candidate.get("SourceRecipeName", "").strip() or None,
                            candidate.get("ParsedTimePeriod", "").strip() or None,
                            candidate.get("ParsedFlavorProfile", "").strip() or None,
                            candidate.get("MethodText", "").strip() or None,
                            candidate.get("Status", "Pending").strip() or "Pending",
                            candidate.get("ParseWarnings", "").strip() or None,
                            candidate.get("Confidence"),
                            candidate_id,
                        ),
                    )
                    if cur.rowcount == 0:
                        raise RuntimeError(f"Candidate {candidate_id} not found.")

                    cur.execute("DELETE FROM OcrIngredientCandidates WHERE OcrRecipeCandidateId = ?", (candidate_id,))
                    cur.execute("DELETE FROM OcrStepCandidates WHERE OcrRecipeCandidateId = ?", (candidate_id,))

                    for ing in ingredients:
                        raw_line = (ing.get("RawLine") or "").strip()
                        if not raw_line:
                            continue
                        cur.execute(
                            """
                            INSERT INTO OcrIngredientCandidates
                            (
                                OcrRecipeCandidateId,
                                SortOrder,
                                RawLine,
                                RawAmount,
                                RawIngredientName,
                                NormalizedAmountId,
                                NormalizedIngredientId,
                                Confidence,
                                ParseWarnings
                            )
                            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                            """,
                            (
                                candidate_id,
                                to_int(ing.get("SortOrder"), default=1),
                                raw_line,
                                blank_to_none(ing.get("RawAmount")),
                                blank_to_none(ing.get("RawIngredientName")),
                                to_int_or_none(ing.get("NormalizedAmountId")),
                                to_int_or_none(ing.get("NormalizedIngredientId")),
                                to_float_or_none(ing.get("Confidence")),
                                blank_to_none(ing.get("ParseWarnings")),
                            ),
                        )

                    for step in steps:
                        instruction = (step.get("Instruction") or "").strip()
                        if not instruction:
                            continue
                        cur.execute(
                            """
                            INSERT INTO OcrStepCandidates
                            (
                                OcrRecipeCandidateId,
                                StepNumber,
                                Instruction,
                                Confidence
                            )
                            VALUES (?, ?, ?, ?)
                            """,
                            (
                                candidate_id,
                                to_int(step.get("StepNumber"), default=1),
                                instruction,
                                to_float_or_none(step.get("Confidence")),
                            ),
                        )

                    conn.commit()
                except Exception:
                    conn.rollback()
                    raise

    return Handler


def blank_to_none(value):
    if value is None:
        return None
    value = str(value).strip()
    return value if value else None


def to_int(value, default=0):
    try:
        return int(value)
    except Exception:
        return default


def to_int_or_none(value):
    if value in ("", None):
        return None
    try:
        return int(value)
    except Exception:
        return None


def to_float_or_none(value):
    if value in ("", None):
        return None
    try:
        return float(value)
    except Exception:
        return None


INDEX_HTML = """<!doctype html>
<html>
<head>
  <meta charset="utf-8" />
  <title>OCR Review UI</title>
  <style>
    body { font-family: system-ui, -apple-system, Segoe UI, Roboto, sans-serif; margin: 0; }
    .wrap { display: grid; grid-template-columns: 280px 320px 1fr; height: 100vh; }
    .pane { border-right: 1px solid #ddd; overflow: auto; padding: 12px; }
    .pane:last-child { border-right: none; }
    h3 { margin: 8px 0; }
    .row { margin-bottom: 8px; }
    label { font-size: 12px; color: #444; display: block; margin-bottom: 3px; }
    input, textarea, select { width: 100%; box-sizing: border-box; padding: 6px; font-size: 13px; }
    textarea { min-height: 70px; }
    table { width: 100%; border-collapse: collapse; margin-top: 8px; }
    th, td { border: 1px solid #ddd; padding: 4px; vertical-align: top; }
    th { background: #f5f5f5; font-size: 12px; }
    button { margin-right: 8px; padding: 6px 10px; }
    .list { font-size: 13px; }
    .item { padding: 6px; border: 1px solid #ddd; margin-bottom: 6px; cursor: pointer; }
    .item:hover { background: #f9f9f9; }
    .muted { color: #666; font-size: 12px; }
    .ok { color: #0a7f2e; font-weight: 600; }
    .err { color: #b42318; font-weight: 600; }
  </style>
</head>
<body>
  <div class="wrap">
    <div class="pane">
      <h3>Imports</h3>
      <div id="imports" class="list"></div>
    </div>
    <div class="pane">
      <h3>Items + Candidates</h3>
      <div id="items" class="list"></div>
    </div>
    <div class="pane">
      <h3>Candidate Editor</h3>
      <div id="status" class="muted">Select a candidate to edit.</div>
      <div class="row"><label>Cocktail Name</label><input id="cocktailName" /></div>
      <div class="row"><label>Source Recipe Name</label><input id="sourceRecipeName" /></div>
      <div class="row"><label>Parsed Time Period</label><input id="parsedTimePeriod" /></div>
      <div class="row"><label>Parsed Flavor Profile</label><input id="parsedFlavorProfile" /></div>
      <div class="row"><label>Status</label><input id="candidateStatus" /></div>
      <div class="row"><label>Confidence</label><input id="candidateConfidence" /></div>
      <div class="row"><label>Method Text</label><textarea id="methodText"></textarea></div>
      <div class="row"><label>Parse Warnings</label><textarea id="parseWarnings"></textarea></div>

      <h4>Ingredients</h4>
      <button onclick="addIngredient()">Add Ingredient Row</button>
      <table id="ingredientsTbl">
        <thead><tr><th>Sort</th><th>Raw Line</th><th>Raw Amount</th><th>Raw Ingredient</th><th>AmountId</th><th>IngredientId</th><th>Conf</th><th>Warn</th><th>Del</th></tr></thead>
        <tbody></tbody>
      </table>

      <h4>Steps</h4>
      <button onclick="addStep()">Add Step Row</button>
      <table id="stepsTbl">
        <thead><tr><th>#</th><th>Instruction</th><th>Conf</th><th>Del</th></tr></thead>
        <tbody></tbody>
      </table>

      <div style="margin-top:12px;">
        <button onclick="saveCandidate()">Save</button>
      </div>
    </div>
  </div>

  <script>
    let selectedImportId = null;
    let selectedCandidateId = null;

    async function api(path, opts={}) {
      const res = await fetch(path, opts);
      const data = await res.json();
      if (!res.ok) throw new Error(data.message || "Request failed");
      return data;
    }

    function setStatus(text, ok=true) {
      const el = document.getElementById("status");
      el.textContent = text;
      el.className = ok ? "ok" : "err";
    }

    async function loadImports() {
      const imports = await api("/api/imports");
      const wrap = document.getElementById("imports");
      wrap.innerHTML = "";
      for (const imp of imports) {
        const div = document.createElement("div");
        div.className = "item";
        div.innerHTML = `<b>#${imp.Id}</b> ${imp.ImportName}<div class="muted">${imp.ImportType} | ${imp.Status}</div>`;
        div.onclick = () => loadItems(imp.Id);
        wrap.appendChild(div);
      }
    }

    async function loadItems(importId) {
      selectedImportId = importId;
      const items = await api(`/api/imports/${importId}/items`);
      const wrap = document.getElementById("items");
      wrap.innerHTML = "";
      for (const item of items) {
        const section = document.createElement("div");
        section.className = "item";
        section.innerHTML = `<b>Item #${item.Id}</b><div class="muted">${item.Status} | candidates=${item.CandidateCount}</div><div class="muted">${item.ItemKey || ""}</div>`;
        wrap.appendChild(section);

        const candidates = await api(`/api/items/${item.Id}/candidates`);
        for (const c of candidates) {
          const cdiv = document.createElement("div");
          cdiv.className = "item";
          cdiv.style.marginLeft = "12px";
          cdiv.innerHTML = `Candidate #${c.Id}: <b>${c.CocktailName}</b><div class="muted">${c.Status}${c.ParsedTimePeriod ? " | " + c.ParsedTimePeriod : ""}${c.ParsedFlavorProfile ? " | " + c.ParsedFlavorProfile : ""}</div>`;
          cdiv.onclick = () => loadCandidate(c.Id);
          wrap.appendChild(cdiv);
        }
      }
    }

    function tdInput(val="") {
      const td = document.createElement("td");
      const inp = document.createElement("input");
      inp.value = val ?? "";
      td.appendChild(inp);
      return td;
    }

    function tdDeleteBtn() {
      const td = document.createElement("td");
      const btn = document.createElement("button");
      btn.textContent = "X";
      btn.onclick = (e) => e.target.closest("tr").remove();
      td.appendChild(btn);
      return td;
    }

    function addIngredientRow(data={}) {
      const tr = document.createElement("tr");
      tr.appendChild(tdInput(data.SortOrder ?? ""));
      tr.appendChild(tdInput(data.RawLine ?? ""));
      tr.appendChild(tdInput(data.RawAmount ?? ""));
      tr.appendChild(tdInput(data.RawIngredientName ?? ""));
      tr.appendChild(tdInput(data.NormalizedAmountId ?? ""));
      tr.appendChild(tdInput(data.NormalizedIngredientId ?? ""));
      tr.appendChild(tdInput(data.Confidence ?? ""));
      tr.appendChild(tdInput(data.ParseWarnings ?? ""));
      tr.appendChild(tdDeleteBtn());
      document.querySelector("#ingredientsTbl tbody").appendChild(tr);
    }

    function addStepRow(data={}) {
      const tr = document.createElement("tr");
      tr.appendChild(tdInput(data.StepNumber ?? ""));
      tr.appendChild(tdInput(data.Instruction ?? ""));
      tr.appendChild(tdInput(data.Confidence ?? ""));
      tr.appendChild(tdDeleteBtn());
      document.querySelector("#stepsTbl tbody").appendChild(tr);
    }

    function addIngredient() { addIngredientRow(); }
    function addStep() { addStepRow(); }

    async function loadCandidate(candidateId) {
      selectedCandidateId = candidateId;
      const c = await api(`/api/candidates/${candidateId}`);
      document.getElementById("cocktailName").value = c.CocktailName || "";
      document.getElementById("sourceRecipeName").value = c.SourceRecipeName || "";
      document.getElementById("parsedTimePeriod").value = c.ParsedTimePeriod || "";
      document.getElementById("parsedFlavorProfile").value = c.ParsedFlavorProfile || "";
      document.getElementById("candidateStatus").value = c.Status || "Pending";
      document.getElementById("candidateConfidence").value = c.Confidence ?? "";
      document.getElementById("methodText").value = c.MethodText || "";
      document.getElementById("parseWarnings").value = c.ParseWarnings || "";

      const ingBody = document.querySelector("#ingredientsTbl tbody");
      const stepBody = document.querySelector("#stepsTbl tbody");
      ingBody.innerHTML = "";
      stepBody.innerHTML = "";
      for (const i of c.Ingredients || []) addIngredientRow(i);
      for (const s of c.Steps || []) addStepRow(s);
      setStatus(`Editing candidate #${candidateId}`, true);
    }

    function rowsFromTable(selector, cols) {
      const rows = [];
      const trs = document.querySelectorAll(selector + " tbody tr");
      for (const tr of trs) {
        const vals = [...tr.querySelectorAll("td input")].map(i => i.value);
        const row = {};
        cols.forEach((c, idx) => row[c] = vals[idx] ?? "");
        rows.push(row);
      }
      return rows;
    }

    async function saveCandidate() {
      if (!selectedCandidateId) {
        setStatus("No candidate selected.", false);
        return;
      }

      const payload = {
        Candidate: {
          CocktailName: document.getElementById("cocktailName").value,
          SourceRecipeName: document.getElementById("sourceRecipeName").value,
          ParsedTimePeriod: document.getElementById("parsedTimePeriod").value,
          ParsedFlavorProfile: document.getElementById("parsedFlavorProfile").value,
          Status: document.getElementById("candidateStatus").value,
          Confidence: document.getElementById("candidateConfidence").value,
          MethodText: document.getElementById("methodText").value,
          ParseWarnings: document.getElementById("parseWarnings").value
        },
        Ingredients: rowsFromTable("#ingredientsTbl", ["SortOrder","RawLine","RawAmount","RawIngredientName","NormalizedAmountId","NormalizedIngredientId","Confidence","ParseWarnings"]),
        Steps: rowsFromTable("#stepsTbl", ["StepNumber","Instruction","Confidence"])
      };

      try {
        await api(`/api/candidates/${selectedCandidateId}`, {
          method: "PUT",
          headers: {"Content-Type":"application/json"},
          body: JSON.stringify(payload)
        });
        setStatus(`Saved candidate #${selectedCandidateId}`, true);
        if (selectedImportId) loadItems(selectedImportId);
      } catch (e) {
        setStatus(e.message, false);
      }
    }

    loadImports().catch(e => setStatus(e.message, false));
  </script>
</body>
</html>
"""


def main():
    parser = argparse.ArgumentParser(description="Local OCR candidate review/edit UI")
    parser.add_argument("--db", default=DEFAULT_DB, help="Path to SQLite database")
    parser.add_argument("--host", default="127.0.0.1", help="Host to bind")
    parser.add_argument("--port", type=int, default=8765, help="Port to bind")
    args = parser.parse_args()

    server = ThreadingHTTPServer((args.host, args.port), make_handler(args.db))
    print(f"OCR Review UI running on http://{args.host}:{args.port}")
    print(f"DB: {args.db}")
    server.serve_forever()


if __name__ == "__main__":
    main()
