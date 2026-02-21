PRAGMA foreign_keys = ON;
BEGIN TRANSACTION;

ALTER TABLE Ingredients ADD COLUMN PrimarySpirit TEXT;

CREATE INDEX IF NOT EXISTS IX_Ingredients_PrimarySpirit
ON Ingredients (PrimarySpirit);

-- Backfill obvious base spirits for grouping/filtering.
UPDATE Ingredients
SET PrimarySpirit = 'Gin'
WHERE PrimarySpirit IS NULL
  AND lower(Name) LIKE '%gin%'
  AND lower(Name) NOT LIKE '%ginger%';

UPDATE Ingredients
SET PrimarySpirit = 'Vodka'
WHERE PrimarySpirit IS NULL
  AND lower(Name) LIKE '%vodka%';

UPDATE Ingredients
SET PrimarySpirit = 'Rum'
WHERE PrimarySpirit IS NULL
  AND lower(Name) LIKE '%rum%';

UPDATE Ingredients
SET PrimarySpirit = 'Tequila'
WHERE PrimarySpirit IS NULL
  AND lower(Name) LIKE '%tequila%';

UPDATE Ingredients
SET PrimarySpirit = 'Mezcal'
WHERE PrimarySpirit IS NULL
  AND lower(Name) LIKE '%mezcal%';

UPDATE Ingredients
SET PrimarySpirit = 'Whiskey'
WHERE PrimarySpirit IS NULL
  AND (
      lower(Name) LIKE '%whisk%'
      OR lower(Name) LIKE '%bourbon%'
      OR lower(Name) LIKE '%scotch%'
      OR lower(Name) LIKE '%rye%'
  );

UPDATE Ingredients
SET PrimarySpirit = 'Brandy'
WHERE PrimarySpirit IS NULL
  AND (
      lower(Name) LIKE '%brandy%'
      OR lower(Name) LIKE '%cognac%'
      OR lower(Name) LIKE '%calvados%'
  );

CREATE TABLE IF NOT EXISTS Users (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    DisplayName TEXT NOT NULL,
    Email TEXT,
    CreatedUtc TEXT NOT NULL,
    UpdatedUtc TEXT NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS UX_Users_Email
ON Users (Email)
WHERE Email IS NOT NULL;

CREATE TABLE IF NOT EXISTS UserIngredients (
    UserId INTEGER NOT NULL,
    IngredientId INTEGER NOT NULL,
    IsInStock INTEGER NOT NULL DEFAULT 1,
    Notes TEXT,
    UpdatedUtc TEXT NOT NULL,
    PRIMARY KEY (UserId, IngredientId),
    FOREIGN KEY (UserId) REFERENCES Users (Id) ON DELETE CASCADE,
    FOREIGN KEY (IngredientId) REFERENCES Ingredients (Id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS IX_UserIngredients_IngredientId
ON UserIngredients (IngredientId);

CREATE TABLE IF NOT EXISTS CocktailTryLogs (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    UserId INTEGER NOT NULL,
    CocktailId INTEGER NOT NULL,
    Rating INTEGER,
    Comment TEXT,
    TriedOnUtc TEXT NOT NULL,
    CreatedUtc TEXT NOT NULL,
    UpdatedUtc TEXT NOT NULL,
    FOREIGN KEY (UserId) REFERENCES Users (Id) ON DELETE CASCADE,
    FOREIGN KEY (CocktailId) REFERENCES Cocktails (Id) ON DELETE CASCADE,
    CHECK (Rating IS NULL OR (Rating >= 1 AND Rating <= 5))
);

CREATE INDEX IF NOT EXISTS IX_CocktailTryLogs_UserId
ON CocktailTryLogs (UserId);

CREATE INDEX IF NOT EXISTS IX_CocktailTryLogs_CocktailId
ON CocktailTryLogs (CocktailId);

CREATE TABLE IF NOT EXISTS CocktailGroupingLinks (
    CocktailId INTEGER NOT NULL,
    CocktailSourceId INTEGER NOT NULL,
    GroupingName TEXT NOT NULL,
    PRIMARY KEY (CocktailId, CocktailSourceId, GroupingName),
    FOREIGN KEY (CocktailId) REFERENCES Cocktails (Id) ON DELETE CASCADE,
    FOREIGN KEY (CocktailSourceId) REFERENCES CocktailSource (Id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS IX_CocktailGroupingLinks_GroupingName
ON CocktailGroupingLinks (GroupingName);

COMMIT;
