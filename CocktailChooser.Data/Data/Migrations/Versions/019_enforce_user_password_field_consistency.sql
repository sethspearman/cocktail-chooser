-- Harden Users credential integrity.
-- Allow either:
--   1) all credential fields populated (hash + salt + positive iterations), or
--   2) all credential fields null (legacy/unclaimed rows).
-- Disallow partial states that break login behavior.

UPDATE Users
SET PasswordHash = NULL
WHERE PasswordHash IS NOT NULL
  AND trim(PasswordHash) = '';

UPDATE Users
SET PasswordSalt = NULL
WHERE PasswordSalt IS NOT NULL
  AND trim(PasswordSalt) = '';

UPDATE Users
SET PasswordIterations = NULL
WHERE PasswordIterations IS NOT NULL
  AND PasswordIterations <= 0;

DROP TRIGGER IF EXISTS trg_users_password_fields_validate_insert;
CREATE TRIGGER trg_users_password_fields_validate_insert
BEFORE INSERT ON Users
FOR EACH ROW
BEGIN
    SELECT
        CASE
            WHEN (
                (
                    NEW.PasswordHash IS NULL
                    AND NEW.PasswordSalt IS NULL
                    AND NEW.PasswordIterations IS NULL
                )
                OR
                (
                    NEW.PasswordHash IS NOT NULL
                    AND trim(NEW.PasswordHash) <> ''
                    AND NEW.PasswordSalt IS NOT NULL
                    AND trim(NEW.PasswordSalt) <> ''
                    AND NEW.PasswordIterations IS NOT NULL
                    AND NEW.PasswordIterations > 0
                )
            )
            THEN 1
            ELSE RAISE(ABORT, 'Users password fields must be fully populated or all null.')
        END;
END;

DROP TRIGGER IF EXISTS trg_users_password_fields_validate_update;
CREATE TRIGGER trg_users_password_fields_validate_update
BEFORE UPDATE ON Users
FOR EACH ROW
BEGIN
    SELECT
        CASE
            WHEN (
                (
                    NEW.PasswordHash IS NULL
                    AND NEW.PasswordSalt IS NULL
                    AND NEW.PasswordIterations IS NULL
                )
                OR
                (
                    NEW.PasswordHash IS NOT NULL
                    AND trim(NEW.PasswordHash) <> ''
                    AND NEW.PasswordSalt IS NOT NULL
                    AND trim(NEW.PasswordSalt) <> ''
                    AND NEW.PasswordIterations IS NOT NULL
                    AND NEW.PasswordIterations > 0
                )
            )
            THEN 1
            ELSE RAISE(ABORT, 'Users password fields must be fully populated or all null.')
        END;
END;
