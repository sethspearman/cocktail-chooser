using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using CocktailChooser.API.DTOs;
using CocktailChooser.API.Models;
using CocktailChooser.API.Services;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Xunit;

public class IngredientServiceTests : IClassFixture<CocktailChooserWebApplicationFactory>
{
    private readonly CocktailChooserWebApplicationFactory _factory;
    private readonly IMapper _mapper;

    public IngredientServiceTests(CocktailChooserWebApplicationFactory factory)
    {
        _factory = factory;

        var mockMapper = new MapperConfiguration(cfg =>
        {
            cfg.AddProfile(new CocktailChooser.API.Mappings.MappingProfile());
        });
        _mapper = mockMapper.CreateMapper();
    }

    private CocktailChooserContext GetInMemoryContext()
    {
        var options = new DbContextOptionsBuilder<CocktailChooserContext>()
            .UseInMemoryDatabase(databaseName: "InMemoryDbForTesting")
            .Options;
        return new CocktailChooserContext(options);
    }

    [Fact]
    public async Task GetAllIngredientsAsync_ReturnsListOfIngredients()
    {
        // Arrange
        using (var context = GetInMemoryContext())
        {
            var service = new IngredientService(context, _mapper);
            var ingredients = new List<Ingredient>
            {
                new Ingredient { Id = 1, Name = "Vodka" },
                new Ingredient { Id = 2, Name = "Gin" }
            };

            context.Ingredients.AddRange(ingredients);
            await context.SaveChangesAsync();

            // Act
            var result = await service.GetAllIngredientsAsync();

            // Assert
            Assert.Equal(2, result.Count());
            Assert.Equal("Vodka", result.First().Name);
        }
    }

    [Fact]
    public async Task GetIngredientByIdAsync_ReturnsIngredient_WhenIngredientExists()
    {
        // Arrange
        using (var context = GetInMemoryContext())
        {
            var service = new IngredientService(context, _mapper);
            var ingredient = new Ingredient { Id = 1, Name = "Vodka" };
            context.Ingredients.Add(ingredient);
            await context.SaveChangesAsync();

            // Act
            var result = await service.GetIngredientByIdAsync(1);

            // Assert
            Assert.NotNull(result);
            Assert.Equal("Vodka", result.Name);
        }
    }

    [Fact]
    public async Task GetIngredientByIdAsync_ReturnsNull_WhenIngredientDoesNotExist()
    {
        // Arrange
        using (var context = GetInMemoryContext())
        {
            var service = new IngredientService(context, _mapper);

            // Act
            var result = await service.GetIngredientByIdAsync(1);

            // Assert
            Assert.Null(result);
        }
    }

    [Fact]
    public async Task CreateIngredientAsync_AddsIngredientToDatabase()
    {
        // Arrange
        using (var context = GetInMemoryContext())
        {
            var service = new IngredientService(context, _mapper);
            var ingredientDto = new IngredientDto { Name = "Vodka" };

            // Act
            var result = await service.CreateIngredientAsync(ingredientDto);

            // Assert
            Assert.NotNull(result);
            Assert.Equal("Vodka", result.Name);
            Assert.NotEqual(0, result.Id);
        }
    }

    [Fact]
    public async Task UpdateIngredientAsync_ReturnsTrue_WhenIngredientIsUpdated()
    {
        // Arrange
        using (var context = GetInMemoryContext())
        {
            var service = new IngredientService(context, _mapper);
            var ingredient = new Ingredient { Id = 1, Name = "Vodka" };
            context.Ingredients.Add(ingredient);
            await context.SaveChangesAsync();

            var ingredientDto = new IngredientDto { Id = 1, Name = "Updated Vodka" };

            // Act
            var result = await service.UpdateIngredientAsync(ingredientDto);

            // Assert
            Assert.True(result);
            var updatedIngredient = await context.Ingredients.FindAsync(1);
            Assert.Equal("Updated Vodka", updatedIngredient.Name);
        }
    }

    [Fact]
    public async Task DeleteIngredientAsync_ReturnsTrue_WhenIngredientIsDeleted()
    {
        // Arrange
        using (var context = GetInMemoryContext())
        {
            var service = new IngredientService(context, _mapper);
            var ingredient = new Ingredient { Id = 1, Name = "Vodka" };
            context.Ingredients.Add(ingredient);
            await context.SaveChangesAsync();

            // Act
            var result = await service.DeleteIngredientAsync(1);

            // Assert
            Assert.True(result);
            var deletedIngredient = await context.Ingredients.FindAsync(1);
            Assert.Null(deletedIngredient);
        }
    }

    [Fact]
    public async Task DeleteIngredientAsync_ReturnsFalse_WhenIngredientDoesNotExist()
    {
        // Arrange
        using (var context = GetInMemoryContext())
        {
            var service = new IngredientService(context, _mapper);

            // Act
            var result = await service.DeleteIngredientAsync(1);

            // Assert
            Assert.False(result);
        }
    }
}
