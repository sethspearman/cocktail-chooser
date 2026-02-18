PRAGMA foreign_keys = ON;
BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS RecipeSources (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    SourceType TEXT NOT NULL,
    CopyrightCredit TEXT,
    Url TEXT,
    Notes TEXT,
    IsBuiltIn INTEGER NOT NULL DEFAULT 0,
    CreatedUtc TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now'))
);

CREATE UNIQUE INDEX IF NOT EXISTS UX_RecipeSources_Name_SourceType
    ON RecipeSources (Name, SourceType);

CREATE TABLE IF NOT EXISTS Recipes (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    CocktailId INTEGER NOT NULL,
    RecipeSourceId INTEGER NOT NULL,
    SourceRecipeName TEXT,
    AttributionText TEXT,
    SourceUrl TEXT,
    Method TEXT,
    Notes TEXT,
    IsUserSubmitted INTEGER NOT NULL DEFAULT 0,
    CreatedUtc TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    UpdatedUtc TEXT,
    FOREIGN KEY (CocktailId) REFERENCES Cocktails (Id),
    FOREIGN KEY (RecipeSourceId) REFERENCES RecipeSources (Id)
);

CREATE INDEX IF NOT EXISTS IX_Recipes_CocktailId ON Recipes (CocktailId);
CREATE INDEX IF NOT EXISTS IX_Recipes_RecipeSourceId ON Recipes (RecipeSourceId);
CREATE UNIQUE INDEX IF NOT EXISTS UX_Recipes_Cocktail_Source_Name
    ON Recipes (CocktailId, RecipeSourceId, ifnull(SourceRecipeName, ''));

CREATE TABLE IF NOT EXISTS RecipeIngredients (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    RecipeId INTEGER NOT NULL,
    IngredientId INTEGER NOT NULL,
    AmountId INTEGER,
    SortOrder INTEGER,
    FOREIGN KEY (RecipeId) REFERENCES Recipes (Id) ON DELETE CASCADE,
    FOREIGN KEY (IngredientId) REFERENCES Ingredients (Id),
    FOREIGN KEY (AmountId) REFERENCES Amounts (Id)
);

CREATE INDEX IF NOT EXISTS IX_RecipeIngredients_RecipeId ON RecipeIngredients (RecipeId);
CREATE INDEX IF NOT EXISTS IX_RecipeIngredients_IngredientId ON RecipeIngredients (IngredientId);
CREATE INDEX IF NOT EXISTS IX_RecipeIngredients_AmountId ON RecipeIngredients (AmountId);
CREATE UNIQUE INDEX IF NOT EXISTS UX_RecipeIngredients_Recipe_Ingredient_Amount
    ON RecipeIngredients (RecipeId, IngredientId, ifnull(AmountId, -1));

CREATE TABLE IF NOT EXISTS RecipeSteps (
    RecipeId INTEGER NOT NULL,
    StepNumber INTEGER NOT NULL,
    Instruction TEXT NOT NULL,
    PRIMARY KEY (RecipeId, StepNumber),
    FOREIGN KEY (RecipeId) REFERENCES Recipes (Id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS IX_RecipeSteps_RecipeId ON RecipeSteps (RecipeId);

INSERT OR IGNORE INTO RecipeSources (Id, Name, SourceType, Url, IsBuiltIn)
SELECT Id, Name, SourceType, Url, 0
FROM CocktailSource;

INSERT INTO RecipeSources (Name, SourceType, CopyrightCredit, IsBuiltIn)
SELECT 'User Added', 'BuiltIn', 'User-contributed recipes', 1
WHERE NOT EXISTS (
    SELECT 1
    FROM RecipeSources
    WHERE Name = 'User Added'
      AND SourceType = 'BuiltIn'
);

INSERT INTO Recipes
(
    CocktailId,
    RecipeSourceId,
    SourceRecipeName,
    AttributionText,
    SourceUrl,
    Method,
    IsUserSubmitted
)
SELECT
    c.Id,
    COALESCE(rs.Id, ua.Id),
    c.Name,
    CASE
        WHEN cs.Name IS NOT NULL THEN cs.Name || ' (' || cs.SourceType || ')'
        ELSE 'User Added'
    END,
    cs.Url,
    c.Method,
    CASE WHEN c.CocktailSourceID IS NULL THEN 1 ELSE 0 END
FROM Cocktails c
LEFT JOIN CocktailSource cs
    ON cs.Id = c.CocktailSourceID
LEFT JOIN RecipeSources rs
    ON rs.Id = c.CocktailSourceID
CROSS JOIN (
    SELECT Id
    FROM RecipeSources
    WHERE Name = 'User Added'
      AND SourceType = 'BuiltIn'
    LIMIT 1
) ua
WHERE NOT EXISTS (
    SELECT 1
    FROM Recipes r
    WHERE r.CocktailId = c.Id
      AND r.RecipeSourceId = COALESCE(rs.Id, ua.Id)
      AND ifnull(r.SourceRecipeName, '') = ifnull(c.Name, '')
);

INSERT INTO RecipeIngredients
(
    RecipeId,
    IngredientId,
    AmountId,
    SortOrder
)
SELECT
    r.Id,
    ci.IngredientId,
    ci.AmountId,
    ROW_NUMBER() OVER (PARTITION BY ci.CocktailId ORDER BY ci.rowid)
FROM CocktailIngredients ci
JOIN Cocktails c
    ON c.Id = ci.CocktailId
LEFT JOIN RecipeSources rs
    ON rs.Id = c.CocktailSourceID
CROSS JOIN (
    SELECT Id
    FROM RecipeSources
    WHERE Name = 'User Added'
      AND SourceType = 'BuiltIn'
    LIMIT 1
) ua
JOIN Recipes r
    ON r.CocktailId = ci.CocktailId
   AND r.RecipeSourceId = COALESCE(rs.Id, ua.Id)
   AND ifnull(r.SourceRecipeName, '') = ifnull(c.Name, '')
WHERE NOT EXISTS (
    SELECT 1
    FROM RecipeIngredients ri
    WHERE ri.RecipeId = r.Id
      AND ri.IngredientId = ci.IngredientId
      AND ifnull(ri.AmountId, -1) = ifnull(ci.AmountId, -1)
);

INSERT INTO RecipeSteps
(
    RecipeId,
    StepNumber,
    Instruction
)
SELECT
    r.Id,
    cr.StepNumber,
    cr.Instruction
FROM CocktailRecipes cr
JOIN Cocktails c
    ON c.Id = cr.CocktailId
LEFT JOIN RecipeSources rs
    ON rs.Id = c.CocktailSourceID
CROSS JOIN (
    SELECT Id
    FROM RecipeSources
    WHERE Name = 'User Added'
      AND SourceType = 'BuiltIn'
    LIMIT 1
) ua
JOIN Recipes r
    ON r.CocktailId = cr.CocktailId
   AND r.RecipeSourceId = COALESCE(rs.Id, ua.Id)
   AND ifnull(r.SourceRecipeName, '') = ifnull(c.Name, '')
WHERE NOT EXISTS (
    SELECT 1
    FROM RecipeSteps rs2
    WHERE rs2.RecipeId = r.Id
      AND rs2.StepNumber = cr.StepNumber
);

COMMIT;
