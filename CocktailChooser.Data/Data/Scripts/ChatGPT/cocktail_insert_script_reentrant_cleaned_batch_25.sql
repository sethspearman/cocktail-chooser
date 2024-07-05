
    -- Insert statement for CocktailSource
    INSERT INTO CocktailSource (Name, SourceType, Url) 
    SELECT 'Cocktail Recipe Book', 'Book', NULL
    WHERE NOT EXISTS (SELECT 1 FROM CocktailSource WHERE Name = 'Cocktail Recipe Book');
    

        INSERT INTO Cocktails (Name, Description, Method, GlassTypeId, TimePeriodId, IsPopular, CocktailSourceID) 
        SELECT 'BOURBON LIFT', 'Sweet and Creamy', 'Combine first four ingredients into a cocktail shaker with ice. Shake well. Fine strain into a Collins glass. Top with club soda.', 8, 5, 0, 1
        WHERE NOT EXISTS (SELECT 1 FROM Cocktails WHERE Name = 'BOURBON LIFT');
        

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Bourbon', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Bourbon');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '1.5 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '1.5 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'BOURBON LIFT')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Bourbon'), (SELECT Id FROM Amounts WHERE MeasurementName = '1.5 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'BOURBON LIFT') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Bourbon') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '1.5 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Heavy cream', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Heavy cream');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '1 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '1 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'BOURBON LIFT')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Heavy cream'), (SELECT Id FROM Amounts WHERE MeasurementName = '1 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'BOURBON LIFT') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Heavy cream') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '1 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Coffee liqueur', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Coffee liqueur');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '0.5 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '0.5 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'BOURBON LIFT')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Coffee liqueur'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'BOURBON LIFT') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Coffee liqueur') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Orgeat', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Orgeat');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '0.25 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '0.25 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'BOURBON LIFT')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Orgeat'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.25 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'BOURBON LIFT') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Orgeat') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.25 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Club soda', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Club soda');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT 'to top', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = 'to top');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'BOURBON LIFT')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Club soda'), (SELECT Id FROM Amounts WHERE MeasurementName = 'to top')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'BOURBON LIFT') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Club soda') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = 'to top'));
            

        INSERT INTO Cocktails (Name, Description, Method, GlassTypeId, TimePeriodId, IsPopular, CocktailSourceID) 
        SELECT 'BOURBON SMASH', 'Fruity and Refreshing', 'Muddle raspberries in the base of a shaker. Add remaining ingredients to the shaker with ice. Shake. Strain into an ice-filled collins glass. Garnish with a lime wheel.', 8, 6, 0, 1
        WHERE NOT EXISTS (SELECT 1 FROM Cocktails WHERE Name = 'BOURBON SMASH');
        

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Fresh raspberries', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Fresh raspberries');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '12', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '12');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'BOURBON SMASH')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Fresh raspberries'), (SELECT Id FROM Amounts WHERE MeasurementName = '12')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'BOURBON SMASH') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Fresh raspberries') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '12'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Mint leaves', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Mint leaves');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '4', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '4');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'BOURBON SMASH')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Mint leaves'), (SELECT Id FROM Amounts WHERE MeasurementName = '4')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'BOURBON SMASH') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Mint leaves') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '4'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Bourbon', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Bourbon');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '2 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '2 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'BOURBON SMASH')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Bourbon'), (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'BOURBON SMASH') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Bourbon') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Cranberry juice', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Cranberry juice');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '3 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '3 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'BOURBON SMASH')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Cranberry juice'), (SELECT Id FROM Amounts WHERE MeasurementName = '3 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'BOURBON SMASH') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Cranberry juice') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '3 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Freshly-squeezed lime juice', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Freshly-squeezed lime juice');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '1 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '1 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'BOURBON SMASH')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Freshly-squeezed lime juice'), (SELECT Id FROM Amounts WHERE MeasurementName = '1 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'BOURBON SMASH') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Freshly-squeezed lime juice') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '1 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Simple syrup', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Simple syrup');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '0.5 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '0.5 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'BOURBON SMASH')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Simple syrup'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'BOURBON SMASH') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Simple syrup') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Aromatic bitters', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Aromatic bitters');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '2.25', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '2.25');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'BOURBON SMASH')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Aromatic bitters'), (SELECT Id FROM Amounts WHERE MeasurementName = '2.25')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'BOURBON SMASH') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Aromatic bitters') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '2.25'));
            