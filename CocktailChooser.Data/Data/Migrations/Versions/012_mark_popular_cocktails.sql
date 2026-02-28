UPDATE Cocktails
SET IsPopular = 1
WHERE LOWER(TRIM(Name)) IN (
    'aviation',
    'gimlet',
    'gin and tonic',
    'martini',
    'negroni',
    'tom collins',
    'boulevardier',
    'manhattan',
    'sazerac',
    'whiskey sour',
    'vieux carre',
    'hot toddy',
    'mint julep',
    'old fashioned',
    'blood and sand',
    'penicillin',
    'daiquiri',
    'dark and stormy',
    'mojito',
    'bloody mary',
    'cosmopolitan',
    'moscow mule',
    'vodka martini',
    'margarita',
    'paloma',
    'aperol spritz',
    'champagne cocktail',
    'french 75',
    'mimosa'
)
OR LOWER(TRIM(Name)) LIKE 'vieux carr%'
OR LOWER(TRIM(Name)) IN ('dark ''n stormy', 'dark n stormy', 'whisky sour');
