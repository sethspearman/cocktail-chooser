using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using CocktailChooser.API.Models;
using Microsoft.EntityFrameworkCore;
using Xunit;

public class CocktailRecipeServiceIntegrationTests : IClassFixture<CustomWebApplicationFactory<TestStartup>>
{
    private readonly CustomWebApplicationFactory<TestStartup> _factory;
    private readonly IMapper _mapper;

    public CocktailRecipeServiceIntegrationTests(CustomWebApplicationFactory<TestStartup> factory)
    {
        _factory = factory;

        var mockMapper = new MapperConfiguration(cfg =>
        {
            cfg.AddProfile(new CocktailChooser.API.Mappings.MappingProfile());
        });
        _mapper = mockMapper.CreateMapper();
    }

    private CocktailChooserContext GetInMemoryContext(string databaseName)
    {
        var options = new DbContextOptionsBuilder<CocktailChooserContext>()
            .UseInMemoryDatabase(databaseName)
            .Options;
        return new CocktailChooserContext(options);
    }

    private void SeedDatabase(CocktailChooserContext context)
    {
        context.CocktailRecipes.AddRange(new List<CocktailRecipe>
        {
            new CocktailRecipe { CocktailId = 1, StepNumber = 1, Instruction = "Add ice" },
            new CocktailRecipe { CocktailId = 1, StepNumber = 2, Instruction = "Pour vodka" }
        });
        context.SaveChanges();
    }

    [Fact]
    public async Task GetCocktailRecipeByIdAsync_ReturnsRecipe_WhenRecipeExists()
    {
        // Arrange
        var context = GetInMemoryContext("TestDatabase1");
        SeedDatabase(context);
        var service = new CocktailRecipeService(context, _mapper);

        // Act
        var result = await service.GetCocktailRecipeByIdAsync(1, 1);

        // Assert
        Assert.NotNull(result);
        Assert.Equal("Add ice", result.Instruction);
    }

    // Additional integration tests...
}
