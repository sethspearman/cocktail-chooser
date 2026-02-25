# CocktailChooser Project Overview

CocktailChooser is a smart tool for casual home bartenders.

The product helps people:
- Decide what to drink quickly
- Discover cocktails from ingredients they already have
- View/print clear recipes
- Log what they tried to avoid repeats later

Scope guard:
- Home-bartender decision support only
- Not professional bar software
- Not a POS system
- Not inventory management software

Current technical/schema direction:
- `Cocktail*` tables are canonical
- `Recipe*` tables are being consolidated/removed via migrations
- `CocktailSteps` is the canonical instruction-step table

Near-term product focus:
- Ingredient-first filtering
- Recipe quantity clarity
- "Surprise Me" flow quality
- Lightweight personalization (recently tried awareness)
