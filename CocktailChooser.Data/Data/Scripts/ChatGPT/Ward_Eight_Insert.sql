
-- Insert statement for CocktailSource
INSERT INTO CocktailSource (Name, SourceType, Url) 
SELECT 'Cocktail Recipe Book', 'Book', NULL
WHERE NOT EXISTS (SELECT 1 FROM CocktailSource WHERE Name = 'Cocktail Recipe Book');

-- Insert statement for Cocktails
INSERT INTO Cocktails (Name, Description, Method, GlassTypeId, TimePeriodId, IsPopular, CocktailSourceID) 
SELECT 'Ward Eight', 'Sweet and Citrusy', 'Combine ingredients in a shaker with ice. Shake. Strain into a chilled coupe glass. Garnish with an orange slice and a cherry.', (SELECT Id FROM GlassTypes WHERE Name = 'Coupe'), (SELECT Id FROM CocktailTimePeriods WHERE Name = 'Classic'), 0, 1
WHERE NOT EXISTS (SELECT 1 FROM Cocktails WHERE Name = 'Ward Eight');

-- Insert statements for Ingredients and Amounts
INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Bourbon', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Bourbon');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '2 fl oz', 2.0
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Ward Eight')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Bourbon'), (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Ward Eight') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Bourbon') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz'));

INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Freshly-squeezed lemon juice', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Freshly-squeezed lemon juice');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '0.5 fl oz', 0.5
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Ward Eight')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Freshly-squeezed lemon juice'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Ward Eight') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Freshly-squeezed lemon juice') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz'));

INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Freshly-squeezed orange juice', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Freshly-squeezed orange juice');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '0.5 fl oz', 0.5
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Ward Eight')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Freshly-squeezed orange juice'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Ward Eight') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Freshly-squeezed orange juice') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz'));

INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Grenadine', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Grenadine');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '0.5 fl oz', 0.5
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Ward Eight')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Grenadine'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Ward Eight') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Grenadine') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz'));
