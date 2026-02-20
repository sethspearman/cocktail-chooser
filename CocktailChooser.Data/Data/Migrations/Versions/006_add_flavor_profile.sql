PRAGMA foreign_keys = ON;
BEGIN TRANSACTION;

ALTER TABLE OcrRecipeCandidates ADD COLUMN ParsedFlavorProfile TEXT;
ALTER TABLE Recipes ADD COLUMN FlavorProfile TEXT;

COMMIT;
