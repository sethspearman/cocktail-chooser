
-- Dark and Stormy
INSERT INTO Cocktails (Name, Description) VALUES ('Dark and Stormy', 'Spicy and Refreshing');
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId) VALUES ((SELECT Id FROM Cocktails WHERE Name='Dark and Stormy'), (SELECT Id FROM Ingredients WHERE Name='White rum'), (SELECT Id FROM Amounts WHERE MeasurementName='1½ fl oz'));
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId) VALUES ((SELECT Id FROM Cocktails WHERE Name='Dark and Stormy'), (SELECT Id FROM Ingredients WHERE Name='Ginger beer'), (SELECT Id FROM Amounts WHERE MeasurementName='to top'));
INSERT INTO CocktailRecipes (CocktailId, StepNumber, Instruction) VALUES ((SELECT Id FROM Cocktails WHERE Name='Dark and Stormy'), 1, 'Fill a highball glass with ice');
INSERT INTO CocktailRecipes (CocktailId, StepNumber, Instruction) VALUES ((SELECT Id FROM Cocktails WHERE Name='Dark and Stormy'), 2, 'Add rum');
INSERT INTO CocktailRecipes (CocktailId, StepNumber, Instruction) VALUES ((SELECT Id FROM Cocktails WHERE Name='Dark and Stormy'), 3, 'Top with ginger beer');
INSERT INTO CocktailRecipes (CocktailId, StepNumber, Instruction) VALUES ((SELECT Id FROM Cocktails WHERE Name='Dark and Stormy'), 4, 'Garnish with a lime wedge');

-- El Floridita
INSERT INTO Cocktails (Name, Description) VALUES ('El Floridita', 'Sweet and Fruity');
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId) VALUES ((SELECT Id FROM Cocktails WHERE Name='El Floridita'), (SELECT Id FROM Ingredients WHERE Name='White rum'), (SELECT Id FROM Amounts WHERE MeasurementName='2 fl oz'));
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId) VALUES ((SELECT Id FROM Cocktails WHERE Name='El Floridita'), (SELECT Id FROM Ingredients WHERE Name='Maraschino liqueur'), (SELECT Id FROM Amounts WHERE MeasurementName='½ fl oz'));
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId) VALUES ((SELECT Id FROM Cocktails WHERE Name='El Floridita'), (SELECT Id FROM Ingredients WHERE Name='Freshly-squeezed lime juice'), (SELECT Id FROM Amounts WHERE MeasurementName='¾ fl oz'));
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId) VALUES ((SELECT Id FROM Cocktails WHERE Name='El Floridita'), (SELECT Id FROM Ingredients WHERE Name='Freshly-squeezed grapefruit juice'), (SELECT Id FROM Amounts WHERE MeasurementName='¾ fl oz'));
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId) VALUES ((SELECT Id FROM Cocktails WHERE Name='El Floridita'), (SELECT Id FROM Ingredients WHERE Name='Simple syrup'), (SELECT Id FROM Amounts WHERE MeasurementName='¾ fl oz'));
INSERT INTO CocktailRecipes (CocktailId, StepNumber, Instruction) VALUES ((SELECT Id FROM Cocktails WHERE Name='El Floridita'), 1, 'Combine ingredients in a blender with 6 oz crushed ice');
INSERT INTO CocktailRecipes (CocktailId, StepNumber, Instruction) VALUES ((SELECT Id FROM Cocktails WHERE Name='El Floridita'), 2, 'Blend');
INSERT INTO CocktailRecipes (CocktailId, StepNumber, Instruction) VALUES ((SELECT Id FROM Cocktails WHERE Name='El Floridita'), 3, 'Pour into a martini glass');
INSERT INTO CocktailRecipes (CocktailId, StepNumber, Instruction) VALUES ((SELECT Id FROM Cocktails WHERE Name='El Floridita'), 4, 'Garnish with a cherry');
