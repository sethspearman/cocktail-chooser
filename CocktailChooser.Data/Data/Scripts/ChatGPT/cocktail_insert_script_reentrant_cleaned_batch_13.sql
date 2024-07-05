
    -- Insert statement for CocktailSource
    INSERT INTO CocktailSource (Name, SourceType, Url) 
    SELECT 'Cocktail Recipe Book', 'Book', NULL
    WHERE NOT EXISTS (SELECT 1 FROM CocktailSource WHERE Name = 'Cocktail Recipe Book');
    

        INSERT INTO Cocktails (Name, Description, Method, GlassTypeId, TimePeriodId, IsPopular, CocktailSourceID) 
        SELECT 'GIN RICKEY', 'Bubbly and Tart', 'Fill a highball glass with ice. Add gin to the highball glass. Juice the lime halves into the highball. Drop in the juiced lime halves. Top with club soda.', 8, 4, 0, 1
        WHERE NOT EXISTS (SELECT 1 FROM Cocktails WHERE Name = 'GIN RICKEY');
        

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Gin', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Gin');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '1.5 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '1.5 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'GIN RICKEY')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Gin'), (SELECT Id FROM Amounts WHERE MeasurementName = '1.5 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'GIN RICKEY') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Gin') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '1.5 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Lime', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Lime');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '1, cut in half', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '1, cut in half');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'GIN RICKEY')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Lime'), (SELECT Id FROM Amounts WHERE MeasurementName = '1, cut in half')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'GIN RICKEY') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Lime') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '1, cut in half'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Club soda', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Club soda');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT 'to top', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = 'to top');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'GIN RICKEY')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Club soda'), (SELECT Id FROM Amounts WHERE MeasurementName = 'to top')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'GIN RICKEY') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Club soda') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = 'to top'));
            

        INSERT INTO Cocktails (Name, Description, Method, GlassTypeId, TimePeriodId, IsPopular, CocktailSourceID) 
        SELECT 'GIN AND TONIC', 'Bubbly and Sweet', 'Add gin to a highball glass and fill with ice. Top with tonic water. Squeeze lemon or lime wedge over the top and stir.', 8, 4, 0, 1
        WHERE NOT EXISTS (SELECT 1 FROM Cocktails WHERE Name = 'GIN AND TONIC');
        

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Gin', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Gin');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '1.5 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '1.5 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'GIN AND TONIC')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Gin'), (SELECT Id FROM Amounts WHERE MeasurementName = '1.5 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'GIN AND TONIC') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Gin') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '1.5 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Tonic water', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Tonic water');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT 'to top', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = 'to top');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'GIN AND TONIC')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Tonic water'), (SELECT Id FROM Amounts WHERE MeasurementName = 'to top')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'GIN AND TONIC') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Tonic water') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = 'to top'));
            