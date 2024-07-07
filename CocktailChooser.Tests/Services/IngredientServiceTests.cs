using Xunit;
using AutoMapper;
using Microsoft.EntityFrameworkCore;
using CocktailChooser.API.Services;
using CocktailChooser.API.Models;
using CocktailChooser.API.DTOs;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Linq;

namespace CocktailChooser.Tests.Services
{
    public class IngredientServiceTests
    {
        private readonly IMapper _mapper;
        private readonly CocktailChooserContext _context;
        private readonly IngredientService _service;

        public IngredientServiceTests()
        {
            var mockMapper = new MapperConfiguration(cfg =>
            {
                cfg.AddProfile(new CocktailChooser.API.Mappings.MappingProfile());
            });
            _mapper = mockMapper.CreateMapper();

            var options = new DbContextOptionsBuilder<CocktailChooserContext>()
                .UseInMemoryDatabase(databaseName: "TestDatabase")
                .Options;

            _context = new CocktailChooserContext(options);
            _service = new IngredientService(_context, _mapper);
        }

        [Fact]
        public async Task GetAllIngredientsAsync_ReturnsListOfIngredients()
        {
            // Arrange
            var ingredients = new List<Ingredient>
            {
                new Ingredient { Id = 1, Name = "Vodka" },
                new Ingredient { Id = 2, Name = "Gin" }
            };

            _context.Ingredients.AddRange(ingredients);
            await _context.SaveChangesAsync();

            // Act
            var result = await _service.GetAllIngredientsAsync();

            // Assert
            Assert.Equal(2, result.Count());
            Assert.Equal("Vodka", result.First().Name);
        }

        [Fact]
        public async Task GetIngredientByIdAsync_ReturnsIngredient_WhenIngredientExists()
        {
            // Arrange
            var ingredient = new Ingredient { Id = 1, Name = "Vodka" };
            _context.Ingredients.Add(ingredient);
            await _context.SaveChangesAsync();

            // Act
            var result = await _service.GetIngredientByIdAsync(1);

            // Assert
            Assert.NotNull(result);
            Assert.Equal("Vodka", result.Name);
        }

        [Fact]
        public async Task GetIngredientByIdAsync_ReturnsNull_WhenIngredientDoesNotExist()
        {
            // Act
            var result = await _service.GetIngredientByIdAsync(1);

            // Assert
            Assert.Null(result);
        }

        [Fact]
        public async Task CreateIngredientAsync_AddsIngredientToDatabase()
        {
            // Arrange
            var ingredientDto = new IngredientDto { Name = "Vodka" };

            // Act
            var result = await _service.CreateIngredientAsync(ingredientDto);

            // Assert
            Assert.NotNull(result);
            Assert.Equal("Vodka", result.Name);
            Assert.NotEqual(0, result.Id);
        }

        [Fact]
        public async Task UpdateIngredientAsync_ReturnsTrue_WhenIngredientIsUpdated()
        {
            // Arrange
            var ingredient = new Ingredient { Id = 1, Name = "Vodka" };
            _context.Ingredients.Add(ingredient);
            await _context.SaveChangesAsync();

            var ingredientDto = new IngredientDto { Id = 1, Name = "Updated Vodka" };

            // Act
            var result = await _service.UpdateIngredientAsync(ingredientDto);

            // Assert
            Assert.True(result);
            var updatedIngredient = await _context.Ingredients.FindAsync(1);
            Assert.Equal("Updated Vodka", updatedIngredient.Name);
        }

        [Fact]
        public async Task DeleteIngredientAsync_ReturnsTrue_WhenIngredientIsDeleted()
        {
            // Arrange
            var ingredient = new Ingredient { Id = 1, Name = "Vodka" };
            _context.Ingredients.Add(ingredient);
            await _context.SaveChangesAsync();

            // Act
            var result = await _service.DeleteIngredientAsync(1);

            // Assert
            Assert.True(result);
            var deletedIngredient = await _context.Ingredients.FindAsync(1);
            Assert.Null(deletedIngredient);
        }

        [Fact]
        public async Task DeleteIngredientAsync_ReturnsFalse_WhenIngredientDoesNotExist()
        {
            // Act
            var result = await _service.DeleteIngredientAsync(1);

            // Assert
            Assert.False(result);
        }
    }
}
