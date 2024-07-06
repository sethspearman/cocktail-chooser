
-- Insert statement for CocktailSource
INSERT INTO CocktailSource (Name, SourceType, Url) 
SELECT 'Cocktail Recipe Book', 'Book', NULL
WHERE NOT EXISTS (SELECT 1 FROM CocktailSource WHERE Name = 'Cocktail Recipe Book');

-- Insert statement for Cocktails
INSERT INTO Cocktails (Name, Description, Method, GlassTypeId, TimePeriodId, IsPopular, CocktailSourceID) 
SELECT 'Eclipse', 'Fruity and Refreshing', 'Muddle raspberries in the base of a shaker. Add other ingredients to the shaker with ice. Strain into an ice-filled collins glass. Garnish with a raspberry and sprig of mint.', (SELECT Id FROM GlassTypes WHERE Name = 'Collins'), (SELECT Id FROM CocktailTimePeriods WHERE Name = 'Modern'), 0, 1
WHERE NOT EXISTS (SELECT 1 FROM Cocktails WHERE Name = 'Eclipse');

-- Insert statements for Ingredients and Amounts
INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Fresh raspberries', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Fresh raspberries');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '12')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '12', NULL
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Eclipse')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Fresh raspberries'), (SELECT Id FROM Amounts WHERE MeasurementName = '12')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Eclipse') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Fresh raspberries') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '12'));

INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Bourbon', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Bourbon');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '2 fl oz', 2.0
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Eclipse')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Bourbon'), (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Eclipse') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Bourbon') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz'));

INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Blackberry liqueur', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Blackberry liqueur');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '1 fl oz')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '1 fl oz', 1.0
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Eclipse')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Blackberry liqueur'), (SELECT Id FROM Amounts WHERE MeasurementName = '1 fl oz')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Eclipse') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Blackberry liqueur') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '1 fl oz'));

INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Freshly-squeezed lime juice', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Freshly-squeezed lime juice');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '0.5 fl oz', 0.5
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Eclipse')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Freshly-squeezed lime juice'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Eclipse') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Freshly-squeezed lime juice') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz'));

INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Cranberry juice', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Cranberry juice');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '2 fl oz', 2.0
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Eclipse')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Cranberry juice'), (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Eclipse') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Cranberry juice') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz'));
