
-- Insert statement for CocktailSource
INSERT INTO CocktailSource (Name, SourceType, Url) 
SELECT 'Cocktail Recipe Book', 'Book', NULL
WHERE NOT EXISTS (SELECT 1 FROM CocktailSource WHERE Name = 'Cocktail Recipe Book');

-- Insert statement for Cocktails
INSERT INTO Cocktails (Name, Description, Method, GlassTypeId, TimePeriodId, IsPopular, CocktailSourceID) 
SELECT 'Hebridean Shores', 'Fruity and Citrusy', 'Combine first three ingredients in a cocktail shaker with ice. Shake well. Strain into an ice-filled Collins glass. Top with beer. Garnish with a grapefruit wedge.', (SELECT Id FROM GlassTypes WHERE Name = 'Collins'), (SELECT Id FROM CocktailTimePeriods WHERE Name = 'Modern'), 0, 1
WHERE NOT EXISTS (SELECT 1 FROM Cocktails WHERE Name = 'Hebridean Shores');

-- Insert statements for Ingredients and Amounts
INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Scotch', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Scotch');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '1 fl oz')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '1 fl oz', 1.0
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Hebridean Shores')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Scotch'), (SELECT Id FROM Amounts WHERE MeasurementName = '1 fl oz')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Hebridean Shores') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Scotch') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '1 fl oz'));

INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Grapefruit juice', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Grapefruit juice');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '0.5 fl oz', 0.5
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Hebridean Shores')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Grapefruit juice'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Hebridean Shores') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Grapefruit juice') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz'));

INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Peach Schnapps', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Peach Schnapps');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '0.5 fl oz', 0.5
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Hebridean Shores')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Peach Schnapps'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Hebridean Shores') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Peach Schnapps') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz'));

INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Hoppy beer', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Hoppy beer');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = 'to top')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT 'to top', NULL
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Hebridean Shores')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Hoppy beer'), (SELECT Id FROM Amounts WHERE MeasurementName = 'to top')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Hebridean Shores') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Hoppy beer') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = 'to top'));
