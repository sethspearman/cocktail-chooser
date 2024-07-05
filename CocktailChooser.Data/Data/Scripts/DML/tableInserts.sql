
-- Insert Ingredient Types
INSERT INTO IngredientTypes (Type) VALUES ('Spirit','Mixer','Garnish');


-- Insert Mixer Types
INSERT INTO MixerTypes (Name, Description) VALUES 
('Sodas', 'Versatile mixers offering effervescence and a neutral flavor profile.'),
('Juices', 'Add freshness, acidity, and natural sweetness to cocktails.'),
('Syrups', 'Provide sweetness and body, allowing for flavor customization.'),
('Bitters', 'Concentrated infusions adding complexity and depth.'),
('Eggs', 'Add a rich, creamy texture and smooth mouthfeel to cocktails.');

-- Insert Mixer Subtypes for Sodas
INSERT INTO MixerSubtypes (MixerTypeId, Name, Description) VALUES 
((SELECT Id FROM MixerTypes WHERE Name = 'Sodas'), 'Tonic Water', 'Sweet and bitter, mainly used in gin and tonics.'),
((SELECT Id FROM MixerTypes WHERE Name = 'Sodas'), 'Club Soda', 'Unsweetened, sparkling, with an almost salty note.'),
((SELECT Id FROM MixerTypes WHERE Name = 'Sodas'), 'Cola', 'Dark, sweet, often flavored with vanilla and cinnamon.'),
((SELECT Id FROM MixerTypes WHERE Name = 'Sodas'), 'Ginger Ale', 'Ginger-flavored, sweetened, popular during Prohibition.'),
((SELECT Id FROM MixerTypes WHERE Name = 'Sodas'), 'Ginger Beer', 'Fermented, spicier than ginger ale, bold in cocktails.');

-- Insert Cocktail Time Periods with Descriptions
INSERT INTO CocktailTimePeriods (Name, Description, LongDescription) VALUES 
('Classic', 'Pre-Prohibition to Prohibition era cocktails.', 'Many classic cocktails feature gin as their base spirit...'),
('Vintage', '1940s to 1980s, showcasing the evolution of cocktails.', 'Vintage cocktails are often fairly complex...'),
('Modern', '1990s to present day, reflecting contemporary trends.', 'Modern cocktails are derived from previous eras...');

-- Insert Glass Types
INSERT INTO GlassTypes (Name) VALUES 
('Highball Glass'), 
('Martini Glass'), 
('Old Fashioned Glass'), 
('Coupe'), 
('Collins'), 
('Hurricane'), 
('Flute');

-- Insert Amounts with Measurement Names and Ounces
INSERT INTO Amounts (MeasurementName, Ounces) VALUES 
('Dash', 1.0/32), 
('Teaspoon', 1.0/8), 
('Tablespoon', 3.0/8), 
('Shot', 1), 
('Cup', 8);
