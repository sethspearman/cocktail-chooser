--
-- File generated with SQLiteStudio v3.4.4 on Fri Jul 5 17:06:41 2024
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: Amounts
DROP TABLE IF EXISTS Amounts;

CREATE TABLE IF NOT EXISTS Amounts (
    Id              INTEGER PRIMARY KEY AUTOINCREMENT,
    MeasurementName TEXT    NOT NULL,
    Ounces          REAL    NOT NULL
);


-- Table: CocktailIngredients
DROP TABLE IF EXISTS CocktailIngredients;

CREATE TABLE IF NOT EXISTS CocktailIngredients (
    CocktailId   INTEGER,
    IngredientId INTEGER,
    AmountId     INTEGER,
    FOREIGN KEY (
        CocktailId
    )
    REFERENCES Cocktails (Id),
    FOREIGN KEY (
        IngredientId
    )
    REFERENCES Ingredients (Id),
    FOREIGN KEY (
        AmountId
    )
    REFERENCES Amounts (Id) 
);


-- Table: CocktailRecipes
DROP TABLE IF EXISTS CocktailRecipes;

CREATE TABLE IF NOT EXISTS CocktailRecipes (
    CocktailId  INTEGER,
    StepNumber  INTEGER,
    Instruction TEXT,
    PRIMARY KEY (
        CocktailId,
        StepNumber
    ),
    FOREIGN KEY (
        CocktailId
    )
    REFERENCES Cocktails (Id) 
);


-- Table: Cocktails
DROP TABLE IF EXISTS Cocktails;

CREATE TABLE IF NOT EXISTS Cocktails (
    Id               INTEGER PRIMARY KEY AUTOINCREMENT,
    Name             TEXT    NOT NULL,
    Description      TEXT,
    Method           TEXT,
    GlassTypeId      INTEGER,
    TimePeriodId     INTEGER,
    IsPopular        INTEGER DEFAULT 0,
    CocktailSourceID INTEGER,
    FOREIGN KEY (
        GlassTypeId
    )
    REFERENCES GlassTypes (Id),
    FOREIGN KEY (
        TimePeriodId
    )
    REFERENCES CocktailTimePeriods (Id),
    FOREIGN KEY (
        CocktailSourceID
    )
    REFERENCES CocktailSource (Id) 
);


-- Table: CocktailSource
DROP TABLE IF EXISTS CocktailSource;

CREATE TABLE IF NOT EXISTS CocktailSource (
    Id         INTEGER PRIMARY KEY AUTOINCREMENT,
    Name       TEXT    NOT NULL,
    SourceType TEXT    NOT NULL,
    Url        TEXT
);


-- Table: CocktailTimePeriods
DROP TABLE IF EXISTS CocktailTimePeriods;

CREATE TABLE IF NOT EXISTS CocktailTimePeriods (
    Id              INTEGER PRIMARY KEY AUTOINCREMENT,
    Name            TEXT    NOT NULL,
    Description     TEXT    NOT NULL,
    LongDescription TEXT
);


-- Table: GlassTypes
DROP TABLE IF EXISTS GlassTypes;

CREATE TABLE IF NOT EXISTS GlassTypes (
    Id   INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT    NOT NULL
                 UNIQUE
);


-- Table: Ingredients
DROP TABLE IF EXISTS Ingredients;

CREATE TABLE IF NOT EXISTS Ingredients (
    Id               INTEGER PRIMARY KEY AUTOINCREMENT,
    Name             TEXT    NOT NULL,
    IngredientTypeId INTEGER,
    MixerSubtypeId   INTEGER,
    LongDescription  TEXT,
    FOREIGN KEY (
        IngredientTypeId
    )
    REFERENCES IngredientTypes (Id),
    FOREIGN KEY (
        MixerSubtypeId
    )
    REFERENCES MixerSubtypes (Id) 
);


-- Table: IngredientTypes
DROP TABLE IF EXISTS IngredientTypes;

CREATE TABLE IF NOT EXISTS IngredientTypes (
    Id   INTEGER PRIMARY KEY AUTOINCREMENT,
    Type TEXT    NOT NULL
                 UNIQUE
);


-- Table: MixerSubtypes
DROP TABLE IF EXISTS MixerSubtypes;

CREATE TABLE IF NOT EXISTS MixerSubtypes (
    Id          INTEGER PRIMARY KEY AUTOINCREMENT,
    MixerTypeId INTEGER,
    Name        TEXT    NOT NULL,
    Description TEXT,
    FOREIGN KEY (
        MixerTypeId
    )
    REFERENCES MixerTypes (Id) 
);


-- Table: MixerTypes
DROP TABLE IF EXISTS MixerTypes;

CREATE TABLE IF NOT EXISTS MixerTypes (
    Id          INTEGER PRIMARY KEY AUTOINCREMENT,
    Name        TEXT    NOT NULL,
    Description TEXT
);


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
