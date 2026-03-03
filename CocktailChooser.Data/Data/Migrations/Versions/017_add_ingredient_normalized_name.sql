-- ISSUE #62 (Phase A): normalize ingredient identity to prevent duplicate creation.

ALTER TABLE Ingredients ADD COLUMN NormalizedName TEXT;

-- Backfill normalized names for existing rows:
-- - trim
-- - collapse whitespace
-- - lowercase
UPDATE Ingredients
SET NormalizedName = NULLIF(
    lower(
        trim(
            replace(
                replace(
                    replace(
                        replace(
                            replace(
                                replace(
                                    replace(
                                        replace(
                                            replace(Name, char(9), ' '),
                                            char(10), ' '
                                        ),
                                        char(13), ' '
                                    ),
                                    '  ', ' '
                                ),
                                '  ', ' '
                            ),
                            '  ', ' '
                        ),
                        '  ', ' '
                    ),
                    '  ', ' '
                ),
                '  ', ' '
            )
        )
    ),
    ''
);

CREATE INDEX IF NOT EXISTS IX_Ingredients_NormalizedName
ON Ingredients (NormalizedName);

-- A unique index on NormalizedName is not feasible yet because legacy duplicate rows exist.
-- Enforce uniqueness for new writes while keeping legacy data readable until a dedicated merge pass.
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
