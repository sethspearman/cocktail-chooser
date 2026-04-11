CREATE TABLE IF NOT EXISTS SiteMessages (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    MessageText TEXT NOT NULL,
    IsActive INTEGER NOT NULL DEFAULT 0,
    StartUtc TEXT NULL,
    EndUtc TEXT NULL,
    Audience TEXT NULL
);

INSERT INTO SiteMessages (MessageText, IsActive, StartUtc, EndUtc, Audience)
SELECT
    'Tip: Open Advanced Filters and try Almost Unlocked to see cocktails you are only one ingredient away from making.',
    1,
    NULL,
    NULL,
    NULL
WHERE NOT EXISTS (
    SELECT 1
    FROM SiteMessages
    WHERE MessageText = 'Tip: Open Advanced Filters and try Almost Unlocked to see cocktails you are only one ingredient away from making.'
);
