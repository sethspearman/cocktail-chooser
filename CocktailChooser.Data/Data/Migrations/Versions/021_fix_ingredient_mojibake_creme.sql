PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

DROP TRIGGER IF EXISTS trg_Ingredients_PreventDuplicateNormalizedName_Insert;
DROP TRIGGER IF EXISTS trg_Ingredients_PreventDuplicateNormalizedName_Update;

-- Repair UTF-8 mojibake from earlier imports (e.g., "CrÃ¨me" -> "Crème").
UPDATE Ingredients
SET Name = REPLACE(Name, 'Ã¨', 'è')
WHERE Name LIKE '%Ã¨%';

UPDATE Ingredients
SET NormalizedName = REPLACE(NormalizedName, 'Ã¨', 'è')
WHERE NormalizedName LIKE '%Ã¨%';

CREATE TRIGGER IF NOT EXISTS trg_Ingredients_PreventDuplicateNormalizedName_Insert
BEFORE INSERT ON Ingredients
WHEN COALESCE(NEW.NormalizedName, '') <> ''
 AND EXISTS (
    SELECT 1
    FROM Ingredients i
    WHERE i.NormalizedName = NEW.NormalizedName
    LIMIT 1
)
BEGIN
    SELECT RAISE(ABORT, 'Duplicate normalized ingredient name');
END;

CREATE TRIGGER IF NOT EXISTS trg_Ingredients_PreventDuplicateNormalizedName_Update
BEFORE UPDATE OF NormalizedName ON Ingredients
WHEN COALESCE(NEW.NormalizedName, '') <> ''
 AND EXISTS (
    SELECT 1
    FROM Ingredients i
    WHERE i.NormalizedName = NEW.NormalizedName
      AND i.Id <> NEW.Id
    LIMIT 1
)
BEGIN
    SELECT RAISE(ABORT, 'Duplicate normalized ingredient name');
END;

COMMIT;
PRAGMA foreign_keys = ON;
