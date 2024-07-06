
-- Insert statement for CocktailSource
INSERT INTO CocktailSource (Name, SourceType, Url) 
SELECT 'Cocktail Recipe Book', 'Book', NULL
WHERE NOT EXISTS (SELECT 1 FROM CocktailSource WHERE Name = 'Cocktail Recipe Book');

-- Insert statement for Cocktails
INSERT INTO Cocktails (Name, Description, Method, GlassTypeId, TimePeriodId, IsPopular, CocktailSourceID) 
SELECT 'Kentucky Buck', 'Fruity and Spicy', 'Muddle the strawberry in the base of a shaker. Add next four ingredients and ice to the shaker. Shake well. Fine strain into an ice-filled Collins glass. Top with ginger beer. Garnish with a lemon wheel and strawberry slice.', (SELECT Id FROM GlassTypes WHERE Name = 'Collins'), (SELECT Id FROM CocktailTimePeriods WHERE Name = 'Modern'), 0, 1
WHERE NOT EXISTS (SELECT 1 FROM Cocktails WHERE Name = 'Kentucky Buck');

-- Insert statements for Ingredients and Amounts
INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Fresh, hulled strawberry', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Fresh, hulled strawberry');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '1')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '1', NULL
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Kentucky Buck')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Fresh, hulled strawberry'), (SELECT Id FROM Amounts WHERE MeasurementName = '1')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Kentucky Buck') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Fresh, hulled strawberry') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '1'));

INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Bourbon', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Bourbon');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '2 fl oz', 2.0
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Kentucky Buck')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Bourbon'), (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Kentucky Buck') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Bourbon') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz'));

INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Freshly-squeezed lemon juice', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Freshly-squeezed lemon juice');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '0.5 fl oz', 0.5
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Kentucky Buck')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Freshly-squeezed lemon juice'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Kentucky Buck') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Freshly-squeezed lemon juice') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz'));

INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Simple syrup', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Simple syrup');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '0.5 fl oz', 0.5
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Kentucky Buck')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Simple syrup'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Kentucky Buck') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Simple syrup') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz'));

INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Aromatic bitters', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Aromatic bitters');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '2 Dashes')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '2 Dashes', 0.0625
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Kentucky Buck')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Aromatic bitters'), (SELECT Id FROM Amounts WHERE MeasurementName = '2 Dashes')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Kentucky Buck') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Aromatic bitters') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '2 Dashes'));

INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Ginger beer', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Ginger beer');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = 'to top')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT 'to top', NULL
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Kentucky Buck')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Ginger beer'), (SELECT Id FROM Amounts WHERE MeasurementName = 'to top')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Kentucky Buck') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Ginger beer') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = 'to top'));
