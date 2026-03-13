PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS TagTypes (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    Description TEXT,
    IsSeeded INTEGER NOT NULL DEFAULT 0,
    CreatedUtc TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now'))
);

CREATE UNIQUE INDEX IF NOT EXISTS UX_TagTypes_Name
ON TagTypes (Name);

CREATE TABLE IF NOT EXISTS Tags (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    TagTypeId INTEGER NOT NULL,
    Name TEXT NOT NULL,
    NormalizedName TEXT NOT NULL,
    CreatedUtc TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    FOREIGN KEY (TagTypeId) REFERENCES TagTypes (Id) ON DELETE CASCADE
);

CREATE UNIQUE INDEX IF NOT EXISTS UX_Tags_TagTypeId_NormalizedName
ON Tags (TagTypeId, NormalizedName);

CREATE INDEX IF NOT EXISTS IX_Tags_NormalizedName
ON Tags (NormalizedName);

CREATE TABLE IF NOT EXISTS CocktailTags (
    CocktailId INTEGER NOT NULL,
    TagId INTEGER NOT NULL,
    CreatedUtc TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    PRIMARY KEY (CocktailId, TagId),
    FOREIGN KEY (CocktailId) REFERENCES Cocktails (Id) ON DELETE CASCADE,
    FOREIGN KEY (TagId) REFERENCES Tags (Id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS IX_CocktailTags_TagId
ON CocktailTags (TagId);

CREATE TABLE IF NOT EXISTS Collections (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    Description TEXT,
    OwnerUserId INTEGER,
    IsSystemCollection INTEGER NOT NULL DEFAULT 0,
    CreatedUtc TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    FOREIGN KEY (OwnerUserId) REFERENCES Users (Id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS IX_Collections_OwnerUserId
ON Collections (OwnerUserId);

CREATE INDEX IF NOT EXISTS IX_Collections_IsSystemCollection
ON Collections (IsSystemCollection);

CREATE UNIQUE INDEX IF NOT EXISTS UX_Collections_System_Name
ON Collections (
    CASE WHEN IsSystemCollection = 1 THEN lower(Name) END
);

CREATE UNIQUE INDEX IF NOT EXISTS UX_Collections_Owner_Name
ON Collections (
    COALESCE(OwnerUserId, -1),
    IsSystemCollection,
    lower(Name)
);

CREATE TABLE IF NOT EXISTS CollectionCocktails (
    CollectionId INTEGER NOT NULL,
    CocktailId INTEGER NOT NULL,
    CreatedUtc TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    PRIMARY KEY (CollectionId, CocktailId),
    FOREIGN KEY (CollectionId) REFERENCES Collections (Id) ON DELETE CASCADE,
    FOREIGN KEY (CocktailId) REFERENCES Cocktails (Id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS IX_CollectionCocktails_CocktailId
ON CollectionCocktails (CocktailId);

WITH seed(Name, Description, IsSeeded) AS (
    VALUES
        ('Flavor Profile', 'Flavor characteristics of a cocktail.', 1),
        ('Texture', 'Mouthfeel and body.', 1),
        ('Cocktail Family', 'Classic cocktail taxonomy.', 1),
        ('Mood', 'Emotional context for discovery.', 1),
        ('Occasion', 'Situational drinking context.', 1),
        ('Strength', 'Alcohol intensity.', 1),
        ('Build Method', 'Preparation technique.', 1),
        ('Aesthetic', 'Visual style of the drink.', 1),
        ('Build Pattern', 'Structural pattern of the recipe.', 1)
)
INSERT INTO TagTypes (Name, Description, IsSeeded, CreatedUtc)
SELECT
    seed.Name,
    seed.Description,
    seed.IsSeeded,
    strftime('%Y-%m-%dT%H:%M:%fZ', 'now')
FROM seed
WHERE NOT EXISTS (
    SELECT 1
    FROM TagTypes existing
    WHERE existing.Name = seed.Name
);

WITH seed(TagTypeName, Name, NormalizedName) AS (
    VALUES
        ('Flavor Profile', 'Floral', 'floral'),
        ('Flavor Profile', 'Fruity', 'fruity'),
        ('Flavor Profile', 'Herbal', 'herbal'),
        ('Flavor Profile', 'Smoky', 'smoky'),
        ('Flavor Profile', 'Sour', 'sour'),
        ('Flavor Profile', 'Sweet', 'sweet'),
        ('Flavor Profile', 'Spicy', 'spicy'),
        ('Flavor Profile', 'Bitter', 'bitter'),
        ('Flavor Profile', 'Refreshing', 'refreshing'),
        ('Flavor Profile', 'Fizzy', 'fizzy'),
        ('Flavor Profile', 'Citrusy', 'citrusy'),
        ('Flavor Profile', 'Tropical', 'tropical'),
        ('Flavor Profile', 'Creamy', 'creamy'),
        ('Flavor Profile', 'Savory', 'savory'),
        ('Flavor Profile', 'Warming', 'warming'),
        ('Flavor Profile', 'Coffee / Chocolate', 'coffee-chocolate'),
        ('Texture', 'Silky', 'silky'),
        ('Texture', 'Creamy', 'creamy'),
        ('Texture', 'Frothy', 'frothy'),
        ('Texture', 'Light', 'light'),
        ('Texture', 'Effervescent', 'effervescent'),
        ('Texture', 'Thick', 'thick'),
        ('Texture', 'Icy', 'icy'),
        ('Cocktail Family', 'Buck', 'buck'),
        ('Cocktail Family', 'Cobbler', 'cobbler'),
        ('Cocktail Family', 'Collins', 'collins'),
        ('Cocktail Family', 'Cooler', 'cooler'),
        ('Cocktail Family', 'Crusta', 'crusta'),
        ('Cocktail Family', 'Daisy', 'daisy'),
        ('Cocktail Family', 'Fizz', 'fizz'),
        ('Cocktail Family', 'Flip', 'flip'),
        ('Cocktail Family', 'Highball', 'highball'),
        ('Cocktail Family', 'Julep', 'julep'),
        ('Cocktail Family', 'Lowball', 'lowball'),
        ('Cocktail Family', 'Mist', 'mist'),
        ('Cocktail Family', 'Pousse-Cafe', 'pousse-cafe'),
        ('Cocktail Family', 'Puff', 'puff'),
        ('Cocktail Family', 'Rickey', 'rickey'),
        ('Cocktail Family', 'Sangaree', 'sangaree'),
        ('Cocktail Family', 'Sling', 'sling'),
        ('Cocktail Family', 'Smash', 'smash'),
        ('Cocktail Family', 'Sour', 'sour'),
        ('Cocktail Family', 'Swizzle', 'swizzle'),
        ('Cocktail Family', 'Tall Drink', 'tall-drink'),
        ('Mood', 'Celebratory', 'celebratory'),
        ('Mood', 'Romantic', 'romantic'),
        ('Mood', 'Flirty', 'flirty'),
        ('Mood', 'Chill', 'chill'),
        ('Mood', 'Cozy', 'cozy'),
        ('Mood', 'Adventurous', 'adventurous'),
        ('Mood', 'Sophisticated', 'sophisticated'),
        ('Mood', 'Playful', 'playful'),
        ('Mood', 'Poolside', 'poolside'),
        ('Mood', 'Brunchy', 'brunchy'),
        ('Mood', 'Late-Night', 'late-night'),
        ('Mood', 'Festive', 'festive'),
        ('Mood', 'Contemplative', 'contemplative'),
        ('Mood', 'Bold', 'bold'),
        ('Occasion', 'Brunch', 'brunch'),
        ('Occasion', 'Aperitif', 'aperitif'),
        ('Occasion', 'Dinner Party', 'dinner-party'),
        ('Occasion', 'Date Night', 'date-night'),
        ('Occasion', 'Holiday', 'holiday'),
        ('Occasion', 'Patio', 'patio'),
        ('Occasion', 'Game Day', 'game-day'),
        ('Occasion', 'After Dinner', 'after-dinner'),
        ('Occasion', 'Nightcap', 'nightcap'),
        ('Occasion', 'Party', 'party'),
        ('Occasion', 'Summer', 'summer'),
        ('Occasion', 'Winter', 'winter'),
        ('Strength', 'Low-ABV', 'low-abv'),
        ('Strength', 'Sessionable', 'sessionable'),
        ('Strength', 'Medium', 'medium'),
        ('Strength', 'Spirit-Forward', 'spirit-forward'),
        ('Strength', 'High-Octane', 'high-octane'),
        ('Build Method', 'Stirred', 'stirred'),
        ('Build Method', 'Shaken', 'shaken'),
        ('Build Method', 'Built', 'built'),
        ('Build Method', 'Blended', 'blended'),
        ('Build Method', 'Layered', 'layered'),
        ('Build Method', 'Swizzled', 'swizzled'),
        ('Build Method', 'Muddled', 'muddled'),
        ('Build Method', 'Rolled', 'rolled'),
        ('Build Method', 'Dry Shake', 'dry-shake'),
        ('Aesthetic', 'Classic', 'classic'),
        ('Aesthetic', 'Elegant', 'elegant'),
        ('Aesthetic', 'Colorful', 'colorful'),
        ('Aesthetic', 'Layered', 'layered'),
        ('Aesthetic', 'Tiki', 'tiki'),
        ('Aesthetic', 'Festive', 'festive'),
        ('Aesthetic', 'Minimal', 'minimal'),
        ('Aesthetic', 'Dramatic', 'dramatic'),
        ('Aesthetic', 'Photogenic', 'photogenic'),
        ('Build Pattern', 'Equal Parts', 'equal-parts'),
        ('Build Pattern', '2:1:1', '2-1-1'),
        ('Build Pattern', '3:2:1', '3-2-1'),
        ('Build Pattern', 'Spirit + Citrus + Sweet', 'spirit-citrus-sweet'),
        ('Build Pattern', 'Spirit-Forward', 'spirit-forward'),
        ('Build Pattern', 'Split Base', 'split-base'),
        ('Build Pattern', 'Fortified Wine Forward', 'fortified-wine-forward'),
        ('Build Pattern', 'Simple 2-Ingredient', 'simple-2-ingredient'),
        ('Build Pattern', 'Simple 3-Ingredient', 'simple-3-ingredient'),
        ('Build Pattern', 'Simple 4-Ingredient', 'simple-4-ingredient'),
        ('Build Pattern', 'Complex Spec', 'complex-spec'),
        ('Build Pattern', 'Tiki Multi-Ingredient', 'tiki-multi-ingredient'),
        ('Build Pattern', 'Long Drink', 'long-drink'),
        ('Build Pattern', 'Short Drink', 'short-drink'),
        ('Build Pattern', 'Served Up', 'served-up'),
        ('Build Pattern', 'Over Crushed Ice', 'over-crushed-ice'),
        ('Build Pattern', 'Topped With Soda', 'topped-with-soda'),
        ('Build Pattern', 'Egg White / Foam', 'egg-white-foam'),
        ('Build Pattern', 'Hot Cocktail', 'hot-cocktail'),
        ('Build Pattern', 'Frozen Cocktail', 'frozen-cocktail')
)
INSERT INTO Tags (TagTypeId, Name, NormalizedName, CreatedUtc)
SELECT
    tagType.Id,
    seed.Name,
    seed.NormalizedName,
    strftime('%Y-%m-%dT%H:%M:%fZ', 'now')
FROM seed
INNER JOIN TagTypes tagType ON tagType.Name = seed.TagTypeName
WHERE NOT EXISTS (
    SELECT 1
    FROM Tags existing
    WHERE existing.TagTypeId = tagType.Id
      AND existing.NormalizedName = seed.NormalizedName
);

COMMIT TRANSACTION;
PRAGMA foreign_keys = ON;
