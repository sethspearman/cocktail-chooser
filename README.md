# CocktailChooser is a smart tool for casual home bartenders.

CocktailChooser helps people decide what to drink quickly based on what they feel like, what ingredients they have in My Bar, and what they have tried before.

Scope guard:
- Home-bartender decision support
- Not professional bar software
- Not a POS system
- Not inventory management software

## Technical Stack

- .NET 8 WebAPI
- SQLite (default database)
- Dapper (preferred ORM)
- VueJS frontend (TypeScript preferred)
- MAUI is a possible future client (after the core web experience is stable)

Architecture preferences:
- Constructor injection
- Repository pattern when appropriate
- Clean separation between API and data layer

## Product Docs

- Vision: `docs/product-vision.md`
- Roadmap: `docs/roadmap.md`
- Project overview: `docs/project-overview.md`
- Scope guard / feature decision rubric: `docs/scope-guard.md`
- Backlog triage notes: `docs/backlog-triage.md`

## MVP Features

- Ingredient-first cocktail discovery/filtering
- View cocktail details (ingredients, instructions, time period)
- View/print cocktail recipes
- Store cocktails in SQLite database
- Basic responsive UI
- Lightweight My Bar checklist for personalized suggestions

Future:
- User accounts
- Save favorites
- Smart recommendations
- Mobile app client

## Database Notes

- Canonical tables are `Cocktail*` (no `Recipe*` tables after migrations).
- `Cocktails` contains merged cocktail + recipe metadata fields.
- `CocktailSource` contains source metadata fields previously stored on `RecipeSources`.
- `CocktailIngredients` contains merged ingredient-link fields (including sort order).
- `CocktailSteps` stores individual instructions per cocktail.
- `GlassTypes` supports optional image URL metadata via `ImageUrl`.
- OCR staging tables remain separate (`Ocr*`) and reference `CocktailSource`.

### Bootstrap Seed Policy

- Bootstrap (`initial_data.sql`) does not seed:
  - `Cocktails`
  - `CocktailIngredients`
  - `CocktailSteps`
- These are intended to be populated via OCR/import workflows.

## Coding Principles

- Avoid Entity Framework unless explicitly requested.
- Prefer Dapper for data access.
- Keep controllers thin.
- Business logic in services.
- Code should be testable.
- xUnit for unit testing.

## Migration Strategy

- Bootstrap only:
  - `CocktailChooser.Data/Data/Migrations/initial_schema.sql`
  - `CocktailChooser.Data/Data/Migrations/initial_data.sql`
- Versioned migrations:
  - Add forward-only SQL files in `CocktailChooser.Data/Data/Migrations/Versions`
  - Naming format: `NNN_description.sql` (example: `002_add_favorites.sql`)
- Runtime application:
  - API startup runs `SqlMigrationRunner` before serving requests.
  - Runner creates/uses `SchemaMigrations` to track applied scripts and checksums.
- Scope guidance:
  - DDL changes go in versioned migrations (table/index/constraint changes).
  - DML backfills and data cleanup also go in versioned migrations, in the same release where needed.

## Web UI Quick Start

### 1. Run the API

From repo root:

```bash
./tools/dotnet run --project CocktailChooser.API
```

The API runs on `http://localhost:5190` in development (see `CocktailChooser.API/Properties/launchSettings.json`).
Migrations are applied automatically on startup.

### 2. Run the Vue frontend

In a second terminal:

```bash
cd cocktailchooser-frontend
npm install
npm run serve
```

Open: `http://localhost:8080`

### 3. Frontend/API wiring

- Dev mode uses proxy config in `cocktailchooser-frontend/vue.config.js`:
  - `/api/*` -> `http://localhost:5190`
- Optional override:
  - set `VUE_APP_API_BASE_URL` (for non-local API targets)

### 4. MVP screens now available

- Cocktails list with search + `PrimarySpirit` filter
- My Bar checklist per user (lightweight; not inventory management software)
- “What Can I Drink” matching from inventory
- Cocktail detail with:
  - ingredients + steps
  - groupings
  - missing ingredients
  - try logs (rating/comment/date)
