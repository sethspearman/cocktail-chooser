# Taxonomy Review Export

This folder contains CSV exports to support editorial review of cocktail tags and categories.

## Files

- `cocktail_taxonomy_review.csv`
  Full export of all cocktails with current tag assignments.
- `cocktail_taxonomy_review_approved_only.csv`
  Easier review sheet containing only approved cocktails, sorted by `Source` then `CocktailName`.
- `tag_options_by_category.csv`
  Reference list of the current valid tags in each category.

## Recommended workflow

1. Open `cocktail_taxonomy_review_approved_only.csv` in Excel or Google Sheets.
2. Review one cocktail at a time.
3. Update the category columns with the tags you want assigned.
4. Keep the `CocktailId`, `CocktailName`, and `CanonicalKey` columns unchanged.
5. When finished, save as CSV and hand the file back for migration generation.

## Editing rules

- Use the category columns only:
  - `Aesthetic`
  - `Build Method`
  - `Build Pattern`
  - `Cocktail Family`
  - `Flavor Profile`
  - `Mood`
  - `Occasion`
  - `Strength`
  - `Texture`
- For multiple tags in one category, separate them with ` | `
- Prefer values that already exist in `tag_options_by_category.csv`
- Leave a category blank if no tag should be assigned
- Use `NotesForReview` for comments or follow-up questions

## Important note

These exports are designed for review and migration generation, not direct database import.

Once the sheet is reviewed, Codex can turn the final CSV into:

- tag assignment SQL
- new tag seed SQL if needed
- validation output for unknown tags or category mismatches
