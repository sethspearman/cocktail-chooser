PRAGMA foreign_keys = ON;
BEGIN TRANSACTION;

ALTER TABLE OcrRecipeCandidates ADD COLUMN ParsedTimePeriod TEXT;

COMMIT;
