-- Generated from temp_scripts/seed_cocktail_tags_assignments.sql
-- Updated to join cocktails by CanonicalKey using production export data.
-- Updated to join tags by NormalizedName for resilience against display-name drift.
-- Safe to rerun because CocktailTags uses a primary key on (CocktailId, TagId).

-- First-pass cocktail tag assignments generated heuristically.
-- Safe to rerun if CocktailTags has a uniqueness constraint on (CocktailId, TagId).
-- If not, consider adding a unique index before rerunning.

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::algonquin'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::algonquin'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::aperol_spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::aperol_spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::aperol_spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'topped-with-soda'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::aperol_spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::aperol_spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::aperol_spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::aperol_spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'poolside'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::aperol_spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'aperitif'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.CanonicalKey = 'cocktail_recipe_book::aperol_spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'summer'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.CanonicalKey = 'cocktail_recipe_book::aperol_spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'low-abv'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::aperol_spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::aperol_spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'low-abv'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::apricot_mocktail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::army_and_navy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::army_and_navy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::army_and_navy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::army_and_navy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::army_and_navy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::aviation'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::aviation'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::aviation'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::aviation'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::aviation'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::aviation'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'complex-spec'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bahama_mama'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'tiki-multi-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bahama_mama'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'tropical'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bahama_mama'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'blended'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::banana_mocha_frapp'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'frozen-cocktail'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::banana_mocha_frapp'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::banana_mocha_frapp'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::banana_mocha_frapp'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bee_sting'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bees_knees'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bees_knees'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bees_knees'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bees_knees'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bees_knees'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bees_knees'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bellini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bellini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bellini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'topped-with-soda'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bellini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bellini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bellini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'brunchy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bellini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'playful'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bellini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'brunch'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bellini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'low-abv'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bellini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bellini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bijou'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bijou'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bijou'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bijou'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bijou'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'boozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bijou'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bijou'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::black_russian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::black_russian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::black_russian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-2-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::black_russian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::black_russian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::black_russian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'brunchy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bloody_mary'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'brunch'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bloody_mary'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'complex-spec'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::blue_hawaiian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'tiki-multi-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::blue_hawaiian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'tropical'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::blue_hawaiian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::boston_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'egg-white-foam'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::boston_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::boston_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::boston_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::boston_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'frothy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.CanonicalKey = 'cocktail_recipe_book::boston_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::boulevardier'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'equal-parts'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::boulevardier'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::boulevardier'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::boulevardier'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::boulevardier'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::boulevardier'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::boulevardier'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'boozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::boulevardier'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sophisticated'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::boulevardier'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'aperitif'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.CanonicalKey = 'cocktail_recipe_book::boulevardier'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::boulevardier'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bourbon_alexander'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-4-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bourbon_alexander'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bourbon_alexander'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bourbon_alexander'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'muddled'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bourbon_smash'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'smash'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bourbon_smash'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bramble'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'over-crushed-ice'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bramble'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bramble'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::bramble'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::brandy_alexander'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-4-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::brandy_alexander'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::brandy_alexander'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.CanonicalKey = 'cocktail_recipe_book::brandy_alexander'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'cobbler'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::brandy_cobbler'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'muddled'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::brandy_smash'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'smash'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::brandy_smash'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::brooklyn'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::brooklyn'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::brooklyn'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::brooklyn'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'boozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::brooklyn'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::brooklyn'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::brown_derby'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::brown_derby'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::brown_derby'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'brunchy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::caesar'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'brunch'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.CanonicalKey = 'cocktail_recipe_book::caesar'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::cape_codder'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::cape_codder'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::cape_codder'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::cape_codder'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::cape_codder'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::casino'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'user_added::chancellor'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'user_added::chancellor'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-4-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'user_added::chancellor'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'user_added::chancellor'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'user_added::chancellor'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::chrysanthemum'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::chrysanthemum'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::cilantro_limeade_cooler'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'cooler'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::cilantro_limeade_cooler'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'blended'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::classic_cocktail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::classic_cocktail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'frozen-cocktail'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::classic_cocktail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::classic_cocktail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::clover_club'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'egg-white-foam'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::clover_club'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-4-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::clover_club'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'frothy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.CanonicalKey = 'cocktail_recipe_book::clover_club'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'user_added::coastal_spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'topped-with-soda'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'user_added::coastal_spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'user_added::coastal_spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'low-abv'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'user_added::coastal_spritz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::coconut_fizz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'topped-with-soda'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::coconut_fizz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'fizz'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::coconut_fizz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::corpse_reviver'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-4-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::corpse_reviver'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::corpse_reviver'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::corpse_reviver_#2'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'equal-parts'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::corpse_reviver_#2'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::corpse_reviver_#2'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-4-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::corpse_reviver_#2'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::corpse_reviver_#2'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::corpse_reviver_#2'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::cosmopolitan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::cosmopolitan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-4-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::cosmopolitan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'playful'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::cosmopolitan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'crusta'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::crusta'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::cuba_libre'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::cuba_libre'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::cuba_libre'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::cuba_libre'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::daiquiri'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::daiquiri'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::daiquiri'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::daiquiri'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::daiquiri'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::daiquiri'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'blended'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::daiquiri_blended'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'frozen-cocktail'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::daiquiri_blended'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::daiquiri_with_fruit'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::dark_and_stormy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::dark_and_stormy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::dark_and_stormy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::dark_and_stormy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'buck'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::dark_and_stormy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::dark_and_stormy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::dark_and_stormy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::dark_and_stormy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::de_la_louisiane_#4'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::de_la_louisiane_#4'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::de_la_louisiane_#4'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::de_la_louisiane_#4'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::de_la_louisiane_#4'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::diamondback'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::diamondback'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::diamondback'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::diamondback'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::diamondback'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::el_diablo'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::el_diablo'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::el_diablo'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::el_diablo'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'buck'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::el_diablo'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spicy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::el_diablo'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::embassy_cocktail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::embassy_cocktail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::fancy_free'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::fancy_free'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::fancy_free'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::fancy_free'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::fancy_free'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::final_ward'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'equal-parts'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::final_ward'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::final_ward'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-4-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::final_ward'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::final_ward'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::final_ward'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::french_75'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::french_75'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::french_75'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::french_75'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'topped-with-soda'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::french_75'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'fizz'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::french_75'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::french_75'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::french_75'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::french_75'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'brunchy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::french_75'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'brunch'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.CanonicalKey = 'cocktail_recipe_book::french_75'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::french_connection'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::french_connection'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::french_connection'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-2-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::french_connection'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::french_connection'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::french_connection'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::french_martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::french_martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-4-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::french_martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'playful'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::french_martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_buck'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_buck'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_buck'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'buck'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_buck'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_buck'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_buck'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_rickey'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_rickey'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_rickey'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'rickey'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_rickey'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_rickey'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_rickey'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-2-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'highball'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_and_tonic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_and_tonic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-2-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_and_tonic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'highball'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_and_tonic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_and_tonic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_and_tonic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gin_and_tonic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'muddled'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::ginger_julep'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'over-crushed-ice'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::ginger_julep'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'julep'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::ginger_julep'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spicy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::ginger_julep'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spicy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::ginger_and_fred'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::godfather'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::godfather'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::godfather'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-2-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::godfather'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::godfather'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::godfather'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gold_rush_by_sasha_petraske'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gold_rush_by_sasha_petraske'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gold_rush_by_sasha_petraske'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gold_rush_by_sasha_petraske'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::gold_rush_by_sasha_petraske'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::greyhound'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::greyhound'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-2-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::greyhound'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::greyhound'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::greyhound'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::greyhound'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::hanky_panky'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::hanky_panky'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::hanky_panky'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::hanky_panky'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::hanky_panky'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'boozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::hanky_panky'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::hanky_panky'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::hibiscus_lemongrass_iced_tea_cooler'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'cooler'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::hibiscus_lemongrass_iced_tea_cooler'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'hot-cocktail'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::hot_apple_cider'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'warming'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::hot_apple_cider'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'cozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::hot_apple_cider'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'winter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.CanonicalKey = 'cocktail_recipe_book::hot_apple_cider'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'hot-cocktail'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::hot_toddy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'warming'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::hot_toddy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'cozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::hot_toddy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'winter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.CanonicalKey = 'cocktail_recipe_book::hot_toddy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::jungle_bird'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'complex-spec'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::jungle_bird'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-4-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::jungle_bird'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'tiki-multi-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::jungle_bird'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::jungle_bird'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'tropical'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::jungle_bird'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::kamikaze'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::kamikaze'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::kentucky_buck_by_eric_castro'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::kentucky_buck_by_eric_castro'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::kentucky_buck_by_eric_castro'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'buck'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::kentucky_buck_by_eric_castro'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spicy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::kentucky_buck_by_eric_castro'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::kir_royale'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'brunchy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::kir_royale'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'brunch'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.CanonicalKey = 'cocktail_recipe_book::kir_royale'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'low-abv'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::kir_royale'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::last_word'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'equal-parts'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::last_word'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::last_word'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-4-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::last_word'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::last_word'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::last_word'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::left_bank_martini_by_simon_difford'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::left_bank_martini_by_simon_difford'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::left_bank_martini_by_simon_difford'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::lemon_drop'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::lemon_drop'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::lemonade'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'low-abv'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::lemonade'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::long_island_iced_tea'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'complex-spec'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::long_island_iced_tea'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::long_island_iced_tea'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'high-octane'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::long_island_iced_tea'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::lorraine'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::lorraine'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::lorraine'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::lynchburg_lemonade'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mai_tai'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'complex-spec'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mai_tai'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'over-crushed-ice'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mai_tai'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-4-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mai_tai'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'tiki-multi-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mai_tai'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'tropical'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mai_tai'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'poolside'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mai_tai'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'summer'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mai_tai'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mamie_taylor'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'buck'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mamie_taylor'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::manhattan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::manhattan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::manhattan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::manhattan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::manhattan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::manhattan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'boozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::manhattan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sophisticated'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::manhattan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::manhattan'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::margarita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::margarita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::margarita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::margarita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::margarita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'playful'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::margarita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'blended'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::margarita_blended'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'frozen-cocktail'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::margarita_blended'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'boozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sophisticated'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'high-octane'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'tropical'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mary_pickford'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mexican_mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mexican_mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mexican_mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mexican_mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'buck'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mexican_mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mexican_mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mexican_mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spicy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mexican_mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::mexicocoa_eggnog'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'cozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::mexicocoa_eggnog'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'winter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::mexicocoa_eggnog'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::mexicocoa_eggnog'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'user_added::midnight_reverie'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::milk_punch'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'cozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::milk_punch'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'winter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.CanonicalKey = 'cocktail_recipe_book::milk_punch'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.CanonicalKey = 'cocktail_recipe_book::milk_punch'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::millionaire'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'egg-white-foam'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::millionaire'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::millionaire'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-4-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::millionaire'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'frothy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.CanonicalKey = 'cocktail_recipe_book::millionaire'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'topped-with-soda'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'brunchy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'playful'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'brunch'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'low-abv'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mimosa'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'muddled'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mint_julep'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'over-crushed-ice'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mint_julep'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'julep'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mint_julep'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'complex-spec'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::missionarys_downfall'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'over-crushed-ice'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::missionarys_downfall'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'tiki-multi-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::missionarys_downfall'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'tropical'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::missionarys_downfall'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'muddled'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mojito'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mojito'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mojito'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mojito'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'poolside'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mojito'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'summer'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mojito'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mojito'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'user_added::monte_carlo'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'user_added::monte_carlo'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'user_added::monte_carlo'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'user_added::monte_carlo'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'user_added::monte_carlo'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::morning_glory_fizz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'topped-with-soda'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::morning_glory_fizz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'fizz'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::morning_glory_fizz'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::moscow_mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::moscow_mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::moscow_mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::moscow_mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'buck'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::moscow_mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::moscow_mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::moscow_mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spicy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::moscow_mule'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mudslide'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.CanonicalKey = 'cocktail_recipe_book::mudslide'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::negroni'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'equal-parts'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::negroni'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::negroni'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::negroni'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::negroni'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::negroni'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::negroni'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'boozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::negroni'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sophisticated'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::negroni'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'aperitif'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.CanonicalKey = 'cocktail_recipe_book::negroni'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::negroni'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'egg-white-foam'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::new_york_flip'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'flip'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::new_york_flip'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'frothy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.CanonicalKey = 'cocktail_recipe_book::new_york_flip'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::new_york_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-4-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::new_york_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::new_york_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::new_york_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::new_york_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::old_cuban_by_audrey_saunders'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::old_cuban_by_audrey_saunders'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::old_cuban_by_audrey_saunders'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'topped-with-soda'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::old_cuban_by_audrey_saunders'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'fizz'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::old_cuban_by_audrey_saunders'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::old_fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::old_fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::old_fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::old_fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::old_fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::old_fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'boozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::old_fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'warming'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::old_fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::old_fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::olympic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::olympic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::orangeade'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'low-abv'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::orangeade'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::oriental'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::oriental'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::oriental'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::oriental'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'complex-spec'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::painkiller'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'tiki-multi-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::painkiller'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::painkiller'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'tropical'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::painkiller'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'poolside'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::painkiller'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'summer'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.CanonicalKey = 'cocktail_recipe_book::painkiller'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.CanonicalKey = 'cocktail_recipe_book::painkiller'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::paloma'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::paloma'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::paloma'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::paloma'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::paloma'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::paloma'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::paloma'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'poolside'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::paloma'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'summer'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.CanonicalKey = 'cocktail_recipe_book::paloma'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::paloma'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'user_added::paper_plane'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'equal-parts'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'user_added::paper_plane'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'user_added::paper_plane'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-4-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'user_added::paper_plane'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'user_added::paper_plane'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'user_added::paper_plane'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::paradise'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::paradise_cooler'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'cooler'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::paradise_cooler'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::pegu_club'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::pegu_club'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-4-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::pegu_club'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::pegu_club'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::pegu_club'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::pegu_club'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::penicillin'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::penicillin'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::penicillin'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spicy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::penicillin'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'warming'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::penicillin'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'tiki-multi-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::piña_colada'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::piña_colada'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'tropical'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::piña_colada'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'playful'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::piña_colada'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'poolside'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::piña_colada'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'summer'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Occasion'
WHERE c.CanonicalKey = 'cocktail_recipe_book::piña_colada'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.CanonicalKey = 'cocktail_recipe_book::piña_colada'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'blended'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::piña_colada_blended'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'frozen-cocktail'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::piña_colada_blended'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'low-abv'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::pi_a_un_colada'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'complex-spec'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::planters_punch'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'tiki-multi-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::planters_punch'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'tropical'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::planters_punch'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'blended'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::plum_mango_lassi'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'frozen-cocktail'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::plum_mango_lassi'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::plum_mango_lassi'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'creamy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Texture'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::plum_mango_lassi'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::presbyterian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::presbyterian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::presbyterian'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::red_hook_by_enzo_enrico'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::red_hook_by_enzo_enrico'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::red_hook_by_enzo_enrico'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::red_hook_by_enzo_enrico'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::red_hook_by_enzo_enrico'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rob_roy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rob_roy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rob_roy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rob_roy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rob_roy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rob_roy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'boozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rob_roy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sophisticated'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rob_roy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rob_roy'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rosita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rosita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rosita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rosita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rosita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rosita'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::roy_rogers'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::roy_rogers'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'topped-with-soda'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::roy_rogers'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::roy_rogers'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'low-abv'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::roy_rogers'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::roy_rogers'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'muddled'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::royal_mojito'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'muddled'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rum_caipirinha'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'complex-spec'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rum_runner'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'tiki-multi-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rum_runner'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'tropical'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rum_runner'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'swizzled'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rum_swizzle'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'over-crushed-ice'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rum_swizzle'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'swizzle'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rum_swizzle'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rusty_nail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rusty_nail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rusty_nail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-2-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rusty_nail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rusty_nail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'warming'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rusty_nail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::rusty_nail'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::sazerac'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::sazerac'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::sazerac'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::sazerac'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::sazerac'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::sazerac'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'boozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::sazerac'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sophisticated'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::sazerac'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'high-octane'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::sazerac'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::sazerac'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::scotch_old_fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::scotch_old_fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::scotch_old_fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::scotch_old_fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::scotch_old_fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::scotch_old_fashioned'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::scotch_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::scotch_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::scotch_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::scotch_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::scotch_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::scotch_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'warming'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::scotch_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::scotch_and_soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::scotch_and_soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-2-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::scotch_and_soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'highball'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::scotch_and_soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::scotch_and_soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::scotch_and_soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::scotch_and_soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::screwdriver'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::screwdriver'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-2-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::screwdriver'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::sea_breeze'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::sea_breeze'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::sea_breeze'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::sea_breeze'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::sea_breeze'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'playful'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::sex_on_the_beach'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::shirley_temple'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::shirley_temple'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'topped-with-soda'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::shirley_temple'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::shirley_temple'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'low-abv'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::shirley_temple'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::shirley_temple'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::sidecar'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::sidecar'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::sidecar'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::sidecar'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::sidecar'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::sidecar'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'complex-spec'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::singapore_sling'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::singapore_sling'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sling'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::singapore_sling'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'blended'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::springtime_smoothie'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'frozen-cocktail'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::springtime_smoothie'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::summer_cooler'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'cooler'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::summer_cooler'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'muddled'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::tequila_smash'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'smash'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::tequila_smash'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::tequila_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::tequila_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::tequila_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::tequila_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::tequila_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::tequila_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::tequila_tonic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::tequila_tonic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::tequila_tonic'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::the_liberal'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::the_liberal'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::the_liberal'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::the_liberal'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::the_liberal'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::the_liberal'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::the_marguerite'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::the_modern'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::the_modern'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::the_modern'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::the_modern'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::third_degree'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::tom_collins'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::tom_collins'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::tom_collins'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::tom_collins'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'topped-with-soda'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::tom_collins'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'collins'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::tom_collins'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::tom_collins'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::tom_collins'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::tom_collins'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::tom_collins'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'equal-parts'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::trinidad_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-4-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::trinidad_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::trinidad_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::trinidad_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::trinidad_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'high-octane'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::trinidad_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::trinidad_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vesper'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'equal-parts'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vesper'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vesper'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vesper'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vesper'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'high-octane'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vesper'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vesper'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vieux_carré'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vieux_carré'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vieux_carré'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vieux_carré'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'bitter'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vieux_carré'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'boozy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vieux_carré'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sophisticated'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Mood'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vieux_carré'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'high-octane'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vieux_carré'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vieux_carré'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'low-abv'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::virgin_bite_of_the_iguana'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'low-abv'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'ultimate_bar_book_the_comprehensive_guid::virgin_mary'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'stirred'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vodka_martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vodka_martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'short-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vodka_martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vodka_martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'high-octane'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vodka_martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-forward'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vodka_martini'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'built'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vodka_soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'long-drink'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vodka_soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-2-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vodka_soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'highball'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vodka_soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'fizzy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vodka_soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'refreshing'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vodka_soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sessionable'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::vodka_soda'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::ward_eight'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::ward_eight'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::ward_eight'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::ward_eight'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::whiskey_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::whiskey_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::whiskey_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::whiskey_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::whiskey_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::whiskey_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'warming'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::whiskey_sour'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'shaken'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Method'
WHERE c.CanonicalKey = 'cocktail_recipe_book::white_lady'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'served-up'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::white_lady'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'simple-3-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::white_lady'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'spirit-citrus-sweet'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::white_lady'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'sour'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Cocktail Family'
WHERE c.CanonicalKey = 'cocktail_recipe_book::white_lady'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'citrusy'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::white_lady'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'complex-spec'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::zombie'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'over-crushed-ice'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::zombie'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'tiki-multi-ingredient'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Build Pattern'
WHERE c.CanonicalKey = 'cocktail_recipe_book::zombie'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'tropical'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Flavor Profile'
WHERE c.CanonicalKey = 'cocktail_recipe_book::zombie'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );

INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
SELECT c.Id, t.Id, CURRENT_TIMESTAMP
FROM Cocktails c
JOIN Tags t ON t.NormalizedName = 'high-octane'
JOIN TagTypes tt ON tt.Id = t.TagTypeId AND tt.Name = 'Strength'
WHERE c.CanonicalKey = 'cocktail_recipe_book::zombie'
  AND NOT EXISTS (
    SELECT 1 FROM CocktailTags ct
    WHERE ct.CocktailId = c.Id AND ct.TagId = t.Id
  );
