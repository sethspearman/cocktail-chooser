-- Template: Idempotent cocktail DML insert for current schema.
-- Copy this file and replace placeholder values per cocktail.
-- Current canonical tables: Cocktails, CocktailSource, CocktailIngredients, CocktailSteps.

BEGIN TRANSACTION;

-- 1) Ensure cocktail source exists
INSERT INTO CocktailSource
(
    Name,
    SourceType,
    Publisher,
    Author,
    Edition,
    Language,
    Url,
    Notes,
    IsBuiltIn
)
SELECT
    'SOURCE NAME',
    'Book',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    0
WHERE NOT EXISTS
(
    SELECT 1
    FROM CocktailSource
    WHERE Name = 'SOURCE NAME'
      AND SourceType = 'Book'
);

-- 2) Ensure cocktail exists
INSERT INTO Cocktails
(
    Name,
    Description,
    Method,
    FlavorProfile,
    GlassTypeId,
    TimePeriodId,
    IsPopular,
    CocktailSourceId,
    SourceRecipeName,
    AttributionText,
    SourceUrl,
    Notes,
    IsUserSubmitted
)
SELECT
    'COCKTAIL NAME',
    'Short flavor or style description',
    'Full method text for the cocktail.',
    'Flavor profile (optional)',
    (SELECT Id FROM GlassTypes WHERE Name = 'Coupe'),
    (SELECT Id FROM CocktailTimePeriods WHERE Name = 'Classic'),
    0,
    (SELECT Id FROM CocktailSource WHERE Name = 'SOURCE NAME' AND SourceType = 'Book'),
    'SOURCE RECIPE NAME',
    'Optional attribution text',
    NULL,
    NULL,
    0
WHERE NOT EXISTS
(
    SELECT 1
    FROM Cocktails
    WHERE Name = 'COCKTAIL NAME'
      AND ifnull(CocktailSourceId, -1) = ifnull(
          (SELECT Id FROM CocktailSource WHERE Name = 'SOURCE NAME' AND SourceType = 'Book'),
          -1
      )
);

-- 3) Ensure ingredients and amounts exist, then link ingredients to cocktail.
-- Ingredient row #1 with recognized amount:
INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription)
SELECT 'Bourbon', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Bourbon');

INSERT INTO Amounts (MeasurementName, Ounces)
SELECT '2 oz', 2.0
WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '2 oz');

INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId, AmountText, SortOrder)
SELECT
    c.Id,
    i.Id,
    a.Id,
    NULL,
    1
FROM Cocktails c
JOIN Ingredients i ON i.Name = 'Bourbon'
JOIN Amounts a ON a.MeasurementName = '2 oz'
WHERE c.Name = 'COCKTAIL NAME'
  AND NOT EXISTS
  (
      SELECT 1
      FROM CocktailIngredients ci
      WHERE ci.CocktailId = c.Id
        AND ci.IngredientId = i.Id
        AND ifnull(ci.AmountId, -1) = ifnull(a.Id, -1)
        AND ifnull(ci.AmountText, '') = ''
        AND ifnull(ci.SortOrder, -1) = 1
  );

-- Ingredient row #2 with unmatched/free-text amount (AmountId NULL, AmountText set):
INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription)
SELECT 'Angostura bitters', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Angostura bitters');

INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId, AmountText, SortOrder)
SELECT
    c.Id,
    i.Id,
    NULL,
    '2 dashes',
    2
FROM Cocktails c
JOIN Ingredients i ON i.Name = 'Angostura bitters'
WHERE c.Name = 'COCKTAIL NAME'
  AND NOT EXISTS
  (
      SELECT 1
      FROM CocktailIngredients ci
      WHERE ci.CocktailId = c.Id
        AND ci.IngredientId = i.Id
        AND ci.AmountId IS NULL
        AND ifnull(ci.AmountText, '') = '2 dashes'
        AND ifnull(ci.SortOrder, -1) = 2
  );

-- 4) Insert ordered cocktail steps
INSERT INTO CocktailSteps (CocktailId, StepNumber, Instruction)
SELECT c.Id, 1, 'Add all ingredients to a mixing glass with ice.'
FROM Cocktails c
WHERE c.Name = 'COCKTAIL NAME'
  AND NOT EXISTS
  (
      SELECT 1 FROM CocktailSteps cs
      WHERE cs.CocktailId = c.Id
        AND cs.StepNumber = 1
  );

INSERT INTO CocktailSteps (CocktailId, StepNumber, Instruction)
SELECT c.Id, 2, 'Stir until chilled, then strain into a chilled glass.'
FROM Cocktails c
WHERE c.Name = 'COCKTAIL NAME'
  AND NOT EXISTS
  (
      SELECT 1 FROM CocktailSteps cs
      WHERE cs.CocktailId = c.Id
        AND cs.StepNumber = 2
  );

COMMIT;
