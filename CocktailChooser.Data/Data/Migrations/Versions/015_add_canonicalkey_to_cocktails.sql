ALTER TABLE Cocktails
ADD COLUMN CanonicalKey TEXT;

UPDATE Cocktails
SET CanonicalKey =
    lower(trim(COALESCE((SELECT Name FROM CocktailSource s WHERE s.Id = Cocktails.CocktailSourceId), 'manual')))
    || '::' ||
    lower(trim(COALESCE(Name, 'cocktail')));

UPDATE Cocktails SET CanonicalKey = REPLACE(CanonicalKey, '&', ' and ');
UPDATE Cocktails SET CanonicalKey = REPLACE(CanonicalKey, '''', '');
UPDATE Cocktails SET CanonicalKey = REPLACE(CanonicalKey, '"', '');
UPDATE Cocktails SET CanonicalKey = REPLACE(CanonicalKey, '/', ' ');
UPDATE Cocktails SET CanonicalKey = REPLACE(CanonicalKey, '-', ' ');
UPDATE Cocktails SET CanonicalKey = REPLACE(CanonicalKey, '.', '');
UPDATE Cocktails SET CanonicalKey = REPLACE(CanonicalKey, ',', '');
UPDATE Cocktails SET CanonicalKey = REPLACE(CanonicalKey, '(', '');
UPDATE Cocktails SET CanonicalKey = REPLACE(CanonicalKey, ')', '');
UPDATE Cocktails SET CanonicalKey = REPLACE(CanonicalKey, '  ', ' ');
UPDATE Cocktails SET CanonicalKey = REPLACE(CanonicalKey, ' ', '_');
UPDATE Cocktails SET CanonicalKey = REPLACE(CanonicalKey, '__', '_');

WITH ranked AS (
    SELECT
        Id,
        CanonicalKey,
        ROW_NUMBER() OVER (PARTITION BY CanonicalKey ORDER BY Id) AS dup_rank
    FROM Cocktails
)
UPDATE Cocktails
SET CanonicalKey = CanonicalKey || '_' || (
    SELECT dup_rank
    FROM ranked
    WHERE ranked.Id = Cocktails.Id
)
WHERE Id IN (
    SELECT Id
    FROM ranked
    WHERE dup_rank > 1
);

CREATE UNIQUE INDEX IF NOT EXISTS UX_Cocktails_CanonicalKey
ON Cocktails (CanonicalKey);
