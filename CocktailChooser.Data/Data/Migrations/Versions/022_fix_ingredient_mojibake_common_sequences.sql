PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

DROP TRIGGER IF EXISTS trg_Ingredients_PreventDuplicateNormalizedName_Insert;
DROP TRIGGER IF EXISTS trg_Ingredients_PreventDuplicateNormalizedName_Update;

-- Broader mojibake cleanup for ingredient text fields.
-- Targets common UTF-8-decoded-as-Latin-1 sequences in imports.

-- Lowercase accents
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã ', 'à') WHERE Name LIKE '%Ã %';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã¡', 'á') WHERE Name LIKE '%Ã¡%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã¢', 'â') WHERE Name LIKE '%Ã¢%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã£', 'ã') WHERE Name LIKE '%Ã£%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã¤', 'ä') WHERE Name LIKE '%Ã¤%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã¥', 'å') WHERE Name LIKE '%Ã¥%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã§', 'ç') WHERE Name LIKE '%Ã§%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã¨', 'è') WHERE Name LIKE '%Ã¨%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã©', 'é') WHERE Name LIKE '%Ã©%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ãª', 'ê') WHERE Name LIKE '%Ãª%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã«', 'ë') WHERE Name LIKE '%Ã«%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã¬', 'ì') WHERE Name LIKE '%Ã¬%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã­', 'í') WHERE Name LIKE '%Ã­%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã®', 'î') WHERE Name LIKE '%Ã®%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã¯', 'ï') WHERE Name LIKE '%Ã¯%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã±', 'ñ') WHERE Name LIKE '%Ã±%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã²', 'ò') WHERE Name LIKE '%Ã²%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã³', 'ó') WHERE Name LIKE '%Ã³%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã´', 'ô') WHERE Name LIKE '%Ã´%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ãµ', 'õ') WHERE Name LIKE '%Ãµ%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã¶', 'ö') WHERE Name LIKE '%Ã¶%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã¹', 'ù') WHERE Name LIKE '%Ã¹%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ãº', 'ú') WHERE Name LIKE '%Ãº%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã»', 'û') WHERE Name LIKE '%Ã»%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã¼', 'ü') WHERE Name LIKE '%Ã¼%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã½', 'ý') WHERE Name LIKE '%Ã½%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã¿', 'ÿ') WHERE Name LIKE '%Ã¿%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Å“', 'œ') WHERE Name LIKE '%Å“%';

-- Uppercase accents
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã€', 'À') WHERE Name LIKE '%Ã€%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã', 'Á') WHERE Name LIKE '%Ã%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã‚', 'Â') WHERE Name LIKE '%Ã‚%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã‡', 'Ç') WHERE Name LIKE '%Ã‡%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ãˆ', 'È') WHERE Name LIKE '%Ãˆ%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã‰', 'É') WHERE Name LIKE '%Ã‰%';
UPDATE Ingredients SET Name = REPLACE(Name, 'ÃŠ', 'Ê') WHERE Name LIKE '%ÃŠ%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã‹', 'Ë') WHERE Name LIKE '%Ã‹%';
UPDATE Ingredients SET Name = REPLACE(Name, 'ÃŒ', 'Ì') WHERE Name LIKE '%ÃŒ%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã', 'Í') WHERE Name LIKE '%Ã%';
UPDATE Ingredients SET Name = REPLACE(Name, 'ÃŽ', 'Î') WHERE Name LIKE '%ÃŽ%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã', 'Ï') WHERE Name LIKE '%Ã%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã‘', 'Ñ') WHERE Name LIKE '%Ã‘%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã’', 'Ò') WHERE Name LIKE '%Ã’%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã“', 'Ó') WHERE Name LIKE '%Ã“%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã”', 'Ô') WHERE Name LIKE '%Ã”%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã–', 'Ö') WHERE Name LIKE '%Ã–%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã™', 'Ù') WHERE Name LIKE '%Ã™%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ãš', 'Ú') WHERE Name LIKE '%Ãš%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ã›', 'Û') WHERE Name LIKE '%Ã›%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Ãœ', 'Ü') WHERE Name LIKE '%Ãœ%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Å’', 'Œ') WHERE Name LIKE '%Å’%';

-- Smart punctuation / misc artifacts
UPDATE Ingredients SET Name = REPLACE(Name, 'â€™', '’') WHERE Name LIKE '%â€™%';
UPDATE Ingredients SET Name = REPLACE(Name, 'â€œ', '“') WHERE Name LIKE '%â€œ%';
UPDATE Ingredients SET Name = REPLACE(Name, 'â€', '”') WHERE Name LIKE '%â€%';
UPDATE Ingredients SET Name = REPLACE(Name, 'â€“', '–') WHERE Name LIKE '%â€“%';
UPDATE Ingredients SET Name = REPLACE(Name, 'â€”', '—') WHERE Name LIKE '%â€”%';
UPDATE Ingredients SET Name = REPLACE(Name, 'â€¦', '…') WHERE Name LIKE '%â€¦%';
UPDATE Ingredients SET Name = REPLACE(Name, 'â€¢', '•') WHERE Name LIKE '%â€¢%';
UPDATE Ingredients SET Name = REPLACE(Name, 'Â', '') WHERE Name LIKE '%Â%';

