
    -- Insert statement for CocktailSource
    INSERT INTO CocktailSource (Name, SourceType, Url) 
    SELECT 'Cocktail Recipe Book', 'Book', NULL
    WHERE NOT EXISTS (SELECT 1 FROM CocktailSource WHERE Name = 'Cocktail Recipe Book');
    

        INSERT INTO Cocktails (Name, Description, Method, GlassTypeId, TimePeriodId, IsPopular, CocktailSourceID) 
        SELECT 'BOURBON ALEXANDER', 'Sweet and Decadent', 'Combine ingredients in a shaker with ice. Shake. Strain into a chilled coupe glass. Garnish with grated nutmeg.', 8, 4, 0, 1
        WHERE NOT EXISTS (SELECT 1 FROM Cocktails WHERE Name = 'BOURBON ALEXANDER');
        

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Bourbon', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Bourbon');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '0.5 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '0.5 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'BOURBON ALEXANDER')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Bourbon'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'BOURBON ALEXANDER') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Bourbon') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Cherry liqueur', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Cherry liqueur');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '0.5 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '0.5 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'BOURBON ALEXANDER')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Cherry liqueur'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'BOURBON ALEXANDER') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Cherry liqueur') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Crème de Cacao', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Crème de Cacao');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '0.5 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '0.5 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'BOURBON ALEXANDER')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Crème de Cacao'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'BOURBON ALEXANDER') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Crème de Cacao') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Cream or half and half', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Cream or half and half');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '1 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '1 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'BOURBON ALEXANDER')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Cream or half and half'), (SELECT Id FROM Amounts WHERE MeasurementName = '1 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'BOURBON ALEXANDER') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Cream or half and half') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '1 fl oz'));
            

        INSERT INTO Cocktails (Name, Description, Method, GlassTypeId, TimePeriodId, IsPopular, CocktailSourceID) 
        SELECT 'BOURBON CIDER', 'Sweet and Fruity', 'Combine first three ingredients in a mixing glass with ice. Stir. Strain into an old-fashioned glass. Top with cider. Garnish with a cherry.', 8, 6, 0, 1
        WHERE NOT EXISTS (SELECT 1 FROM Cocktails WHERE Name = 'BOURBON CIDER');
        

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Bourbon', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Bourbon');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '2 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '2 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'BOURBON CIDER')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Bourbon'), (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'BOURBON CIDER') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Bourbon') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '2 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Simple syrup', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Simple syrup');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '0.5 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '0.5 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'BOURBON CIDER')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Simple syrup'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'BOURBON CIDER') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Simple syrup') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Aromatic bitters', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Aromatic bitters');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '2.25', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '2.25');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'BOURBON CIDER')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Aromatic bitters'), (SELECT Id FROM Amounts WHERE MeasurementName = '2.25')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'BOURBON CIDER') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Aromatic bitters') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '2.25'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Dry, hard cider', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Dry, hard cider');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT 'to top', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = 'to top');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'BOURBON CIDER')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Dry, hard cider'), (SELECT Id FROM Amounts WHERE MeasurementName = 'to top')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'BOURBON CIDER') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Dry, hard cider') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = 'to top'));
            