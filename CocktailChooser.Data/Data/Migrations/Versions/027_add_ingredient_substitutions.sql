PRAGMA foreign_keys = ON;
BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS IngredientSubstitutions (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    IngredientId INTEGER NOT NULL,
    SubstituteIngredientId INTEGER NOT NULL,
    ConfidenceScore REAL,
    Notes TEXT,
    CreatedUtc TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    FOREIGN KEY (IngredientId) REFERENCES Ingredients (Id) ON DELETE CASCADE,
    FOREIGN KEY (SubstituteIngredientId) REFERENCES Ingredients (Id) ON DELETE CASCADE,
    CONSTRAINT CK_IngredientSubstitutions_DifferentIngredients CHECK (IngredientId <> SubstituteIngredientId),
    CONSTRAINT UX_IngredientSubstitutions_Pair UNIQUE (IngredientId, SubstituteIngredientId)
);

CREATE INDEX IF NOT EXISTS IX_IngredientSubstitutions_IngredientId
ON IngredientSubstitutions (IngredientId);

CREATE INDEX IF NOT EXISTS IX_IngredientSubstitutions_SubstituteIngredientId
ON IngredientSubstitutions (SubstituteIngredientId);

INSERT OR IGNORE INTO IngredientSubstitutions (IngredientId, SubstituteIngredientId, ConfidenceScore, Notes)
SELECT source.Id, substitute.Id, 0.85, 'Classic lower-bitterness substitute.'
FROM Ingredients source
INNER JOIN Ingredients substitute ON substitute.Name = 'Aperol'
WHERE source.Name = 'Campari';

INSERT OR IGNORE INTO IngredientSubstitutions (IngredientId, SubstituteIngredientId, ConfidenceScore, Notes)
SELECT source.Id, substitute.Id, 0.9, 'Common orange liqueur substitution.'
FROM Ingredients source
INNER JOIN Ingredients substitute ON substitute.Name = 'Triple Sec'
WHERE source.Name = 'Cointreau';

INSERT OR IGNORE INTO IngredientSubstitutions (IngredientId, SubstituteIngredientId, ConfidenceScore, Notes)
SELECT source.Id, substitute.Id, 0.5, 'Works in some drinks but changes acidity and flavor.'
FROM Ingredients source
INNER JOIN Ingredients substitute ON substitute.Name = 'Lime Juice'
WHERE source.Name = 'Lemon Juice';

COMMIT;
