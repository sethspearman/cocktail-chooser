using System.IO;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using CocktailChooser.API.Auth;
using CocktailChooser.API.Services;
using CocktailChooser.Data.Repositories;
using Dapper;
using Microsoft.Data.Sqlite;

public class TestStartup
{
    public TestStartup(IConfiguration configuration)
    {
        Configuration = configuration;
    }

    public IConfiguration Configuration { get; }

    public void ConfigureServices(IServiceCollection services)
    {
        services.AddControllers();
        services.Configure<AuthOptions>(options =>
        {
            options.SecretKey = "test-secret-key";
            options.TokenLifetimeHours = 24;
        });
        services.AddScoped<ICurrentUserContext, CurrentUserContext>();
        services.AddSingleton<ITokenService, TokenService>();
        services.AddSingleton<IPasswordHasher, PasswordHasher>();
        var databasePath = Path.Combine(Path.GetTempPath(), $"cocktailchooser-tests-{Guid.NewGuid():N}.db");
        var connectionString = $"Data Source={databasePath};Foreign Keys=True";

        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Execute("""
                CREATE TABLE IF NOT EXISTS Cocktails (
                    Id INTEGER PRIMARY KEY AUTOINCREMENT,
                    Name TEXT NOT NULL,
                    Description TEXT,
                    Method TEXT,
                    GlassTypeId INTEGER,
                    TimePeriodId INTEGER,
                    IsPopular INTEGER DEFAULT 0,
                    IsApproved INTEGER NOT NULL DEFAULT 0,
                    IsUserSubmitted INTEGER NOT NULL DEFAULT 0,
                    SubmittedByUserId INTEGER,
                    CocktailSourceId INTEGER
                );
                CREATE TABLE IF NOT EXISTS CocktailTimePeriods (
                    Id INTEGER PRIMARY KEY AUTOINCREMENT,
                    Name TEXT NOT NULL
                );
                CREATE TABLE IF NOT EXISTS Ingredients (
                    Id INTEGER PRIMARY KEY AUTOINCREMENT,
                    Name TEXT NOT NULL,
                    IngredientTypeId INTEGER,
                    MixerSubtypeId INTEGER,
                    PrimarySpirit TEXT,
                    LongDescription TEXT
                );
                CREATE TABLE IF NOT EXISTS Amounts (
                    Id INTEGER PRIMARY KEY AUTOINCREMENT,
                    MeasurementName TEXT NOT NULL,
                    Ounces REAL
                );
                CREATE TABLE IF NOT EXISTS CocktailIngredients (
                    Id INTEGER PRIMARY KEY AUTOINCREMENT,
                    CocktailId INTEGER NOT NULL,
                    IngredientId INTEGER NOT NULL,
                    AmountId INTEGER,
                    AmountText TEXT,
                    SortOrder INTEGER
                );
                CREATE TABLE IF NOT EXISTS CocktailSteps (
                    CocktailId INTEGER NOT NULL,
                    StepNumber INTEGER NOT NULL,
                    Instruction TEXT,
                    PRIMARY KEY (CocktailId, StepNumber)
                );
                CREATE TABLE IF NOT EXISTS Users (
                    Id INTEGER PRIMARY KEY AUTOINCREMENT,
                    DisplayName TEXT NOT NULL,
                    Email TEXT,
                    PasswordHash TEXT,
                    PasswordSalt TEXT,
                    PasswordIterations INTEGER,
                    CreatedUtc TEXT NOT NULL,
                    UpdatedUtc TEXT NOT NULL
                );
                CREATE TABLE IF NOT EXISTS UserIngredients (
                    UserId INTEGER NOT NULL,
                    IngredientId INTEGER NOT NULL,
                    IsInStock INTEGER NOT NULL DEFAULT 1,
                    Notes TEXT,
                    UpdatedUtc TEXT NOT NULL,
                    PRIMARY KEY (UserId, IngredientId)
                );
                CREATE TABLE IF NOT EXISTS CocktailTryLogs (
                    Id INTEGER PRIMARY KEY AUTOINCREMENT,
                    UserId INTEGER NOT NULL,
                    CocktailId INTEGER NOT NULL,
                    Rating INTEGER,
                    Comment TEXT,
                    TriedOnUtc TEXT NOT NULL,
                    CreatedUtc TEXT NOT NULL,
                    UpdatedUtc TEXT NOT NULL
                );
                """);
        }

        services.AddScoped<ICocktailRepository>(_ =>
        {
            return new CocktailRepository(connectionString);
        });
        services.AddScoped<IAmountRepository>(_ => new AmountRepository(connectionString));
        services.AddScoped<IIngredientRepository>(_ => new IngredientRepository(connectionString));
        services.AddScoped<ICocktailIngredientRepository>(_ => new CocktailIngredientRepository(connectionString));
        services.AddScoped<ICocktailRecipeRepository>(_ => new CocktailRecipeRepository(connectionString));
        services.AddScoped<IUserRepository>(_ => new UserRepository(connectionString));
        services.AddScoped<IUserIngredientRepository>(_ => new UserIngredientRepository(connectionString));
        services.AddScoped<ICocktailTryLogRepository>(_ => new CocktailTryLogRepository(connectionString));
        services.AddScoped<IOcrRecipeParser, HeuristicOcrRecipeParser>();
        services.AddScoped<ICocktailService, CocktailService>();
        services.AddScoped<IIngredientService, IngredientService>();
        services.AddScoped<ICocktailRecipeService, CocktailRecipeService>();
        services.AddScoped<IUserService, UserService>();
        services.AddScoped<IAuthService, AuthService>();
        services.AddScoped<IUserInventoryService, UserInventoryService>();
        services.AddScoped<ICocktailTryLogService, CocktailTryLogService>();
    }

    public void Configure(IApplicationBuilder app)
    {
        app.UseDeveloperExceptionPage();
        app.UseHttpsRedirection();
        app.UseMiddleware<AuthTokenMiddleware>();
        app.UseAuthorization();
        app.UseEndpoints(endpoints =>
        {
            endpoints.MapControllers();
        });
    }
}
