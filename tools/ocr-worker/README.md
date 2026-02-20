# OCR Worker (Utility CLI)

A standalone utility to support incremental recipe OCR/data-entry outside the main app UI.

This worker operates on the existing staging tables:
- `OcrImports`
- `OcrImportItems`
- `OcrRecipeCandidates`
- `OcrIngredientCandidates`
- `OcrStepCandidates`

## Why this exists

- Lets you OCR/import books/cards gradually while the product UI/API evolves.
- Keeps OCR concerns separate from the API runtime.
- Reuses the same staging workflow that can later power end-user OCR features.

## Requirements

- Python 3.10+
- SQLite DB already migrated through OCR staging (`004_add_ocr_staging_tables.sql`)

## Usage

Default DB path:
`CocktailChooser.Data/Data/CocktailChooser.db`

## Review/Edit UI (recommended)

Run a local browser-based editor for OCR candidates:

```bash
python3 tools/ocr-worker/ocr_review_ui.py \
  --db /mnt/c/_CODE/cocktail-chooser/CocktailChooser.Data/Data/CocktailChooser.db \
  --port 8765
```

Then open:
`http://127.0.0.1:8765`

Features:
- Browse imports -> items -> candidates
- Edit candidate fields (`CocktailName`, `SourceRecipeName`, `ParsedTimePeriod`, `MethodText`, status/warnings/confidence)
- Edit ingredient rows and step rows directly in tables
- Save writes back to OCR staging tables in one transaction
- Use `publish-candidate` CLI command after edits to push into final recipe tables

### 1) Create an OCR import batch

```bash
python3 tools/ocr-worker/ocr_worker.py create-import \
  --source-id 1 \
  --name "Death & Co Batch 1" \
  --type Book \
  --file "death-and-co.pdf"
```

### 2) Add a text item directly

```bash
python3 tools/ocr-worker/ocr_worker.py add-item \
  --import-id 1 \
  --item-key "page-12" \
  --text "Gin and Tonic\nIngredients\n2 oz gin\nTonic water to top\nMethod\nBuild over ice."
```

### 3) Add a file-backed item (for OCR command mode)

```bash
python3 tools/ocr-worker/ocr_worker.py add-item \
  --import-id 1 \
  --item-key "/path/to/page-12.png" \
  --text ""
```

### 3b) Bulk-add all `.jpg` files from a folder (no `--text` needed)

```bash
python3 tools/ocr-worker/ocr_worker.py add-items \
  --import-id 1 \
  --folder "/path/to/scans"
```

### 4) Process pending items

Text-only mode (uses existing `RawText`):

```bash
python3 tools/ocr-worker/ocr_worker.py run-pending --import-id 1
```

OCR command mode (example with Tesseract):

```bash
python3 tools/ocr-worker/ocr_worker.py run-pending \
  --import-id 1 \
  --ocr-cmd 'tesseract "{input}" stdout'
```

`{input}` is replaced with `OcrImportItems.ItemKey`.

### 5) Review parsed candidates

```bash
python3 tools/ocr-worker/ocr_worker.py show-candidates --item-id 5
```

### 5b) List all items/candidates in an import (ID helper)

```bash
python3 tools/ocr-worker/ocr_worker.py list-import --import-id 1
```

Hide candidate rows if you only want item status:

```bash
python3 tools/ocr-worker/ocr_worker.py list-import --import-id 1 --no-include-candidates
```

### 6) Publish an approved candidate into final recipe tables

Default behavior requires candidate status = `Approved` (or `Published`) and will create missing cocktails/ingredients.

```bash
python3 tools/ocr-worker/ocr_worker.py publish-candidate --candidate-id 12
```

If you want to bypass approval check during early data loading:

```bash
python3 tools/ocr-worker/ocr_worker.py publish-candidate \
  --candidate-id 12 \
  --no-require-approved
```

## Notes

- This is a starter heuristic parser; expect manual review/editing.
- `run-pending` is idempotent for candidate rows per item; each run replaces prior candidates for that item.
- Parser now captures a likely `CocktailTimePeriod` line when present directly under cocktail title.
- Parser now captures a likely flavor descriptor line (stored as `ParsedFlavorProfile`) when present near the title.
- Parser can split multiple recipes from one OCR text when repeated `Ingredients` section headers are present.
- Keep source media in filesystem/object storage; DB should store references and extracted text.

## Next steps

- Add synonym dictionary for ingredient normalization.
- Add unit normalization mapping to `Amounts`.
- Add publish command: stage -> `Recipes` / `RecipeIngredients` / `RecipeSteps`.
