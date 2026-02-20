##### This project will eventually become a mobile app that will allow people to track cocktail recipes, rate them, find them using the users available ingredients.

Current schema direction:
- `Cocktail*` tables are canonical.
- `Recipe*` tables are consolidated and removed via migrations.
- `CocktailSteps` is the canonical instruction-step table.
