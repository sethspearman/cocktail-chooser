
-- Insert statement for CocktailSource
INSERT INTO CocktailSource (Name, SourceType, Url) 
SELECT 'Cocktail Recipe Book', 'Book', NULL
WHERE NOT EXISTS (SELECT 1 FROM CocktailSource WHERE Name = 'Cocktail Recipe Book');

-- Insert statement for Cocktails
INSERT INTO Cocktails (Name, Description, Method, GlassTypeId, TimePeriodId, IsPopular, CocktailSourceID) 
SELECT 'Mojito', 'Light and Refreshing', 'Lightly muddle mint leaves in the base of a shaker. Add remaining ingredients and ice. Shake. Strain into an ice-filled collins glass. Garnish with a mint sprig.', (SELECT Id FROM GlassTypes WHERE Name = 'Collins'), (SELECT Id FROM CocktailTimePeriods WHERE Name = 'Classic/Tropical'), 0, 1
WHERE NOT EXISTS (SELECT 1 FROM Cocktails WHERE Name = 'Mojito');

-- Insert statements for Ingredients and Amounts
INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Mint leaves', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Mint leaves');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '3 leaves')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '3 leaves', NULL
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Mojito')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Mint leaves'), (SELECT Id FROM Amounts WHERE MeasurementName = '3 leaves')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Mojito') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Mint leaves') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '3 leaves'));

INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'White rum', 1, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'White rum');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '2 fl oz', 2.0
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Mojito')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'White rum'), (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Mojito') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'White rum') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz'));

INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Freshly-squeezed lime juice', 2, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Freshly-squeezed lime juice');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '0.75 fl oz')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '0.75 fl oz', 0.75
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Mojito')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Freshly-squeezed lime juice'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.75 fl oz')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Mojito') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Freshly-squeezed lime juice') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.75 fl oz'));

INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Simple syrup', 3, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Simple syrup');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = '1 fl oz')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT '1 fl oz', 1.0
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Mojito')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Simple syrup'), (SELECT Id FROM Amounts WHERE MeasurementName = '1 fl oz')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Mojito') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Simple syrup') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '1 fl oz'));

INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
SELECT 'Club soda', 4, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Club soda');

WITH AmountCheck AS (SELECT Id FROM Amounts WHERE MeasurementName = 'to top')
INSERT INTO Amounts (MeasurementName, Ounces) 
SELECT 'to top', NULL
WHERE NOT EXISTS (SELECT 1 FROM AmountCheck);

WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Mojito')
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Club soda'), (SELECT Id FROM Amounts WHERE MeasurementName = 'to top')
FROM LastCocktail
WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Mojito') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Club soda') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = 'to top'));
