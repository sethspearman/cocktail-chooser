
INSERT INTO Cocktails (Name, Description, Method, GlassTypeId, TimePeriodId, IsPopular, CocktailSourceID)
VALUES ('Hot Toddy', 'Warm and Soothing', 'Press the cloves into the lemon wheel and set aside. Fill a mug halfway with boiling water. Add the lemon wheel with cloves and stir. Add the remaining ingredients and stir again', NULL, (SELECT Id FROM CocktailTimePeriods WHERE Period = 'Classic'), 0, 1);

INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
VALUES ((SELECT Id FROM Cocktails WHERE Name = 'Hot Toddy'), (SELECT Id FROM Ingredients WHERE Name = 'Cloves'), (SELECT Id FROM Amounts WHERE Description = '4')),
       ((SELECT Id FROM Cocktails WHERE Name = 'Hot Toddy'), (SELECT Id FROM Ingredients WHERE Name = 'Lemon wheel'), (SELECT Id FROM Amounts WHERE Description = '1')),
       ((SELECT Id FROM Cocktails WHERE Name = 'Hot Toddy'), (SELECT Id FROM Ingredients WHERE Name = 'Boiling Water'), (SELECT Id FROM Amounts WHERE Description = 'to fill')),
       ((SELECT Id FROM Cocktails WHERE Name = 'Hot Toddy'), (SELECT Id FROM Ingredients WHERE Name = 'Simple syrup'), (SELECT Id FROM Amounts WHERE Description = '1 fl oz')),
       ((SELECT Id FROM Cocktails WHERE Name = 'Hot Toddy'), (SELECT Id FROM Ingredients WHERE Name = 'Bourbon'), (SELECT Id FROM Amounts WHERE Description = '2 fl oz')),
       ((SELECT Id FROM Cocktails WHERE Name = 'Hot Toddy'), (SELECT Id FROM Ingredients WHERE Name = 'Freshly-squeezed lemon juice'), (SELECT Id FROM Amounts WHERE Description = '0.5 fl oz'));

INSERT INTO CocktailSteps (CocktailId, StepNumber, Instruction)
VALUES ((SELECT Id FROM Cocktails WHERE Name = 'Hot Toddy'), 1, 'Press the cloves into the lemon wheel and set aside'),
       ((SELECT Id FROM Cocktails WHERE Name = 'Hot Toddy'), 2, 'Fill a mug halfway with boiling water'),
       ((SELECT Id FROM Cocktails WHERE Name = 'Hot Toddy'), 3, 'Add the lemon wheel with cloves and stir'),
       ((SELECT Id FROM Cocktails WHERE Name = 'Hot Toddy'), 4, 'Add the remaining ingredients and stir again');
