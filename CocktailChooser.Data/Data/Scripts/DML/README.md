# DML Script Workflow For Additional Cocktail Data

Use this folder for idempotent data-load scripts after base source data is already in the database.

## Files

- `_template_cocktail_insert.sql`
  - Copy this as your starting point for each cocktail or batch file.
  - It is aligned with current schema (`CocktailSourceId`, `CocktailSteps`, `AmountText`).
- `../apply_dml_batch.py`
  - Applies one or more SQL scripts to your SQLite DB in sorted order.

## Recommended Folder Convention

Create one folder per source and keep scripts ordered:

- `CocktailChooser.Data/Data/Scripts/DML/source_2/001_<name>.sql`
- `CocktailChooser.Data/Data/Scripts/DML/source_2/002_<name>.sql`

This makes each source import repeatable and easy to audit.

## Run A Batch

From repo root:

```bash
python3 CocktailChooser.Data/Data/Scripts/apply_dml_batch.py \
  --db CocktailChooser.Data/Data/CocktailChooser.db \
  --pattern "CocktailChooser.Data/Data/Scripts/DML/source_2/*.sql"
```

## Notes

- Keep scripts idempotent (`WHERE NOT EXISTS`) so reruns are safe.
- For unknown amounts, use:
  - `AmountId = NULL`
  - `AmountText = '<raw value>'`
- Keep `SortOrder` stable for ingredient ordering.
