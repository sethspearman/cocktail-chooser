
    -- Insert statement for CocktailSource
    INSERT INTO CocktailSource (Name, SourceType, Url) 
    SELECT 'Cocktail Recipe Book', 'Book', NULL
    WHERE NOT EXISTS (SELECT 1 FROM CocktailSource WHERE Name = 'Cocktail Recipe Book');
    

        INSERT INTO Cocktails (Name, Description, Method, GlassTypeId, TimePeriodId, IsPopular, CocktailSourceID) 
        SELECT 'SARATOGA COCKTAIL #1', 'Dry and Aromatic', 'Combine all ingredients in a mixing glass with ice. Stir. Strain into a chilled coupe glass. Garnish with a lemon wheel.', 8, 6, 0, 1
        WHERE NOT EXISTS (SELECT 1 FROM Cocktails WHERE Name = 'SARATOGA COCKTAIL #1');
        

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Rye whiskey', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Rye whiskey');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '1.5 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '1.5 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'SARATOGA COCKTAIL #1')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Rye whiskey'), (SELECT Id FROM Amounts WHERE MeasurementName = '1.5 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'SARATOGA COCKTAIL #1') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Rye whiskey') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '1.5 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Sweet vermouth', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Sweet vermouth');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '0.75 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '0.75 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'SARATOGA COCKTAIL #1')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Sweet vermouth'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.75 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'SARATOGA COCKTAIL #1') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Sweet vermouth') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.75 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Dry vermouth', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Dry vermouth');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '0.75 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '0.75 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'SARATOGA COCKTAIL #1')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Dry vermouth'), (SELECT Id FROM Amounts WHERE MeasurementName = '0.75 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'SARATOGA COCKTAIL #1') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Dry vermouth') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '0.75 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Angostura bitters', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Angostura bitters');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '1.25', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '1.25');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'SARATOGA COCKTAIL #1')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Angostura bitters'), (SELECT Id FROM Amounts WHERE MeasurementName = '1.25')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'SARATOGA COCKTAIL #1') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Angostura bitters') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '1.25'));
            

        INSERT INTO Cocktails (Name, Description, Method, GlassTypeId, TimePeriodId, IsPopular, CocktailSourceID) 
        SELECT 'SAZERAC', 'Spirit-forward', 'Chill an old-fashioned glass with ice and set aside. Combine first three ingredients in a mixing glass with ice. Discard ice in the old-fashioned glass and rinse with absinthe. Strain mixture into the absinthe-rinsed, chilled old-fashioned glass. Garnish with a lemon zest twist.', 8, 4, 0, 1
        WHERE NOT EXISTS (SELECT 1 FROM Cocktails WHERE Name = 'SAZERAC');
        

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Rye whiskey', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Rye whiskey');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '1.5 fl oz', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '1.5 fl oz');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'SAZERAC')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Rye whiskey'), (SELECT Id FROM Amounts WHERE MeasurementName = '1.5 fl oz')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'SAZERAC') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Rye whiskey') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '1.5 fl oz'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Sugar cube', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Sugar cube');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '1', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '1');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'SAZERAC')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Sugar cube'), (SELECT Id FROM Amounts WHERE MeasurementName = '1')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'SAZERAC') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Sugar cube') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '1'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Aromatic bitters', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Aromatic bitters');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT '3.25', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = '3.25');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'SAZERAC')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Aromatic bitters'), (SELECT Id FROM Amounts WHERE MeasurementName = '3.25')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'SAZERAC') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Aromatic bitters') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = '3.25'));
            

            INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
            SELECT 'Absinthe', 1, NULL, NULL
            WHERE NOT EXISTS (SELECT 1 FROM Ingredients WHERE Name = 'Absinthe');
            

            INSERT INTO Amounts (MeasurementName, Ounces) 
            SELECT 'for rinse', 1.0
            WHERE NOT EXISTS (SELECT 1 FROM Amounts WHERE MeasurementName = 'for rinse');
            

            WITH LastCocktail AS (SELECT Id AS CocktailId FROM Cocktails WHERE Name = 'SAZERAC')
            INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId)
            SELECT CocktailId, (SELECT Id FROM Ingredients WHERE Name = 'Absinthe'), (SELECT Id FROM Amounts WHERE MeasurementName = 'for rinse')
            FROM LastCocktail
            WHERE NOT EXISTS (SELECT 1 FROM CocktailIngredients WHERE CocktailId = (SELECT Id FROM Cocktails WHERE Name = 'SAZERAC') AND IngredientId = (SELECT Id FROM Ingredients WHERE Name = 'Absinthe') AND AmountId = (SELECT Id FROM Amounts WHERE MeasurementName = 'for rinse'));
            