-- tableCreate.sql

-- Drop existing tables if they exist (commented out for safety; uncomment as needed for a fresh start)
-- DROP TABLE IF EXISTS CocktailRecipes;
-- DROP TABLE IF EXISTS CocktailIngredients;
-- DROP TABLE IF EXISTS Cocktails;
-- DROP TABLE IF EXISTS Ingredients;
-- DROP TABLE IF EXISTS Amounts;
-- DROP TABLE IF EXISTS GlassTypes;
-- DROP TABLE IF EXISTS CocktailTimePeriods;
-- DROP TABLE IF EXISTS MixerSubtypes;
-- DROP TABLE IF EXISTS MixerTypes;
-- DROP TABLE IF EXISTS IngredientTypes;

-- Create IngredientTypes Table
CREATE TABLE IngredientTypes (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Type TEXT NOT NULL UNIQUE
);

-- Create MixerTypes Table
CREATE TABLE MixerTypes (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    Description TEXT
);

-- Create MixerSubtypes Table
CREATE TABLE MixerSubtypes (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    MixerTypeId INTEGER,
    Name TEXT NOT NULL,
    Description TEXT,
    FOREIGN KEY (MixerTypeId) REFERENCES MixerTypes(Id)
);

-- Create CocktailTimePeriods Table
CREATE TABLE CocktailTimePeriods (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    Description TEXT NOT NULL,
    LongDescription TEXT
);

-- Create GlassTypes Table
CREATE TABLE GlassTypes (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL UNIQUE
);

-- Create Amounts Table
CREATE TABLE Amounts (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    MeasurementName TEXT NOT NULL,
    Ounces REAL NOT NULL
);

-- Create Ingredients Table
CREATE TABLE Ingredients (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    IngredientTypeId INTEGER,
    MixerSubtypeId INTEGER,
    LongDescription TEXT,
    FOREIGN KEY (IngredientTypeId) REFERENCES IngredientTypes(Id),
    FOREIGN KEY (MixerSubtypeId) REFERENCES MixerSubtypes(Id)
);

-- Create Cocktails Table
CREATE TABLE Cocktails (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    Description TEXT,
    Method TEXT,
    GlassTypeId INTEGER,
    TimePeriodId INTEGER,
    IsPopular INTEGER DEFAULT 0,
    FOREIGN KEY (GlassTypeId) REFERENCES GlassTypes(Id),
    FOREIGN KEY (TimePeriodId) REFERENCES CocktailTimePeriods(Id)
);

-- Create CocktailIngredients Junction Table
CREATE TABLE CocktailIngredients (
    CocktailId INTEGER,
    IngredientId INTEGER,
    AmountId INTEGER,
    FOREIGN KEY (CocktailId) REFERENCES Cocktails(Id),
    FOREIGN KEY (IngredientId) REFERENCES Ingredients(Id),
    FOREIGN KEY (AmountId) REFERENCES Amounts(Id)
);

-- Create CocktailRecipes Table for Preparation Steps
CREATE TABLE CocktailRecipes (
    CocktailId INTEGER,
    StepNumber INTEGER,
    Instruction TEXT,
    PRIMARY KEY (CocktailId, StepNumber),
    FOREIGN KEY (CocktailId) REFERENCES Cocktails(Id)
);
