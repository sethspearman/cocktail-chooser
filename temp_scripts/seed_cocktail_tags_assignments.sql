-- First-pass cocktail tag assignments generated heuristically.
-- Safe to rerun if CocktailTags has a uniqueness constraint on (CocktailId, TagId).
-- If not, consider adding a unique index before rerunning.

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Algonquin'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Algonquin'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Aperol Spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Aperol Spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Aperol Spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Topped With Soda'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Aperol Spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Aperol Spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Aperol Spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Aperol Spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Poolside'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Aperol Spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Aperitif'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.Name = 'Aperol Spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Summer'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.Name = 'Aperol Spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Low-ABV'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Aperol Spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Aperol Spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Low-ABV'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Apricot Mocktail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Army and Navy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Army and Navy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Army and Navy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Army and Navy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Army and Navy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Aviation'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Aviation'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Aviation'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Aviation'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Aviation'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Aviation'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Complex Spec'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Bahama Mama'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Tiki Multi Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Bahama Mama'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Tropical'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Bahama Mama'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Blended'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Banana Mocha Frappé'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Frozen Cocktail'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Banana Mocha Frappé'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Banana Mocha Frappé'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.Name = 'Banana Mocha Frappé'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Bee Sting'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Bee''s Knees'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Bee''s Knees'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Bee''s Knees'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Bee''s Knees'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Bee''s Knees'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Bee''s Knees'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Bellini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Bellini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Bellini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Topped With Soda'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Bellini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Bellini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Bellini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Brunchy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Bellini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Playful'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Bellini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Brunch'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.Name = 'Bellini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Low-ABV'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Bellini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Bellini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Bijou'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Bijou'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Bijou'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Bijou'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Bijou'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Boozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Bijou'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Bijou'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Black Russian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Black Russian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Black Russian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 2 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Black Russian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Black Russian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Black Russian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Brunchy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Bloody Mary'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Brunch'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.Name = 'Bloody Mary'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Complex Spec'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Blue Hawaiian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Tiki Multi Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Blue Hawaiian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Tropical'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Blue Hawaiian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Boston Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Egg White / Foam'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Boston Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Boston Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Boston Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Boston Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Frothy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.Name = 'Boston Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Boulevardier'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Equal Parts'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Boulevardier'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Boulevardier'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Boulevardier'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Boulevardier'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Boulevardier'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Boulevardier'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Boozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Boulevardier'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sophisticated'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Boulevardier'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Aperitif'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.Name = 'Boulevardier'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Boulevardier'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Bourbon Alexander'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 4 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Bourbon Alexander'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Bourbon Alexander'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.Name = 'Bourbon Alexander'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Muddled'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Bourbon Smash'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Smash'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Bourbon Smash'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Bramble'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Over Crushed Ice'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Bramble'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Bramble'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Bramble'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Brandy Alexander'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 4 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Brandy Alexander'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Brandy Alexander'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.Name = 'Brandy Alexander'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Cobbler'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Brandy Cobbler'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Muddled'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Brandy Smash'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Smash'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Brandy Smash'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Brooklyn'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Brooklyn'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Brooklyn'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Brooklyn'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Boozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Brooklyn'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Brooklyn'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Brown Derby'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Brown Derby'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Brown Derby'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Brunchy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Caesar'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Brunch'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.Name = 'Caesar'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Cape Codder'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Cape Codder'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Cape Codder'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Cape Codder'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Cape Codder'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Casino'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Chancellor'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Chancellor'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 4 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Chancellor'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Chancellor'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Chancellor'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Chrysanthemum'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Chrysanthemum'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Cilantro Limeade Cooler'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Cooler'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Cilantro Limeade Cooler'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Blended'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Classic Cocktail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Classic Cocktail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Frozen Cocktail'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Classic Cocktail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Classic Cocktail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Clover Club'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Egg White / Foam'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Clover Club'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 4 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Clover Club'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Frothy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.Name = 'Clover Club'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Coastal Spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Topped With Soda'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Coastal Spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Coastal Spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Low-ABV'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Coastal Spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Coconut Fizz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Topped With Soda'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Coconut Fizz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Fizz'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Coconut Fizz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Corpse Reviver'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 4 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Corpse Reviver'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Corpse Reviver'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Corpse Reviver #2'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Equal Parts'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Corpse Reviver #2'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Corpse Reviver #2'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 4 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Corpse Reviver #2'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Corpse Reviver #2'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Corpse Reviver #2'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Cosmopolitan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Cosmopolitan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 4 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Cosmopolitan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Playful'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Cosmopolitan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Crusta'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Crusta'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Cuba Libre'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Cuba Libre'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Cuba Libre'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Cuba Libre'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Daiquiri'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Daiquiri'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Daiquiri'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Daiquiri'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Daiquiri'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Daiquiri'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Blended'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Daiquiri (Blended)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Frozen Cocktail'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Daiquiri (Blended)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Daiquiri (With Fruit)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Dark and Stormy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Dark and Stormy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Dark and Stormy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Dark and Stormy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Buck'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Dark and Stormy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Dark and Stormy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Dark and Stormy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Dark and Stormy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'De La Louisiane #4'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'De La Louisiane #4'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'De La Louisiane #4'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'De La Louisiane #4'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'De La Louisiane #4'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Diamondback'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Diamondback'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Diamondback'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Diamondback'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Diamondback'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'El Diablo'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'El Diablo'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'El Diablo'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'El Diablo'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Buck'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'El Diablo'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spicy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'El Diablo'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Embassy Cocktail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Embassy Cocktail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Fancy Free'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Fancy Free'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Fancy Free'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Fancy Free'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Fancy Free'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Final Ward'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Equal Parts'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Final Ward'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Final Ward'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 4 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Final Ward'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Final Ward'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Final Ward'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'French 75'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'French 75'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'French 75'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'French 75'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Topped With Soda'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'French 75'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Fizz'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'French 75'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'French 75'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'French 75'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'French 75'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Brunchy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'French 75'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Brunch'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.Name = 'French 75'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'French Connection'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'French Connection'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'French Connection'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 2 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'French Connection'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'French Connection'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'French Connection'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'French Martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'French Martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 4 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'French Martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Playful'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'French Martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Gin Buck'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Gin Buck'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Gin Buck'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Buck'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Gin Buck'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Gin Buck'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Gin Buck'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Gin Rickey'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Gin Rickey'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Gin Rickey'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Rickey'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Gin Rickey'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Gin Rickey'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Gin Rickey'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Gin Soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Gin Soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 2 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Gin Soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Highball'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Gin Soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Gin Soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Gin and Tonic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Gin and Tonic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 2 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Gin and Tonic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Highball'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Gin and Tonic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Gin and Tonic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Gin and Tonic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Gin and Tonic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Muddled'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Ginger Julep'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Over Crushed Ice'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Ginger Julep'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Julep'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Ginger Julep'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spicy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Ginger Julep'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spicy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Ginger and Fred'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Godfather'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Godfather'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Godfather'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 2 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Godfather'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Godfather'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Godfather'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Gold Rush (by Sasha Petraske)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Gold Rush (by Sasha Petraske)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Gold Rush (by Sasha Petraske)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Gold Rush (by Sasha Petraske)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Gold Rush (by Sasha Petraske)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Greyhound'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Greyhound'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 2 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Greyhound'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Greyhound'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Greyhound'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Greyhound'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Hanky Panky'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Hanky Panky'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Hanky Panky'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Hanky Panky'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Hanky Panky'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Boozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Hanky Panky'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Hanky Panky'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Hibiscus-Lemongrass Iced Tea Cooler'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Cooler'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Hibiscus-Lemongrass Iced Tea Cooler'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Hot Cocktail'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Hot Apple Cider'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Warming'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Hot Apple Cider'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Cozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Hot Apple Cider'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Winter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.Name = 'Hot Apple Cider'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Hot Cocktail'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Hot Toddy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Warming'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Hot Toddy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Cozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Hot Toddy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Winter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.Name = 'Hot Toddy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Jungle Bird'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Complex Spec'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Jungle Bird'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 4 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Jungle Bird'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Tiki Multi Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Jungle Bird'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Jungle Bird'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Tropical'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Jungle Bird'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Kamikaze'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Kamikaze'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Kentucky Buck (by Eric Castro)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Kentucky Buck (by Eric Castro)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Kentucky Buck (by Eric Castro)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Buck'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Kentucky Buck (by Eric Castro)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spicy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Kentucky Buck (by Eric Castro)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Kir Royale'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Brunchy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Kir Royale'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Brunch'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.Name = 'Kir Royale'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Low-ABV'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Kir Royale'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Last Word'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Equal Parts'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Last Word'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Last Word'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 4 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Last Word'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Last Word'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Last Word'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Left Bank Martini (by Simon Difford)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Left Bank Martini (by Simon Difford)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Left Bank Martini (by Simon Difford)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Lemon Drop'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Lemon Drop'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Lemonade'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Low-ABV'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Lemonade'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Long Island Iced Tea'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Complex Spec'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Long Island Iced Tea'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Long Island Iced Tea'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'High-Octane'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Long Island Iced Tea'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Lorraine'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Lorraine'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Lorraine'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Lynchburg Lemonade'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Mai Tai'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Complex Spec'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Mai Tai'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Over Crushed Ice'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Mai Tai'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 4 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Mai Tai'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Tiki Multi Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Mai Tai'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Tropical'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Mai Tai'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Poolside'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Mai Tai'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Summer'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.Name = 'Mai Tai'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Mamie Taylor'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Buck'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Mamie Taylor'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Manhattan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Manhattan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Manhattan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Manhattan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Manhattan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Manhattan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Boozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Manhattan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sophisticated'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Manhattan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Manhattan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Margarita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Margarita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Margarita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Margarita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Margarita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Playful'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Margarita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Blended'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Margarita (Blended)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Frozen Cocktail'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Margarita (Blended)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Boozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sophisticated'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'High-Octane'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Tropical'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Mary Pickford'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Mexican Mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Mexican Mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Mexican Mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Mexican Mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Buck'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Mexican Mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Mexican Mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Mexican Mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spicy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Mexican Mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Mexicocoa Eggnog'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Cozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Mexicocoa Eggnog'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Winter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.Name = 'Mexicocoa Eggnog'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.Name = 'Mexicocoa Eggnog'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Midnight Reverie'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Milk Punch'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Cozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Milk Punch'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Winter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.Name = 'Milk Punch'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.Name = 'Milk Punch'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Millionaire'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Egg White / Foam'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Millionaire'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Millionaire'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 4 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Millionaire'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Frothy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.Name = 'Millionaire'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Topped With Soda'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Brunchy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Playful'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Brunch'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.Name = 'Mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Low-ABV'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Muddled'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Mint Julep'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Over Crushed Ice'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Mint Julep'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Julep'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Mint Julep'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Complex Spec'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Missionary''s Downfall'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Over Crushed Ice'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Missionary''s Downfall'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Tiki Multi Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Missionary''s Downfall'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Tropical'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Missionary''s Downfall'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Muddled'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Mojito'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Mojito'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Mojito'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Mojito'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Poolside'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Mojito'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Summer'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.Name = 'Mojito'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Mojito'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Monte Carlo'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Monte Carlo'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Monte Carlo'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Monte Carlo'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Monte Carlo'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Morning Glory Fizz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Topped With Soda'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Morning Glory Fizz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Fizz'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Morning Glory Fizz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Moscow Mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Moscow Mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Moscow Mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Moscow Mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Buck'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Moscow Mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Moscow Mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Moscow Mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spicy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Moscow Mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Mudslide'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.Name = 'Mudslide'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Negroni'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Equal Parts'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Negroni'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Negroni'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Negroni'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Negroni'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Negroni'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Negroni'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Boozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Negroni'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sophisticated'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Negroni'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Aperitif'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.Name = 'Negroni'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Negroni'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Egg White / Foam'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'New York Flip'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Flip'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'New York Flip'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Frothy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.Name = 'New York Flip'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'New York Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 4 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'New York Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'New York Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'New York Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'New York Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Old Cuban (by Audrey Saunders)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Old Cuban (by Audrey Saunders)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Old Cuban (by Audrey Saunders)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Topped With Soda'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Old Cuban (by Audrey Saunders)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Fizz'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Old Cuban (by Audrey Saunders)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Old Fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Old Fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Old Fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Old Fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Old Fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Old Fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Boozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Old Fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Warming'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Old Fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Old Fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Olympic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Olympic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Orangeade'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Low-ABV'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Orangeade'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Oriental'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Oriental'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Oriental'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Oriental'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Complex Spec'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Painkiller'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Tiki Multi Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Painkiller'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Painkiller'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Tropical'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Painkiller'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Poolside'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Painkiller'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Summer'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.Name = 'Painkiller'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.Name = 'Painkiller'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Paloma'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Paloma'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Paloma'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Paloma'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Paloma'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Paloma'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Paloma'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Poolside'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Paloma'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Summer'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.Name = 'Paloma'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Paloma'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Paper Plane'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Equal Parts'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Paper Plane'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Paper Plane'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 4 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Paper Plane'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Paper Plane'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Paper Plane'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Paradise'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Paradise Cooler'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Cooler'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Paradise Cooler'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Pegu Club'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Pegu Club'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 4 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Pegu Club'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Pegu Club'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Pegu Club'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Pegu Club'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Penicillin'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Penicillin'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Penicillin'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spicy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Penicillin'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Warming'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Penicillin'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Tiki Multi Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Piña Colada'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Piña Colada'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Tropical'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Piña Colada'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Playful'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Piña Colada'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Poolside'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Piña Colada'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Summer'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.Name = 'Piña Colada'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.Name = 'Piña Colada'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Blended'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Piña Colada (Blended)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Frozen Cocktail'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Piña Colada (Blended)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Low-ABV'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Piña Un-Colada'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Complex Spec'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Planter''s Punch'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Tiki Multi Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Planter''s Punch'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Tropical'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Planter''s Punch'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Blended'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Plum Mango Lassi'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Frozen Cocktail'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Plum Mango Lassi'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Plum Mango Lassi'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.Name = 'Plum Mango Lassi'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Presbyterian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Presbyterian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Presbyterian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Red Hook (by Enzo Enrico)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Red Hook (by Enzo Enrico)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Red Hook (by Enzo Enrico)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Red Hook (by Enzo Enrico)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Red Hook (by Enzo Enrico)'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Rob Roy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Rob Roy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Rob Roy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Rob Roy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Rob Roy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Rob Roy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Boozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Rob Roy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sophisticated'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Rob Roy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Rob Roy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Rosita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Rosita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Rosita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Rosita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Rosita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Rosita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Roy Rogers'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Roy Rogers'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Topped With Soda'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Roy Rogers'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Roy Rogers'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Low-ABV'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Roy Rogers'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Roy Rogers'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Muddled'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Royal Mojito'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Muddled'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Rum Caipirinha'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Complex Spec'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Rum Runner'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Tiki Multi Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Rum Runner'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Tropical'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Rum Runner'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Swizzled'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Rum Swizzle'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Over Crushed Ice'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Rum Swizzle'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Swizzle'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Rum Swizzle'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Rusty Nail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Rusty Nail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Rusty Nail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 2 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Rusty Nail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Rusty Nail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Warming'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Rusty Nail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Rusty Nail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Sazerac'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Sazerac'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Sazerac'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Sazerac'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Sazerac'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Sazerac'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Boozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Sazerac'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sophisticated'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Sazerac'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'High-Octane'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Sazerac'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Sazerac'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Scotch Old-Fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Scotch Old-Fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Scotch Old-Fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Scotch Old-Fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Scotch Old-Fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Scotch Old-Fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Scotch Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Scotch Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Scotch Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Scotch Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Scotch Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Scotch Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Warming'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Scotch Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Scotch and Soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Scotch and Soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 2 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Scotch and Soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Highball'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Scotch and Soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Scotch and Soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Scotch and Soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Scotch and Soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Screwdriver'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Screwdriver'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 2 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Screwdriver'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Sea Breeze'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Sea Breeze'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Sea Breeze'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Sea Breeze'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Sea Breeze'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Playful'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Sex on the Beach'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Shirley Temple'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Shirley Temple'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Topped With Soda'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Shirley Temple'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Shirley Temple'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Low-ABV'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Shirley Temple'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Shirley Temple'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Sidecar'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Sidecar'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Sidecar'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Sidecar'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Sidecar'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Sidecar'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Complex Spec'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Singapore Sling'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Singapore Sling'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sling'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Singapore Sling'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Blended'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Springtime Smoothie'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Frozen Cocktail'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Springtime Smoothie'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Summer Cooler'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Cooler'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Summer Cooler'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Muddled'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Tequila Smash'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Smash'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Tequila Smash'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Tequila Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Tequila Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Tequila Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Tequila Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Tequila Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Tequila Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Tequila Tonic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Tequila Tonic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Tequila Tonic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'The Liberal'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'The Liberal'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'The Liberal'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'The Liberal'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'The Liberal'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'The Liberal'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'The Marguerite'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'The Modern'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'The Modern'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'The Modern'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'The Modern'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Third Degree'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Tom Collins'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Tom Collins'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Tom Collins'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Tom Collins'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Topped With Soda'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Tom Collins'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Collins'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Tom Collins'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Tom Collins'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Tom Collins'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Tom Collins'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Tom Collins'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Equal Parts'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Trinidad Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 4 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Trinidad Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Trinidad Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Trinidad Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Trinidad Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'High-Octane'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Trinidad Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Trinidad Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Vesper'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Equal Parts'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Vesper'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Vesper'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Vesper'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Vesper'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'High-Octane'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Vesper'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Vesper'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Vieux Carré'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Vieux Carré'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Vieux Carré'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Vieux Carré'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Vieux Carré'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Boozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Vieux Carré'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sophisticated'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.Name = 'Vieux Carré'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'High-Octane'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Vieux Carré'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Vieux Carré'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Low-ABV'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Virgin Bite of the Iguana'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Low-ABV'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Virgin Mary'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Vodka Martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Vodka Martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Short Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Vodka Martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Vodka Martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'High-Octane'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Vodka Martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit-Forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Vodka Martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Vodka Soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Long Drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Vodka Soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 2 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Vodka Soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Highball'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Vodka Soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Vodka Soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Vodka Soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Vodka Soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Ward Eight'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Ward Eight'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Ward Eight'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Ward Eight'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'Whiskey Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Whiskey Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Whiskey Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'Whiskey Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Whiskey Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Whiskey Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Warming'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Whiskey Sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.Name = 'White Lady'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Served Up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'White Lady'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Simple 3 Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'White Lady'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Spirit + Citrus + Sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'White Lady'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.Name = 'White Lady'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'White Lady'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Complex Spec'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Zombie'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Over Crushed Ice'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Zombie'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Tiki Multi Ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.Name = 'Zombie'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'Tropical'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.Name = 'Zombie'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.Name = 'High-Octane'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.Name = 'Zombie'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );
