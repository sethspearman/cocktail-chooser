
-- Rum Caipirinha
INSERT INTO Cocktails (Name, Description, Method) VALUES ('Rum Caipirinha', 'Curdy and spirit-forward', 'Muddle syrup and lime wedges in the base of a shaker. Add rum and ice to the shaker. Shake. Strain into an ice-filled old-fashioned glass. Garnish with a lime wedge.');
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId) VALUES ((SELECT Id FROM Cocktails WHERE Name='Rum Caipirinha'), (SELECT Id FROM Ingredients WHERE Name='Spiced rum'), (SELECT Id FROM Amounts WHERE MeasurementName='1½ fl oz'));
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId) VALUES ((SELECT Id FROM Cocktails WHERE Name='Rum Caipirinha'), (SELECT Id FROM Ingredients WHERE Name='lime wedges'), (SELECT Id FROM Amounts WHERE MeasurementName='3'));
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId) VALUES ((SELECT Id FROM Cocktails WHERE Name='Rum Caipirinha'), (SELECT Id FROM Ingredients WHERE Name='Simple syrup'), (SELECT Id FROM Amounts WHERE MeasurementName='¾ fl oz'));
INSERT INTO CocktailRecipes (CocktailId, StepNumber, Instruction) VALUES ((SELECT Id FROM Cocktails WHERE Name='Rum Caipirinha'), 1, 'Muddle syrup and lime wedges in the base of a shaker');
INSERT INTO CocktailRecipes (CocktailId, StepNumber, Instruction) VALUES ((SELECT Id FROM Cocktails WHERE Name='Rum Caipirinha'), 2, 'Add rum and ice to the shaker');
INSERT INTO CocktailRecipes (CocktailId, StepNumber, Instruction) VALUES ((SELECT Id FROM Cocktails WHERE Name='Rum Caipirinha'), 3, 'Shake');
INSERT INTO CocktailRecipes (CocktailId, StepNumber, Instruction) VALUES ((SELECT Id FROM Cocktails WHERE Name='Rum Caipirinha'), 4, 'Strain into an ice-filled old-fashioned glass');
INSERT INTO CocktailRecipes (CocktailId, StepNumber, Instruction) VALUES ((SELECT Id FROM Cocktails WHERE Name='Rum Caipirinha'), 5, 'Garnish with a lime wedge');

-- Rum Dum
INSERT INTO Cocktails (Name, Description, Method) VALUES ('Rum Dum', 'Sweet and Refreshing', 'Combine first four ingredients in a shaker with ice. Shake well. Strain into an ice-filled Collins glass. Top with Dark rum.');
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId) VALUES ((SELECT Id FROM Cocktails WHERE Name='Rum Dum'), (SELECT Id FROM Ingredients WHERE Name='White rum'), (SELECT Id FROM Amounts WHERE MeasurementName='1½ fl oz'));
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId) VALUES ((SELECT Id FROM Cocktails WHERE Name='Rum Dum'), (SELECT Id FROM Ingredients WHERE Name='Egg white'), (SELECT Id FROM Amounts WHERE MeasurementName='1'));
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId) VALUES ((SELECT Id FROM Cocktails WHERE Name='Rum Dum'), (SELECT Id FROM Ingredients WHERE Name='Freshly-squeezed lemon juice'), (SELECT Id FROM Amounts WHERE MeasurementName='1½ fl oz'));
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId) VALUES ((SELECT Id FROM Cocktails WHERE Name='Rum Dum'), (SELECT Id FROM Ingredients WHERE Name='Simple syrup'), (SELECT Id FROM Amounts WHERE MeasurementName='¾ fl oz'));
INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId) VALUES ((SELECT Id FROM Cocktails WHERE Name='Rum Dum'), (SELECT Id FROM Ingredients WHERE Name='Dark rum'), (SELECT Id FROM Amounts WHERE MeasurementName='½ fl oz'));
INSERT INTO CocktailRecipes (CocktailId, StepNumber, Instruction) VALUES ((SELECT Id FROM Cocktails WHERE Name='Rum Dum'), 1, 'Combine first four ingredients in a shaker with ice');
INSERT INTO CocktailRecipes (CocktailId, StepNumber, Instruction) VALUES ((SELECT Id FROM Cocktails WHERE Name='Rum Dum'), 2, 'Shake well');
INSERT INTO CocktailRecipes (CocktailId, StepNumber, Instruction) VALUES ((SELECT Id FROM Cocktails WHERE Name='Rum Dum'), 3, 'Strain into an ice-filled Collins glass');
INSERT INTO CocktailRecipes (CocktailId, StepNumber, Instruction) VALUES ((SELECT Id FROM Cocktails WHERE Name='Rum Dum'), 4, 'Top with Dark rum');