-- Repeat for NormalizedName
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã ', 'à') WHERE NormalizedName LIKE '%Ã %';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã¡', 'á') WHERE NormalizedName LIKE '%Ã¡%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã¢', 'â') WHERE NormalizedName LIKE '%Ã¢%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã£', 'ã') WHERE NormalizedName LIKE '%Ã£%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã¤', 'ä') WHERE NormalizedName LIKE '%Ã¤%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã¥', 'å') WHERE NormalizedName LIKE '%Ã¥%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã§', 'ç') WHERE NormalizedName LIKE '%Ã§%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã¨', 'è') WHERE NormalizedName LIKE '%Ã¨%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã©', 'é') WHERE NormalizedName LIKE '%Ã©%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ãª', 'ê') WHERE NormalizedName LIKE '%Ãª%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã«', 'ë') WHERE NormalizedName LIKE '%Ã«%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã¬', 'ì') WHERE NormalizedName LIKE '%Ã¬%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã­', 'í') WHERE NormalizedName LIKE '%Ã­%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã®', 'î') WHERE NormalizedName LIKE '%Ã®%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã¯', 'ï') WHERE NormalizedName LIKE '%Ã¯%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã±', 'ñ') WHERE NormalizedName LIKE '%Ã±%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã²', 'ò') WHERE NormalizedName LIKE '%Ã²%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã³', 'ó') WHERE NormalizedName LIKE '%Ã³%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã´', 'ô') WHERE NormalizedName LIKE '%Ã´%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ãµ', 'õ') WHERE NormalizedName LIKE '%Ãµ%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã¶', 'ö') WHERE NormalizedName LIKE '%Ã¶%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã¹', 'ù') WHERE NormalizedName LIKE '%Ã¹%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ãº', 'ú') WHERE NormalizedName LIKE '%Ãº%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã»', 'û') WHERE NormalizedName LIKE '%Ã»%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã¼', 'ü') WHERE NormalizedName LIKE '%Ã¼%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã½', 'ý') WHERE NormalizedName LIKE '%Ã½%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã¿', 'ÿ') WHERE NormalizedName LIKE '%Ã¿%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Å“', 'œ') WHERE NormalizedName LIKE '%Å“%';

UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã€', 'À') WHERE NormalizedName LIKE '%Ã€%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã', 'Á') WHERE NormalizedName LIKE '%Ã%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã‚', 'Â') WHERE NormalizedName LIKE '%Ã‚%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã‡', 'Ç') WHERE NormalizedName LIKE '%Ã‡%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ãˆ', 'È') WHERE NormalizedName LIKE '%Ãˆ%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã‰', 'É') WHERE NormalizedName LIKE '%Ã‰%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'ÃŠ', 'Ê') WHERE NormalizedName LIKE '%ÃŠ%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã‹', 'Ë') WHERE NormalizedName LIKE '%Ã‹%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'ÃŒ', 'Ì') WHERE NormalizedName LIKE '%ÃŒ%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã', 'Í') WHERE NormalizedName LIKE '%Ã%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'ÃŽ', 'Î') WHERE NormalizedName LIKE '%ÃŽ%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã', 'Ï') WHERE NormalizedName LIKE '%Ã%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã‘', 'Ñ') WHERE NormalizedName LIKE '%Ã‘%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã’', 'Ò') WHERE NormalizedName LIKE '%Ã’%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã“', 'Ó') WHERE NormalizedName LIKE '%Ã“%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã”', 'Ô') WHERE NormalizedName LIKE '%Ã”%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã–', 'Ö') WHERE NormalizedName LIKE '%Ã–%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã™', 'Ù') WHERE NormalizedName LIKE '%Ã™%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ãš', 'Ú') WHERE NormalizedName LIKE '%Ãš%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ã›', 'Û') WHERE NormalizedName LIKE '%Ã›%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Ãœ', 'Ü') WHERE NormalizedName LIKE '%Ãœ%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Å’', 'Œ') WHERE NormalizedName LIKE '%Å’%';

UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'â€™', '’') WHERE NormalizedName LIKE '%â€™%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'â€œ', '“') WHERE NormalizedName LIKE '%â€œ%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'â€', '”') WHERE NormalizedName LIKE '%â€%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'â€“', '–') WHERE NormalizedName LIKE '%â€“%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'â€”', '—') WHERE NormalizedName LIKE '%â€”%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'â€¦', '…') WHERE NormalizedName LIKE '%â€¦%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'â€¢', '•') WHERE NormalizedName LIKE '%â€¢%';
UPDATE Ingredients SET NormalizedName = REPLACE(NormalizedName, 'Â', '') WHERE NormalizedName LIKE '%Â%';

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
