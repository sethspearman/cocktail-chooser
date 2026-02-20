PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- Glass type media support
ALTER TABLE GlassTypes ADD COLUMN ImageUrl TEXT;

-- Consolidate RecipeSources into CocktailSource (union of columns)
DROP TABLE IF EXISTS CocktailSource_new;
CREATE TABLE CocktailSource_new (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    SourceType TEXT NOT NULL,
    Publisher TEXT,
    PublishDate TEXT,
    Author TEXT,
    Isbn10 TEXT,
    Isbn13 TEXT,
    PurchaseUrl TEXT,
    Edition TEXT,
    Language TEXT,
    CopyrightCredit TEXT,
    Url TEXT,
    Notes TEXT,
    IsBuiltIn INTEGER NOT NULL DEFAULT 0,
    CreatedUtc TEXT
);

INSERT INTO CocktailSource_new
(
    Id,
    Name,
    SourceType,
    Publisher,
    PublishDate,
    Author,
    Isbn10,
    Isbn13,
    PurchaseUrl,
    Edition,
    Language,
    CopyrightCredit,
    Url,
    Notes,
    IsBuiltIn,
    CreatedUtc
)
SELECT
    cs.Id,
    cs.Name,
    cs.SourceType,
    rs.Publisher,
    rs.PublishDate,
    rs.Author,
    rs.Isbn10,
    rs.Isbn13,
    rs.PurchaseUrl,
    rs.Edition,
    rs.Language,
    rs.CopyrightCredit,
    COALESCE(rs.Url, cs.Url),
    rs.Notes,
    COALESCE(rs.IsBuiltIn, 0),
    rs.CreatedUtc
FROM CocktailSource cs
LEFT JOIN RecipeSources rs
    ON rs.Id = cs.Id;

INSERT INTO CocktailSource_new
(
    Id,
    Name,
    SourceType,
    Publisher,
    PublishDate,
    Author,
    Isbn10,
    Isbn13,
    PurchaseUrl,
    Edition,
    Language,
    CopyrightCredit,
    Url,
    Notes,
    IsBuiltIn,
    CreatedUtc
)
SELECT
    rs.Id,
    rs.Name,
    rs.SourceType,
    rs.Publisher,
    rs.PublishDate,
    rs.Author,
    rs.Isbn10,
    rs.Isbn13,
    rs.PurchaseUrl,
    rs.Edition,
    rs.Language,
    rs.CopyrightCredit,
    rs.Url,
    rs.Notes,
    rs.IsBuiltIn,
    rs.CreatedUtc
FROM RecipeSources rs
WHERE NOT EXISTS (
    SELECT 1
    FROM CocktailSource_new csn
    WHERE csn.Id = rs.Id
);

DROP TABLE CocktailSource;
ALTER TABLE CocktailSource_new RENAME TO CocktailSource;

CREATE UNIQUE INDEX IF NOT EXISTS UX_CocktailSource_Name_SourceType
    ON CocktailSource (Name, SourceType);

-- Consolidate Recipes into Cocktails (union of columns)
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
    UpdatedUtc
)
SELECT
    c.Id,
    c.Name,
    c.Description,
    COALESCE(r.Method, c.Method),
    r.FlavorProfile,
    c.GlassTypeId,
    c.TimePeriodId,
    COALESCE(c.IsPopular, 0),
    COALESCE(r.RecipeSourceId, c.CocktailSourceID),
    r.SourceRecipeName,
    r.AttributionText,
    r.SourceUrl,
    r.Notes,
    COALESCE(r.IsUserSubmitted, CASE WHEN c.CocktailSourceID IS NULL THEN 1 ELSE 0 END),
    r.CreatedUtc,
    r.UpdatedUtc
FROM Cocktails c
LEFT JOIN (
    SELECT r1.*
    FROM Recipes r1
    INNER JOIN (
        SELECT CocktailId, MIN(Id) AS MinRecipeId
        FROM Recipes
        GROUP BY CocktailId
    ) rmin
        ON r1.Id = rmin.MinRecipeId
) r
    ON r.CocktailId = c.Id;

DROP TABLE Cocktails;
ALTER TABLE Cocktails_new RENAME TO Cocktails;

CREATE INDEX IF NOT EXISTS IX_Cocktails_CocktailSourceId ON Cocktails (CocktailSourceId);

-- Move OcrImports to CocktailSourceId
DROP TABLE IF EXISTS OcrImports_new;
CREATE TABLE OcrImports_new (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    CocktailSourceId INTEGER NOT NULL,
    ImportName TEXT NOT NULL,
    ImportType TEXT NOT NULL,
    FileName TEXT,
    Status TEXT NOT NULL DEFAULT 'Pending',
    Notes TEXT,
    CreatedUtc TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    CompletedUtc TEXT,
    FOREIGN KEY (CocktailSourceId) REFERENCES CocktailSource (Id)
);

