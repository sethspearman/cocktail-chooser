-- ========================================
-- Seed Tag Types
-- ========================================

INSERT INTO TagTypes (Name, Description, IsSeeded, CreatedUtc) VALUES
('Flavor Profile', 'Flavor characteristics of a cocktail', 1, CURRENT_TIMESTAMP),
('Texture', 'Mouthfeel and body', 1, CURRENT_TIMESTAMP),
('Cocktail Family', 'Classic cocktail taxonomy', 1, CURRENT_TIMESTAMP),
('Mood', 'Emotional context for discovery', 1, CURRENT_TIMESTAMP),
('Occasion', 'Situational drinking context', 1, CURRENT_TIMESTAMP),
('Strength', 'Alcohol intensity', 1, CURRENT_TIMESTAMP),
('Build Method', 'Preparation technique', 1, CURRENT_TIMESTAMP),
('Aesthetic', 'Visual style of the drink', 1, CURRENT_TIMESTAMP),
('Build Pattern', 'Structural pattern of the recipe', 1, CURRENT_TIMESTAMP);

-- ========================================
-- Flavor Profile
-- ========================================

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Floral','floral',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Flavor Profile';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Fruity','fruity',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Flavor Profile';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Herbal','herbal',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Flavor Profile';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Smoky','smoky',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Flavor Profile';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Sour','sour',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Flavor Profile';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Sweet','sweet',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Flavor Profile';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Spicy','spicy',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Flavor Profile';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Bitter','bitter',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Flavor Profile';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Refreshing','refreshing',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Flavor Profile';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Fizzy','fizzy',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Flavor Profile';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Citrusy','citrusy',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Flavor Profile';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Tropical','tropical',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Flavor Profile';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Creamy','creamy',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Flavor Profile';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Savory','savory',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Flavor Profile';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Warming','warming',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Flavor Profile';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Coffee / Chocolate','coffee_chocolate',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Flavor Profile';


-- ========================================
-- Texture
-- ========================================

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Silky','silky',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Texture';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Creamy','creamy',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Texture';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Frothy','frothy',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Texture';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Light','light',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Texture';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Effervescent','effervescent',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Texture';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Thick','thick',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Texture';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Icy','icy',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Texture';


-- ========================================
-- Build Method
-- ========================================

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Stirred','stirred',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Method';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Shaken','shaken',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Method';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Built','built',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Method';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Blended','blended',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Method';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Layered','layered',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Method';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Swizzled','swizzled',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Method';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Muddled','muddled',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Method';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Rolled','rolled',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Method';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Dry Shake','dry_shake',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Method';


-- ========================================
-- Build Pattern
-- ========================================

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Equal Parts','equal_parts',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Pattern';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'2:1:1','2_1_1',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Pattern';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'3:2:1','3_2_1',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Pattern';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Spirit + Citrus + Sweet','spirit_citrus_sweet',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Pattern';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Spirit Forward','spirit_forward',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Pattern';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Split Base','split_base',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Pattern';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Fortified Wine Forward','fortified_wine_forward',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Pattern';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Simple 2 Ingredient','simple_2',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Pattern';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Simple 3 Ingredient','simple_3',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Pattern';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Simple 4 Ingredient','simple_4',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Pattern';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Complex Spec','complex',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Pattern';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Tiki Multi Ingredient','tiki_multi',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Pattern';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Long Drink','long_drink',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Pattern';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Short Drink','short_drink',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Pattern';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Served Up','served_up',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Pattern';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Over Crushed Ice','crushed_ice',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Pattern';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Topped With Soda','topped_soda',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Pattern';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Egg White / Foam','egg_white',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Pattern';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Hot Cocktail','hot',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Pattern';

INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT Id,'Frozen Cocktail','frozen',CURRENT_TIMESTAMP FROM TagTypes WHERE Name='Build Pattern';