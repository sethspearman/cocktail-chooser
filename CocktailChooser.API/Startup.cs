using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using CocktailChooser.API.Mappings;
using CocktailChooser.API.Models;
using CocktailChooser.API.Services;
using Microsoft.EntityFrameworkCore;

public class Startup
{
    public Startup(IConfiguration configuration)
    {
        Configuration = configuration;
    }

    public IConfiguration Configuration { get; }

    public void ConfigureServices(IServiceCollection services)
    {
        var environment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT");

        if (environment == "Test")
        {
            services.AddDbContext<CocktailChooserContext>(options =>
                options.UseInMemoryDatabase("TestDatabase"));
        }
        else
        {
            services.AddDbContext<CocktailChooserContext>(options =>
                options.UseSqlite(Configuration.GetConnectionString("DefaultConnection")));
        }

        services.AddControllers();
        services.AddAutoMapper(typeof(MappingProfile));
        services.AddEndpointsApiExplorer();
        services.AddSwaggerGen();
        services.AddScoped<ICocktailService, CocktailService>();
        services.AddScoped<IIngredientService, IngredientService>();
        services.AddScoped<ICocktailRecipeService, CocktailRecipeService>();
    }

    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
        if (env.IsDevelopment())
        {
            app.UseDeveloperExceptionPage();
            app.UseSwagger();
            app.UseSwaggerUI();
        }

        app.UseHttpsRedirection();
        app.UseAuthorization();
        app.UseEndpoints(endpoints =>
        {
            endpoints.MapControllers();
        });
    }
}