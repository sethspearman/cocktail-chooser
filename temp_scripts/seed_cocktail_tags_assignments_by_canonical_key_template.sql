-- Production-safe template for cocktail tag assignments.
-- Replace the placeholder CanonicalKey values using an export from:
--   temp_scripts/export_cocktail_name_and_canonical_key.sql
--
-- This form is preferred over joining by Cocktail.Name because CanonicalKey
-- is unique and stable across formatting or naming differences.

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'manual::algonquin'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'manual::algonquin'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'manual::aperol_spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'manual::aperol_spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

-- Continue converting the name-based script using canonical keys from production.
