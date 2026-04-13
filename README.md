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
- Mobile direction: Capacitor wrapper around the existing Vue app for the first iOS/Android release
- `CocktailChooser.Maui` remains an exploratory prototype, not the current mobile delivery path

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

Mobile architecture decision:

- See `docs/mobile-app-architecture.md`

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

## Admin API (Issue #52)

MVP admin policy in this codebase:
- User with `Id = 1` is treated as admin.
- Admin-only cocktail management endpoints are server-side protected.

### Export endpoints

- Export all cocktails (optional source filter):
  - `GET /api/cocktails/admin/export`
  - `GET /api/cocktails/admin/export?sourceId=2`
  - `GET /api/cocktails/admin/export?sourceId=2&offset=0&limit=100`
- Export one cocktail:
  - `GET /api/cocktails/admin/export/{id}`

Pagination/query params:
- `offset` (optional): skip first N rows (default `0`)
- `limit` (optional): max rows to return
- Results are ordered by cocktail name.

Example export item (round-trip compatible):

```json
{
  "cocktailId": 12,
  "canonicalKey": "aliza_imports::old_fashioned",
  "name": "Old Fashioned",
  "description": "Whiskey classic.",
  "method": "Stir with ice and strain.",
  "glassTypeId": 3,
  "timePeriodId": 2,
  "isPopular": 1,
  "isApproved": 1,
  "isUserSubmitted": 0,
  "submittedByUserId": null,
  "cocktailSourceId": 2,
  "structuredIngredients": [
    { "amountId": 10, "amountText": null, "ingredientName": "Bourbon" },
    { "amountId": null, "amountText": "2 dashes", "ingredientName": "Angostura bitters" }
  ],
  "structuredSteps": [
    { "instruction": "Add ingredients to a mixing glass with ice." },
    { "instruction": "Stir and strain over fresh ice." }
  ]
}
```

### Import endpoint

- `POST /api/cocktails/admin/import`

Request body:

```json
{
  "cocktails": [
    {
      "cocktailId": 12,
      "canonicalKey": "aliza_imports::old_fashioned",
      "name": "Old Fashioned",
      "description": "Updated text",
      "structuredIngredients": [
        { "amountId": 10, "ingredientName": "Bourbon" }
      ],
      "structuredSteps": [
        { "instruction": "Stir with ice." }
      ]
    }
  ]
}
```

Matching/upsert rules:
1. If `canonicalKey` matches an existing record, update that record.
2. Else create a new cocktail with that canonical key.

Notes:
- `cocktailId` is included in payloads for convenience, but import identity matching is CanonicalKey-based for cross-environment safety.
- Canonical keys are normalized and collision suffixing uses `__vN` (for example, `my_source::daiquiri__v2`).

Transaction behavior:
- Import executes **per item transactionally**.
- Each item commits all related changes (cocktail + ingredients + steps) or rolls back completely.

Response summary shape:

```json
{
  "created": 1,
  "updated": 2,
  "failed": 1,
  "items": [
    { "inputIndex": 0, "cocktailId": 101, "canonicalKey": "my_source::demo", "action": "created", "error": null },
    { "inputIndex": 1, "cocktailId": null, "canonicalKey": null, "action": "failed", "error": "Name is required." }
  ]
}
```

Web admin UX:
- `/admin` includes import summary totals.
- You can download per-item import results as CSV (`inputIndex,action,cocktailId,canonicalKey,error`).
