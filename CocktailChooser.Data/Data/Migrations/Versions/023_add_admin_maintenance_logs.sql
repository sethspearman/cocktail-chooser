PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS AdminMaintenanceLogs (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    EntityType TEXT NOT NULL,
    OperationType TEXT NOT NULL,
    KeepEntityId INTEGER,
    RemovedEntityId INTEGER,
    DetailsJson TEXT,
    PerformedByUserId INTEGER NOT NULL,
    PerformedUtc TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now'))
);

CREATE INDEX IF NOT EXISTS IX_AdminMaintenanceLogs_EntityType_OperationType
ON AdminMaintenanceLogs (EntityType, OperationType);

CREATE INDEX IF NOT EXISTS IX_AdminMaintenanceLogs_PerformedUtc
ON AdminMaintenanceLogs (PerformedUtc);

COMMIT;
PRAGMA foreign_keys = ON;
