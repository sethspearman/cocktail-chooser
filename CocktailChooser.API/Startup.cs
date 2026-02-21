using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using CocktailChooser.API.Services;
using CocktailChooser.Data.Migrations;
using CocktailChooser.Data.Repositories;

public class Startup
{
    public Startup(IConfiguration configuration)
    {
        Configuration = configuration;
    }

    public IConfiguration Configuration { get; }

    public void ConfigureServices(IServiceCollection services)
    {
        var connectionString = Configuration.GetConnectionString("DefaultConnection")
            ?? throw new InvalidOperationException("Missing connection string: DefaultConnection");

        services.AddControllers();
        services.AddEndpointsApiExplorer();
        services.AddSwaggerGen();
        services.AddScoped<ICocktailRepository>(_ => new CocktailRepository(connectionString));
        services.AddScoped<IIngredientRepository>(_ => new IngredientRepository(connectionString));
        services.AddScoped<ICocktailIngredientRepository>(_ => new CocktailIngredientRepository(connectionString));
        services.AddScoped<ICocktailRecipeRepository>(_ => new CocktailRecipeRepository(connectionString));
        services.AddScoped<IRecipeSourceRepository>(_ => new RecipeSourceRepository(connectionString));
        services.AddScoped<IRecipeRepository>(_ => new RecipeRepository(connectionString));
        services.AddScoped<IOcrImportRepository>(_ => new OcrImportRepository(connectionString));
        services.AddScoped<IUserRepository>(_ => new UserRepository(connectionString));
        services.AddScoped<IUserIngredientRepository>(_ => new UserIngredientRepository(connectionString));
        services.AddScoped<ICocktailTryLogRepository>(_ => new CocktailTryLogRepository(connectionString));
        services.AddScoped<ICocktailGroupingRepository>(_ => new CocktailGroupingRepository(connectionString));
        services.AddScoped<ICocktailService, CocktailService>();
        services.AddScoped<IIngredientService, IngredientService>();
        services.AddScoped<ICocktailIngredientService, CocktailIngredientService>();
        services.AddScoped<ICocktailRecipeService, CocktailRecipeService>();
        services.AddScoped<IRecipeSourceService, RecipeSourceService>();
        services.AddScoped<IRecipeService, RecipeService>();
        services.AddScoped<IUserService, UserService>();
        services.AddScoped<IUserInventoryService, UserInventoryService>();
        services.AddScoped<ICocktailTryLogService, CocktailTryLogService>();
        services.AddScoped<ICocktailGroupingService, CocktailGroupingService>();
        services.AddScoped<IOcrRecipeParser, HeuristicOcrRecipeParser>();
        services.AddScoped<IOcrImportService, OcrImportService>();
    }

    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
        var connectionString = Configuration.GetConnectionString("DefaultConnection")
            ?? throw new InvalidOperationException("Missing connection string: DefaultConnection");
        SqlMigrationRunner.Run(connectionString);

        if (env.IsDevelopment())
        {
            app.UseDeveloperExceptionPage();
            app.UseSwagger();
            app.UseSwaggerUI();
        }

        app.UseRouting();
        app.UseHttpsRedirection();
        app.UseAuthorization();
        app.UseEndpoints(endpoints =>
        {
            endpoints.MapControllers();
        });
    }
}
