ALTER TABLE Cocktails
ADD COLUMN SubmittedByUserId INTEGER;

CREATE INDEX IF NOT EXISTS IX_Cocktails_SubmittedByUserId
ON Cocktails (SubmittedByUserId);