INSERT INTO OcrImports_new
(
    Id,
    CocktailSourceId,
    ImportName,
    ImportType,
    FileName,
    Status,
    Notes,
    CreatedUtc,
    CompletedUtc
)
SELECT
    Id,
    RecipeSourceId,
    ImportName,
    ImportType,
    FileName,
    Status,
    Notes,
    CreatedUtc,
    CompletedUtc
FROM OcrImports;

DROP TABLE OcrImports;
ALTER TABLE OcrImports_new RENAME TO OcrImports;

CREATE INDEX IF NOT EXISTS IX_OcrImports_CocktailSourceId ON OcrImports (CocktailSourceId);
CREATE INDEX IF NOT EXISTS IX_OcrImports_Status ON OcrImports (Status);

-- Consolidate RecipeIngredients into CocktailIngredients
DROP TABLE IF EXISTS CocktailIngredients_new;
CREATE TABLE CocktailIngredients_new (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    CocktailId INTEGER NOT NULL,
    IngredientId INTEGER NOT NULL,
    AmountId INTEGER,
    SortOrder INTEGER,
    FOREIGN KEY (CocktailId) REFERENCES Cocktails (Id),
    FOREIGN KEY (IngredientId) REFERENCES Ingredients (Id),
    FOREIGN KEY (AmountId) REFERENCES Amounts (Id)
);

INSERT INTO CocktailIngredients_new (CocktailId, IngredientId, AmountId, SortOrder)
SELECT DISTINCT
    CocktailId,
    IngredientId,
    AmountId,
    NULL
FROM CocktailIngredients
WHERE CocktailId IS NOT NULL
  AND IngredientId IS NOT NULL;

INSERT INTO CocktailIngredients_new (CocktailId, IngredientId, AmountId, SortOrder)
SELECT
    r.CocktailId,
    ri.IngredientId,
    ri.AmountId,
    ri.SortOrder
FROM RecipeIngredients ri
INNER JOIN Recipes r
    ON r.Id = ri.RecipeId
WHERE NOT EXISTS (
    SELECT 1
    FROM CocktailIngredients_new cin
    WHERE cin.CocktailId = r.CocktailId
      AND cin.IngredientId = ri.IngredientId
      AND ifnull(cin.AmountId, -1) = ifnull(ri.AmountId, -1)
      AND ifnull(cin.SortOrder, -1) = ifnull(ri.SortOrder, -1)
);

DROP TABLE CocktailIngredients;
ALTER TABLE CocktailIngredients_new RENAME TO CocktailIngredients;

CREATE INDEX IF NOT EXISTS IX_CocktailIngredients_CocktailId ON CocktailIngredients (CocktailId);
CREATE INDEX IF NOT EXISTS IX_CocktailIngredients_IngredientId ON CocktailIngredients (IngredientId);
CREATE INDEX IF NOT EXISTS IX_CocktailIngredients_AmountId ON CocktailIngredients (AmountId);
CREATE UNIQUE INDEX IF NOT EXISTS UX_CocktailIngredients_Cocktail_Ingredient_Amount_Sort
    ON CocktailIngredients (CocktailId, IngredientId, ifnull(AmountId, -1), ifnull(SortOrder, -1));

-- Replace CocktailRecipes/RecipeSteps with CocktailSteps
DROP TABLE IF EXISTS CocktailSteps_new;
CREATE TABLE CocktailSteps_new (
    CocktailId INTEGER NOT NULL,
    StepNumber INTEGER NOT NULL,
    Instruction TEXT NOT NULL,
    PRIMARY KEY (CocktailId, StepNumber),
    FOREIGN KEY (CocktailId) REFERENCES Cocktails (Id) ON DELETE CASCADE
);

INSERT INTO CocktailSteps_new (CocktailId, StepNumber, Instruction)
SELECT
    CocktailId,
    StepNumber,
    COALESCE(Instruction, '')
FROM CocktailRecipes
WHERE CocktailId IS NOT NULL
  AND StepNumber IS NOT NULL;

INSERT INTO CocktailSteps_new (CocktailId, StepNumber, Instruction)
SELECT
    r.CocktailId,
    rs.StepNumber,
    rs.Instruction
FROM RecipeSteps rs
INNER JOIN Recipes r
    ON r.Id = rs.RecipeId
WHERE NOT EXISTS (
    SELECT 1
    FROM CocktailSteps_new cs
    WHERE cs.CocktailId = r.CocktailId
      AND cs.StepNumber = rs.StepNumber
);

DROP TABLE IF EXISTS CocktailRecipes;
ALTER TABLE CocktailSteps_new RENAME TO CocktailSteps;

CREATE INDEX IF NOT EXISTS IX_CocktailSteps_CocktailId ON CocktailSteps (CocktailId);

-- Remove redundant Recipe* tables
DROP TABLE IF EXISTS RecipeIngredients;
DROP TABLE IF EXISTS RecipeSteps;
DROP TABLE IF EXISTS Recipes;
DROP TABLE IF EXISTS RecipeSources;

COMMIT;
PRAGMA foreign_keys = ON;
