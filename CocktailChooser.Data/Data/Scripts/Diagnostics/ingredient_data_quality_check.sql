.headers on
.mode column

SELECT 'Mojibake candidates in Ingredients' AS Section;
SELECT
    Id,
    Name,
    NormalizedName
FROM Ingredients
WHERE Name GLOB '*[ÃÂâ�]*'
   OR NormalizedName GLOB '*[ÃÂâ�]*'
ORDER BY Id;

SELECT 'Duplicate NormalizedName groups' AS Section;
SELECT
    NormalizedName,
    COUNT(*) AS DuplicateCount,
    GROUP_CONCAT(Id, ', ') AS IngredientIds
FROM Ingredients
WHERE COALESCE(TRIM(NormalizedName), '') <> ''
GROUP BY NormalizedName
HAVING COUNT(*) > 1
ORDER BY DuplicateCount DESC, NormalizedName;

SELECT 'Ingredients with null/blank NormalizedName' AS Section;
SELECT
    Id,
    Name,
    NormalizedName
FROM Ingredients
WHERE COALESCE(TRIM(NormalizedName), '') = ''
ORDER BY Id;
