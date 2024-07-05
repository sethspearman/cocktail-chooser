
    -- Insert statement for CocktailSource
    INSERT INTO CocktailSource (Name, SourceType, Url) 
    SELECT 'Cocktail Recipe Book', 'Book', NULL
    WHERE NOT EXISTS (SELECT 1 FROM CocktailSource WHERE Name = 'Cocktail Recipe Book');
    

        INSERT INTO Cocktails (Name, Description, Method, GlassTypeId, TimePeriodId, IsPopular, CocktailSourceID) 
        SELECT 'Unnamed Cocktail', 'Complex', 'Combine ingredients in a mixing glass with ice. Stir. Strain into an ice-filled old-fashioned glass. Garnish with a lemon zest twist.', 8, 6, 0, 1
        WHERE NOT EXISTS (SELECT 1 FROM Cocktails WHERE Name = 'Unnamed Cocktail');
        

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Benedictine D.O.M', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Benedictine D.O.M');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '1 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '1 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Unnamed Cocktail')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Benedictine D.O.M'), (SELECT Id FROM Amounts WHERE MeasurementName = '1 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Unnamed Cocktail') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Benedictine D.O.M') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '1 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Sweet vermouth', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Sweet vermouth');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '1 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '1 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Unnamed Cocktail')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Sweet vermouth'), (SELECT Id FROM Amounts WHERE MeasurementName = '1 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Unnamed Cocktail') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Sweet vermouth') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '1 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Aromatic bitters', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Aromatic bitters');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '2.25', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '2.25');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'Unnamed Cocktail')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Aromatic bitters'), (SELECT Id FROM Amounts WHERE MeasurementName = '2.25')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'Unnamed Cocktail') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Aromatic bitters') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '2.25'));
            

        INSERT INTO Cocktails (Name, Description, Method, GlassTypeId, TimePeriodId, IsPopular, CocktailSourceID) 
        SELECT 'WITTY COMEBACK', 'Complex and Herbal', 'Combine ingredients in a cocktail shaker with ice. Shake well. Strain into a chilled coupe glass. Garnish with a lemon zest twist.', 8, 6, 0, 1
        WHERE NOT EXISTS (SELECT 1 FROM Cocktails WHERE Name = 'WITTY COMEBACK');
        

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Whiskey', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Whiskey');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '2 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '2 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'WITTY COMEBACK')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Whiskey'), (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'WITTY COMEBACK') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Whiskey') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Averna amaro', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Averna amaro');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '0.5 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '0.5 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'WITTY COMEBACK')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Averna amaro'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'WITTY COMEBACK') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Averna amaro') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Freshly-squeezed lemon juice', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Freshly-squeezed lemon juice');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '0.75 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '0.75 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'WITTY COMEBACK')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Freshly-squeezed lemon juice'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.75 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'WITTY COMEBACK') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Freshly-squeezed lemon juice') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.75 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Ginger simple syrup', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Ginger simple syrup');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '0.75 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '0.75 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'WITTY COMEBACK')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Ginger simple syrup'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.75 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'WITTY COMEBACK') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Ginger simple syrup') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.75 fl oz'));
            