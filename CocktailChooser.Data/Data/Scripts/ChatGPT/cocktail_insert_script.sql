INSERT INTO CocktailSource (Name, SourceType, Url) VALUES ('Cocktail Recipe Book', 'Book', NULL);

    INSERT INTO Cocktails (Name, Description, Method, GlassTypeId, TimePeriodId, IsPopular, CocktailSourceID) 
    VALUES ('GIN SODA', '', 'Prepare exactly as Gin and Tonic, but top with club soda.', 8, 
    None, 0, 1);
    
SET @cocktail_id = last_insert_rowid();

        INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
        VALUES ('Gin', 1, NULL, NULL)
        ON CONFLICT(Name) DO NOTHING;
        
SET @ingredient_id = (SELECT Id FROM Ingredients WHERE Name = 'Gin');

            INSERT INTO Amounts (MeasurementName, Ounces) 
            VALUES ('1 oz', 1.0)
            ON CONFLICT(MeasurementName) DO NOTHING;
            
SET @amount_id = (SELECT Id FROM Amounts WHERE MeasurementName = '1 oz');

        INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId) 
        VALUES (@cocktail_id, @ingredient_id, @amount_id);
        

        INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
        VALUES ('Club Soda', 1, NULL, NULL)
        ON CONFLICT(Name) DO NOTHING;
        
SET @ingredient_id = (SELECT Id FROM Ingredients WHERE Name = 'Club Soda');
SET @amount_id = NULL;

        INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId) 
        VALUES (@cocktail_id, @ingredient_id, @amount_id);
        

    INSERT INTO Cocktails (Name, Description, Method, GlassTypeId, TimePeriodId, IsPopular, CocktailSourceID) 
    VALUES ('HANKY PANKY', 'Herbal and Spirit-Forward', 'Combine all ingredients into a mixing glass with ice. Stir. Strain into a chilled martini or coupe glass. Garnish with an orange zest twist.', 9, 
    4, 0, 1);
    
SET @cocktail_id = last_insert_rowid();

        INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
        VALUES ('Gin', 1, NULL, NULL)
        ON CONFLICT(Name) DO NOTHING;
        
SET @ingredient_id = (SELECT Id FROM Ingredients WHERE Name = 'Gin');

            INSERT INTO Amounts (MeasurementName, Ounces) 
            VALUES ('1 oz', 1.0)
            ON CONFLICT(MeasurementName) DO NOTHING;
            
SET @amount_id = (SELECT Id FROM Amounts WHERE MeasurementName = '1 oz');

        INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId) 
        VALUES (@cocktail_id, @ingredient_id, @amount_id);
        

        INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
        VALUES ('Sweet vermouth', 1, NULL, NULL)
        ON CONFLICT(Name) DO NOTHING;
        
SET @ingredient_id = (SELECT Id FROM Ingredients WHERE Name = 'Sweet vermouth');

            INSERT INTO Amounts (MeasurementName, Ounces) 
            VALUES ('0.75 oz', 1.0)
            ON CONFLICT(MeasurementName) DO NOTHING;
            
SET @amount_id = (SELECT Id FROM Amounts WHERE MeasurementName = '0.75 oz');

        INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId) 
        VALUES (@cocktail_id, @ingredient_id, @amount_id);
        

        INSERT INTO Ingredients (Name, IngredientTypeId, MixerSubtypeId, LongDescription) 
        VALUES ('Fernet-Branca', 1, NULL, NULL)
        ON CONFLICT(Name) DO NOTHING;
        
SET @ingredient_id = (SELECT Id FROM Ingredients WHERE Name = 'Fernet-Branca');

            INSERT INTO Amounts (MeasurementName, Ounces) 
            VALUES ('0.5 oz', 1.0)
            ON CONFLICT(MeasurementName) DO NOTHING;
            
SET @amount_id = (SELECT Id FROM Amounts WHERE MeasurementName = '0.5 oz');

        INSERT INTO CocktailIngredients (CocktailId, IngredientId, AmountId) 
        VALUES (@cocktail_id, @ingredient_id, @amount_id);
        