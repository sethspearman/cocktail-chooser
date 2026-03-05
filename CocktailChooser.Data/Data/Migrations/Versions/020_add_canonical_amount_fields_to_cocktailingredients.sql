PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

ALTER TABLE CocktailIngredients ADD COLUMN CanonicalAmountValue REAL;
ALTER TABLE CocktailIngredients ADD COLUMN CanonicalAmountUnit TEXT;
ALTER TABLE CocktailIngredients ADD COLUMN AmountOriginalText TEXT;

UPDATE CocktailIngredients
SET AmountOriginalText = CASE
    WHEN AmountText IS NOT NULL AND trim(AmountText) <> '' THEN trim(AmountText)
    WHEN AmountId IS NOT NULL THEN (
        SELECT trim(a.MeasurementName)
        FROM Amounts a
        WHERE a.Id = CocktailIngredients.AmountId
        LIMIT 1
    )
    ELSE NULL
END
WHERE AmountOriginalText IS NULL;

UPDATE CocktailIngredients
SET
    CanonicalAmountValue = (
        SELECT a.Ounces
        FROM Amounts a
        WHERE a.Id = CocktailIngredients.AmountId
        LIMIT 1
    ),
    CanonicalAmountUnit = CASE
        WHEN AmountId IS NOT NULL THEN 'oz'
        ELSE CanonicalAmountUnit
    END
WHERE AmountId IS NOT NULL
  AND CanonicalAmountValue IS NULL;

UPDATE CocktailIngredients
SET CanonicalAmountUnit = 'top'
WHERE CanonicalAmountUnit IS NULL
  AND lower(trim(COALESCE(AmountOriginalText, AmountText, ''))) IN ('to top');

UPDATE CocktailIngredients
SET CanonicalAmountUnit = 'rinse'
WHERE CanonicalAmountUnit IS NULL
  AND lower(trim(COALESCE(AmountOriginalText, AmountText, ''))) IN ('to rinse', 'for rinse');

COMMIT;
PRAGMA foreign_keys = ON;
