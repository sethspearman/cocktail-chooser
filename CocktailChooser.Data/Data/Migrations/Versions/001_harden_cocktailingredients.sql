PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS CocktailIngredients (
    CocktailId INTEGER,
    IngredientId INTEGER,
    AmountId INTEGER
);

DROP TABLE IF EXISTS CocktailIngredients_new;

CREATE TABLE CocktailIngredients_new (
    CocktailId INTEGER NOT NULL,
    IngredientId INTEGER NOT NULL,
    AmountId INTEGER,
    FOREIGN KEY (CocktailId) REFERENCES Cocktails (Id),
    FOREIGN KEY (IngredientId) REFERENCES Ingredients (Id),
    FOREIGN KEY (AmountId) REFERENCES Amounts (Id)
);

INSERT INTO CocktailIngredients_new (CocktailId, IngredientId, AmountId)
SELECT DISTINCT CocktailId, IngredientId, AmountId
FROM CocktailIngredients
WHERE CocktailId IS NOT NULL
  AND IngredientId IS NOT NULL;

DROP TABLE IF EXISTS CocktailIngredients;
ALTER TABLE CocktailIngredients_new RENAME TO CocktailIngredients;

CREATE INDEX IF NOT EXISTS IX_CocktailIngredients_CocktailId ON CocktailIngredients (CocktailId);
CREATE INDEX IF NOT EXISTS IX_CocktailIngredients_IngredientId ON CocktailIngredients (IngredientId);
CREATE INDEX IF NOT EXISTS IX_CocktailIngredients_AmountId ON CocktailIngredients (AmountId);
CREATE UNIQUE INDEX IF NOT EXISTS UX_CocktailIngredients_Triplet
    ON CocktailIngredients (CocktailId, IngredientId, ifnull(AmountId, -1));

COMMIT;
PRAGMA foreign_keys = ON;
