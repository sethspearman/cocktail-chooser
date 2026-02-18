# cocktail-chooser
Cocktail Chooser repositorya## Technical Stack

- .NET 8 WebAPI
- SQLite (default database)
- Dapper (preferred ORM)
- VueJS frontend (TypeScript preferred)
- MAUI planned for mobile app version

Architecture preferences:
- Constructor injection
- Repository pattern when appropriate
- Clean separation between API and data layer

## Technical Stack

- .NET 8 WebAPI
- SQLite (default database)
- Dapper (preferred ORM)
- VueJS frontend (TypeScript preferred)
- MAUI planned for mobile app version

Architecture preferences:
- Constructor injection
- Repository pattern when appropriate
- Clean separation between API and data layer

## MVP Features

- Search cocktails by one or more ingredients
- View cocktail details (ingredients, instructions, time period)
- Store cocktails in SQLite database
- Basic responsive UI

Future:
- User accounts
- Save favorites
- Smart recommendations
- Shopping list generation

## Database Notes

- Cocktails table includes:
  - Id
  - Name
  - Method (full instruction string)
  - TimePeriodId

- CocktailSteps table stores individual steps.
- Ingredients normalized into separate table.

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
