using System.IO;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
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
        var databasePath = Path.Combine(Path.GetTempPath(), "cocktailchooser-tests.db");
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
                    CocktailSourceId INTEGER
                );
                CREATE TABLE IF NOT EXISTS Ingredients (
                    Id INTEGER PRIMARY KEY AUTOINCREMENT,
                    Name TEXT NOT NULL,
                    IngredientTypeId INTEGER,
                    MixerSubtypeId INTEGER,
                    LongDescription TEXT
                );
                CREATE TABLE IF NOT EXISTS CocktailSteps (
                    CocktailId INTEGER NOT NULL,
                    StepNumber INTEGER NOT NULL,
                    Instruction TEXT,
                    PRIMARY KEY (CocktailId, StepNumber)
                );
                """);
        }

        services.AddScoped<ICocktailRepository>(_ =>
        {
            return new CocktailRepository(connectionString);
        });
        services.AddScoped<IIngredientRepository>(_ => new IngredientRepository(connectionString));
        services.AddScoped<ICocktailRecipeRepository>(_ => new CocktailRecipeRepository(connectionString));
        services.AddScoped<ICocktailService, CocktailService>();
        services.AddScoped<IIngredientService, IngredientService>();
        services.AddScoped<ICocktailRecipeService, CocktailRecipeService>();
    }

    public void Configure(IApplicationBuilder app)
    {
        app.UseDeveloperExceptionPage();
        app.UseHttpsRedirection();
        app.UseAuthorization();
        app.UseEndpoints(endpoints =>
        {
            endpoints.MapControllers();
        });
    }
}
