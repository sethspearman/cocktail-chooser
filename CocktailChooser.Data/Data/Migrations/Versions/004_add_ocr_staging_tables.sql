PRAGMA foreign_keys = ON;
BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS OcrImports (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    RecipeSourceId INTEGER NOT NULL,
    ImportName TEXT NOT NULL,
    ImportType TEXT NOT NULL,
    FileName TEXT,
    Status TEXT NOT NULL DEFAULT 'Pending',
    Notes TEXT,
    CreatedUtc TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    CompletedUtc TEXT,
    FOREIGN KEY (RecipeSourceId) REFERENCES RecipeSources (Id)
);

CREATE INDEX IF NOT EXISTS IX_OcrImports_RecipeSourceId ON OcrImports (RecipeSourceId);
CREATE INDEX IF NOT EXISTS IX_OcrImports_Status ON OcrImports (Status);

CREATE TABLE IF NOT EXISTS OcrImportItems (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    OcrImportId INTEGER NOT NULL,
    ItemKey TEXT,
    RawText TEXT NOT NULL,
    RawOcrJson TEXT,
    Confidence REAL,
    Status TEXT NOT NULL DEFAULT 'Pending',
    CreatedUtc TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    FOREIGN KEY (OcrImportId) REFERENCES OcrImports (Id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS IX_OcrImportItems_OcrImportId ON OcrImportItems (OcrImportId);
CREATE INDEX IF NOT EXISTS IX_OcrImportItems_Status ON OcrImportItems (Status);

CREATE TABLE IF NOT EXISTS OcrRecipeCandidates (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    OcrImportItemId INTEGER NOT NULL,
    CocktailName TEXT NOT NULL,
    SourceRecipeName TEXT,
    MethodText TEXT,
    ParserVersion TEXT,
    Confidence REAL,
    Status TEXT NOT NULL DEFAULT 'Pending',
    ParseWarnings TEXT,
    CreatedUtc TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    FOREIGN KEY (OcrImportItemId) REFERENCES OcrImportItems (Id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS IX_OcrRecipeCandidates_OcrImportItemId ON OcrRecipeCandidates (OcrImportItemId);
CREATE INDEX IF NOT EXISTS IX_OcrRecipeCandidates_Status ON OcrRecipeCandidates (Status);

CREATE TABLE IF NOT EXISTS OcrIngredientCandidates (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    OcrRecipeCandidateId INTEGER NOT NULL,
    SortOrder INTEGER NOT NULL,
    RawLine TEXT NOT NULL,
    RawAmount TEXT,
    RawIngredientName TEXT,
    NormalizedAmountId INTEGER,
    NormalizedIngredientId INTEGER,
    Confidence REAL,
    ParseWarnings TEXT,
    CreatedUtc TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    FOREIGN KEY (OcrRecipeCandidateId) REFERENCES OcrRecipeCandidates (Id) ON DELETE CASCADE,
    FOREIGN KEY (NormalizedAmountId) REFERENCES Amounts (Id),
    FOREIGN KEY (NormalizedIngredientId) REFERENCES Ingredients (Id)
);

CREATE INDEX IF NOT EXISTS IX_OcrIngredientCandidates_OcrRecipeCandidateId ON OcrIngredientCandidates (OcrRecipeCandidateId);

CREATE TABLE IF NOT EXISTS OcrStepCandidates (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    OcrRecipeCandidateId INTEGER NOT NULL,
    StepNumber INTEGER NOT NULL,
    Instruction TEXT NOT NULL,
    Confidence REAL,
    CreatedUtc TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    FOREIGN KEY (OcrRecipeCandidateId) REFERENCES OcrRecipeCandidates (Id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS IX_OcrStepCandidates_OcrRecipeCandidateId ON OcrStepCandidates (OcrRecipeCandidateId);
CREATE UNIQUE INDEX IF NOT EXISTS UX_OcrStepCandidates_Candidate_StepNumber ON OcrStepCandidates (OcrRecipeCandidateId, StepNumber);

COMMIT;
