--
-- File generated with SQLiteStudio v3.4.4 on Fri Jul 5 21:21:17 2024
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: Amounts

INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (6, 'Dash', 0.03125);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (7, 'Teaspoon', 0.125);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (8, 'Tablespoon', 0.375);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (9, 'Shot', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (10, 'Cup', 8.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (11, '1 oz', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (12, '0.75 oz', 0.75);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (13, '0.5 oz', 0.5);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (14, '1 fl', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (15, '4 fl', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (16, '1/44 fl', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (17, '4 1/4', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (18, '1 Dash', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (19, '% Â£1', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (20, '4 Dashes', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (21, '30 Q', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (22, '3 ta', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (23, '% £1', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (24, '10.25', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (25, '1.25', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (26, '1.5 oz', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (27, 'to top', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (28, '2.25', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (29, '0.25 oz', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (30, '3.25', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (31, '1', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (32, '1 fl oz', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (33, '0.25 fl oz', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (34, '0.75 fl oz', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (35, '2 fl oz', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (36, '1 bar spoon', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (37, '4.25', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (38, '1.5 fl oz', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (39, '0.5 fl oz', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (40, '1, cut in half', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (41, 'for rinse', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (42, 'to rinse', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (43, '12', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (44, '4', 1.0);
INSERT INTO Amounts (Id, MeasurementName, Ounces) VALUES (45, '3 fl oz', 1.0);

-- Table: CocktailIngredients
-- Table: CocktailRecipes

-- Table: Cocktails
-- Table: CocktailSource

INSERT INTO CocktailSource (Id, Name, SourceType, Url) VALUES (1, 'Cocktail Recipe Book', 'Book', NULL);

-- Table: CocktailTimePeriods

INSERT INTO CocktailTimePeriods (Id, Name, Description, LongDescription) VALUES (4, 'Classic', 'Pre-Prohibition to Prohibition era cocktails.', 'Many classic cocktails feature gin as their base spirit...');
INSERT INTO CocktailTimePeriods (Id, Name, Description, LongDescription) VALUES (5, 'Vintage', '1940s to 1980s, showcasing the evolution of cocktails.', 'Vintage cocktails are often fairly complex...');
INSERT INTO CocktailTimePeriods (Id, Name, Description, LongDescription) VALUES (6, 'Modern', '1990s to present day, reflecting contemporary trends.', 'Modern cocktails are derived from previous eras...');

-- Table: GlassTypes

INSERT INTO GlassTypes (Id, Name) VALUES (8, 'Highball Glass');
INSERT INTO GlassTypes (Id, Name) VALUES (9, 'Martini Glass');
INSERT INTO GlassTypes (Id, Name) VALUES (10, 'Old Fashioned Glass');
INSERT INTO GlassTypes (Id, Name) VALUES (11, 'Coupe');
INSERT INTO GlassTypes (Id, Name) VALUES (12, 'Collins');
INSERT INTO GlassTypes (Id, Name) VALUES (13, 'Hurricane');
INSERT INTO GlassTypes (Id, Name) VALUES (14, 'Flute');

-- Table: Ingredients

INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (1, 'Gin', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (2, 'Club Soda', 2, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (3, 'Sweet vermouth', 2, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (4, 'Fernet-Branca', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (5, 'Benedictine D.O.M', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (6, 'Triple sec', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (7, 'Pineapple juice', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (8, 'Freshly-squeezed lime juice', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (9, 'Grenadine', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (10, 'Angostura bitters', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (11, 'Absinthe', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (12, 'Ss', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (13, 'fa 2a', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (14, 'Lime', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (15, 'Green Chartreuse', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (16, 'Maraschino liqueur', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (17, 'Elderflower liqueur', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (18, 'Chardonnay white wine', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (19, 'Dry Vermouth', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (20, 'Whiskey', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (21, 'Aromatic bitters', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (22, 'Almond syrup', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (23, 'Freshly-squeezed lemon juice', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (24, 'Simple syrup', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (25, 'Pasteurized egg white', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (26, 'Bourbon', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (27, 'Mezcal', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (28, 'Amaro Lucano liqueur', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (29, 'Orgeat', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (30, 'Rye whiskey', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (31, 'Runny honey', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (32, 'Tequila', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (33, 'Apple juice', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (34, 'Ginger ale', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (35, 'Aromatized wine', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (36, 'Amaro liqueur', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (37, 'Ginger beer', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (38, 'Cherry liqueur', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (39, 'Club soda', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (40, 'Freshly-squeezed orange juice', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (41, 'Cherry syrup', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (42, 'Pomegranate juice', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (43, 'Grapefruit juice', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (44, 'Campari', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (45, 'Red wine', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (46, 'Amaro', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (47, 'Apple brandy', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (48, 'Yellow Chartreuse', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (49, 'Tonic water', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (50, 'Dry vermouth', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (51, 'Rye whisky', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (52, 'Fernet Branca', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (53, 'Sugar cube', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (54, 'Egg white (optional)', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (55, 'Lillet Blanc', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (56, 'White Creme de Cacao', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (57, 'Cointreau', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (58, 'Lillet blanc', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (59, 'Peach bitters', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (60, 'CrÃ¨me de Violette', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (61, 'Orange flower water', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (62, 'Cream or half and half', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (63, 'Averna amaro', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (64, 'Ginger simple syrup', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (65, 'Honey syrup', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (66, 'CrÃ¨me de menthe', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (67, 'Triple Sec', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (68, 'Tawny Port', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (69, 'Orange bitters', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (70, 'Heavy cream', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (71, 'Coffee liqueur', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (72, 'Fresh raspberries', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (73, 'Mint leaves', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (74, 'Cranberry juice', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (75, 'Medium-dry apple cider', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (76, 'Lemon-lime soda', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (77, 'Bitters', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (78, 'CrÃ¨me de Cacao', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (79, 'Dry, hard cider', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (80, 'Orange liqueur', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (81, 'CrÃ¨me de mure', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (82, 'Honey-flavored syrup', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (83, 'Sweet Vermouth', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (84, 'Kahlua', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (85, 'Almond-flavored syrup', 1, NULL, NULL);
INSERT INTO Ingredients (Id, Name, IngredientTypeId, MixerSubtypeId, LongDescription) VALUES (86, 'CrÃ¨me de violette', 1, NULL, NULL);

-- Table: IngredientTypes

INSERT INTO IngredientTypes (Id, Type) VALUES (1, 'Spirit');
INSERT INTO IngredientTypes (Id, Type) VALUES (2, 'Mixer');
INSERT INTO IngredientTypes (Id, Type) VALUES (3, 'Garnish');

-- Table: MixerSubtypes

INSERT INTO MixerSubtypes (Id, MixerTypeId, Name, Description) VALUES (6, 11, 'Tonic Water', 'Sweet and bitter, mainly used in gin and tonics.');
INSERT INTO MixerSubtypes (Id, MixerTypeId, Name, Description) VALUES (7, 11, 'Club Soda', 'Unsweetened, sparkling, with an almost salty note.');
INSERT INTO MixerSubtypes (Id, MixerTypeId, Name, Description) VALUES (8, 11, 'Cola', 'Dark, sweet, often flavored with vanilla and cinnamon.');
INSERT INTO MixerSubtypes (Id, MixerTypeId, Name, Description) VALUES (9, 11, 'Ginger Ale', 'Ginger-flavored, sweetened, popular during Prohibition.');
INSERT INTO MixerSubtypes (Id, MixerTypeId, Name, Description) VALUES (10, 11, 'Ginger Beer', 'Fermented, spicier than ginger ale, bold in cocktails.');

-- Table: MixerTypes

INSERT INTO MixerTypes (Id, Name, Description) VALUES (11, 'Sodas', 'Versatile mixers offering effervescence and a neutral flavor profile.');
INSERT INTO MixerTypes (Id, Name, Description) VALUES (12, 'Juices', 'Add freshness, acidity, and natural sweetness to cocktails.');
INSERT INTO MixerTypes (Id, Name, Description) VALUES (13, 'Syrups', 'Provide sweetness and body, allowing for flavor customization.');
INSERT INTO MixerTypes (Id, Name, Description) VALUES (14, 'Bitters', 'Concentrated infusions adding complexity and depth.');
INSERT INTO MixerTypes (Id, Name, Description) VALUES (15, 'Eggs', 'Add a rich, creamy texture and smooth mouthfeel to cocktails.');
INSERT INTO MixerTypes (Id, Name, Description) VALUES (16, 'Sodas', 'Versatile mixers offering effervescence and a neutral flavor profile.');
INSERT INTO MixerTypes (Id, Name, Description) VALUES (17, 'Juices', 'Add freshness, acidity, and natural sweetness to cocktails.');
INSERT INTO MixerTypes (Id, Name, Description) VALUES (18, 'Syrups', 'Provide sweetness and body, allowing for flavor customization.');
INSERT INTO MixerTypes (Id, Name, Description) VALUES (19, 'Bitters', 'Concentrated infusions adding complexity and depth.');
INSERT INTO MixerTypes (Id, Name, Description) VALUES (20, 'Eggs', 'Add a rich, creamy texture and smooth mouthfeel to cocktails.');

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
