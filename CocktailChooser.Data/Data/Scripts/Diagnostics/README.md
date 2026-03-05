# Data Diagnostics

This folder contains read-only SQL checks for data quality.

## Ingredient checks

Run:

```bash
sqlite3 CocktailChooser.Data/Data/CocktailChooser.db \
  ".read CocktailChooser.Data/Data/Scripts/Diagnostics/ingredient_data_quality_check.sql"
```

What it reports:

- Potential mojibake in `Ingredients.Name` / `Ingredients.NormalizedName`
- Duplicate `NormalizedName` groups (legacy duplicates)
- Rows with null/blank `NormalizedName`
