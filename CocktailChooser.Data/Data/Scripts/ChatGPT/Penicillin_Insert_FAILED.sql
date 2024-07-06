
-- Insert statement for CocktailSource
INSERT INTO CocktailSource (Name, SourceType, Url) 
SELECT 'Cocktail Recipe Book', 'Book', NULL
WHERE NOT EXISTS (SELECT 1 FROM CocktailSource WHERE Name = 'Cocktail Recipe Book');

-- Insert statement for Cocktails
INSERT INTO Cocktails (Name, Description, Method, GlassTypeId, TimePeriodId, IsPopular, CocktailSourceID) 
SELECT 'Penicillin', 'Smoky and Spicy', 'Add ginger root to a shaker and muddle. Add remaining ingredients and ice. Shake. Fine strain into an ice-filled old-fashioned glass. Garnish with a lemon wheel.', (SELECT Id FROM GlassTypes WHERE Name = 'Old-fashioned'), (SELECT Id FROM CocktailTimePeriods WHERE Name = 'Modern'), 0, 1
WHERE NOT EXISTS (SELECT 1 FROM Cocktails WHERE Name = 'Penicillin');

-- Insert statements for Ingredients and Amounts
INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Scotch', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Scotch');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '2 fl oz', 2.0
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Penicillin')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Scotch'), (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Penicillin') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Scotch') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz'));

INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Ginger liqueur', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Ginger liqueur');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '1 oz')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '1 oz', 1.0
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Penicillin')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Ginger liqueur'), (SELECT Id FROM Amounts WHERE MeasurementName = '1 oz')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Penicillin') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Ginger liqueur') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '1 oz'));

INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Honey water', 1, NULL, '5 parts honey, 1 part water'
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Honey water');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '0.5 fl oz', 0.5
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Penicillin')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Honey water'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Penicillin') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Honey water') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz'));

INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Freshly-squeezed lemon juice', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Freshly-squeezed lemon juice');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '0.5 fl oz', 0.5
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Penicillin')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Freshly-squeezed lemon juice'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Penicillin') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Freshly-squeezed lemon juice') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz'));

INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Fresh ginger root', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Fresh ginger root');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '3 Slices')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '3 Slices', NULL
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Penicillin')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Fresh ginger root'), (SELECT Id FROM Amounts WHERE MeasurementName = '3 Slices')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Penicillin') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Fresh ginger root') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '3 Slices'));
