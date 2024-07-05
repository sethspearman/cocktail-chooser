
    -- Insert statement for CocktailSource
    INSERT INTO CocktailSource (Name, SourceType, Url) 
    SELECT 'Cocktail Recipe Book', 'Book', NULL
    WHERE NOT EXISTS (SELECT 1 FROM CocktailSource WHERE Name = 'Cocktail Recipe Book');
    

        INSERT INTO Cocktails (Name, Description, Method, GlassTypeId, TimePeriodId, IsPopular, CocktailSourceID) 
        SELECT 'BROWN DERBY', 'Unknown', 'Combine ingredients in a shaker with ice. Shake. Fine strain into a chilled coupe glass. Garnish with a grapefruit zest twist.', 8, 6, 0, 1
        WHERE NOT EXISTS (SELECT 1 FROM Cocktails WHERE Name = 'BROWN DERBY');
        

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Bourbon', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Bourbon');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '2 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '2 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'BROWN DERBY')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Bourbon'), (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'BROWN DERBY') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Bourbon') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Grapefruit juice', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Grapefruit juice');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '1 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '1 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'BROWN DERBY')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Grapefruit juice'), (SELECT Id FROM Amounts WHERE MeasurementName = '1 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'BROWN DERBY') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Grapefruit juice') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '1 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Honey syrup', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Honey syrup');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '0.5 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '0.5 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'BROWN DERBY')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Honey syrup'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'BROWN DERBY') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Honey syrup') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz'));
            

        INSERT INTO Cocktails (Name, Description, Method, GlassTypeId, TimePeriodId, IsPopular, CocktailSourceID) 
        SELECT 'DIXIE DEW', 'Minty and Complex', 'Combine ingredients in a cocktail shaker with ice. Shake. Strain into a chilled coupe glass. Garnish with an orange zest twist.', 8, 6, 0, 1
        WHERE NOT EXISTS (SELECT 1 FROM Cocktails WHERE Name = 'DIXIE DEW');
        

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Bourbon', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Bourbon');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '2 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '2 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'DIXIE DEW')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Bourbon'), (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'DIXIE DEW') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Bourbon') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Crème de menthe', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Crème de menthe');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '0.5 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '0.5 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'DIXIE DEW')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Crème de menthe'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'DIXIE DEW') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Crème de menthe') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Triple Sec', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Triple Sec');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '0.5 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '0.5 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'DIXIE DEW')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Triple Sec'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'DIXIE DEW') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Triple Sec') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz'));
            