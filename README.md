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
