PRAGMA foreign_keys = ON;
BEGIN TRANSACTION;

ALTER TABLE CocktailIngredients ADD COLUMN AmountText TEXT;

COMMIT;
