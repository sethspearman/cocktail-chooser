PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

DROP INDEX IF EXISTS UX_Cocktails_CanonicalKey;

UPDATE Cocktails
SET CanonicalKey = 'manual::unknown'
WHERE CanonicalKey IS NULL OR trim(CanonicalKey) = '';

WITH ranked AS (
    SELECT
        Id,
        CanonicalKey,
        ROW_NUMBER() OVER (PARTITION BY CanonicalKey ORDER BY Id) AS dup_rank
    FROM Cocktails
)
UPDATE Cocktails
SET CanonicalKey = CanonicalKey || '__v' || (
    SELECT dup_rank
    FROM ranked
    WHERE ranked.Id = Cocktails.Id
)
WHERE Id IN (
    SELECT Id
    FROM ranked
    WHERE dup_rank > 1
);

DROP TABLE IF EXISTS Cocktails_new;
CREATE TABLE Cocktails_new (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    Description TEXT,
    Method TEXT,
    FlavorProfile TEXT,
    GlassTypeId INTEGER,
    TimePeriodId INTEGER,
    IsPopular INTEGER NOT NULL DEFAULT 0,
    CocktailSourceId INTEGER,
    SourceRecipeName TEXT,
    AttributionText TEXT,
    SourceUrl TEXT,
    Notes TEXT,
    IsUserSubmitted INTEGER NOT NULL DEFAULT 0,
    CreatedUtc TEXT,
    UpdatedUtc TEXT,
    IsApproved INTEGER NOT NULL DEFAULT 0,
    SubmittedByUserId INTEGER,
    CanonicalKey TEXT NOT NULL UNIQUE,
    RecipeFingerprint TEXT,
    FOREIGN KEY (GlassTypeId) REFERENCES GlassTypes (Id),
    FOREIGN KEY (TimePeriodId) REFERENCES CocktailTimePeriods (Id),
    FOREIGN KEY (CocktailSourceId) REFERENCES CocktailSource (Id)
);

INSERT INTO Cocktails_new
(
    Id,
    Name,
    Description,
    Method,
    FlavorProfile,
    GlassTypeId,
    TimePeriodId,
    IsPopular,
    CocktailSourceId,
    SourceRecipeName,
    AttributionText,
    SourceUrl,
    Notes,
    IsUserSubmitted,
    CreatedUtc,
    UpdatedUtc,
    IsApproved,
    SubmittedByUserId,
    CanonicalKey,
    RecipeFingerprint
)
SELECT
    Id,
    Name,
    Description,
    Method,
    FlavorProfile,
    GlassTypeId,
    TimePeriodId,
    IsPopular,
    CocktailSourceId,
    SourceRecipeName,
    AttributionText,
    SourceUrl,
    Notes,
    IsUserSubmitted,
    CreatedUtc,
    UpdatedUtc,
    IsApproved,
    SubmittedByUserId,
    CanonicalKey,
    NULL AS RecipeFingerprint
FROM Cocktails;

DROP TABLE Cocktails;
ALTER TABLE Cocktails_new RENAME TO Cocktails;

CREATE INDEX IF NOT EXISTS IX_Cocktails_CocktailSourceId
ON Cocktails (CocktailSourceId);

CREATE INDEX IF NOT EXISTS IX_Cocktails_SubmittedByUserId
ON Cocktails (SubmittedByUserId);

CREATE UNIQUE INDEX IF NOT EXISTS UX_Cocktails_CanonicalKey
ON Cocktails (CanonicalKey);

COMMIT TRANSACTION;
PRAGMA foreign_keys = ON;
