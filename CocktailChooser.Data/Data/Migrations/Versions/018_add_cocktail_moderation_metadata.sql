-- ISSUE #64 (MVP): submission moderation lifecycle metadata.

ALTER TABLE Cocktails ADD COLUMN ApprovedUtc TEXT;
ALTER TABLE Cocktails ADD COLUMN ApprovedByUserId INTEGER;
ALTER TABLE Cocktails ADD COLUMN RejectedUtc TEXT;

CREATE INDEX IF NOT EXISTS IX_Cocktails_IsApproved_RejectedUtc
ON Cocktails (IsApproved, RejectedUtc);

CREATE INDEX IF NOT EXISTS IX_Cocktails_ApprovedByUserId
ON Cocktails (ApprovedByUserId);
