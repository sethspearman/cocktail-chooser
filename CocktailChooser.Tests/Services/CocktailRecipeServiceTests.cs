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
    public class CocktailRecipeServiceTests
    {
        private readonly IMapper _mapper;
        private readonly CocktailChooserContext _context;
        private readonly CocktailRecipeService _service;

        public CocktailRecipeServiceTests()
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
            _service = new CocktailRecipeService(_context, _mapper);
        }

        [Fact]
        public async Task GetAllCocktailRecipesAsync_ReturnsListOfCocktailRecipes()
        {
            // Arrange
            var cocktailRecipes = new List<CocktailRecipe>
            {
                new CocktailRecipe { CocktailId = 1, StepNumber = 1, Instruction = "Add ice" },
                new CocktailRecipe { CocktailId = 1, StepNumber = 2, Instruction = "Pour vodka" }
            };

            _context.CocktailRecipes.AddRange(cocktailRecipes);
            await _context.SaveChangesAsync();

            // Act
            var result = await _service.GetAllCocktailRecipesAsync();

            // Assert
            Assert.Equal(2, result.Count());
            Assert.Equal("Add ice", result.First().Instruction);
        }

        [Fact]
        public async Task GetCocktailRecipesByCocktailIdAsync_ReturnsRecipes_WhenRecipesExist()
        {
            // Arrange
            var cocktailRecipes = new List<CocktailRecipe>
            {
                new CocktailRecipe { CocktailId = 1, StepNumber = 1, Instruction = "Add ice" },
                new CocktailRecipe { CocktailId = 1, StepNumber = 2, Instruction = "Pour vodka" }
            };

            _context.CocktailRecipes.AddRange(cocktailRecipes);
            await _context.SaveChangesAsync();

            // Act
            var result = await _service.GetCocktailRecipesByCocktailIdAsync(1);

            // Assert
            Assert.Equal(2, result.Count());
            Assert.Equal("Add ice", result.First().Instruction);
        }

        [Fact]
        public async Task GetCocktailRecipesByCocktailIdAsync_ReturnsEmptyList_WhenRecipesDoNotExist()
        {
            // Act
            var result = await _service.GetCocktailRecipesByCocktailIdAsync(1);

            // Assert
            Assert.Empty(result);
        }

        [Fact]
        public async Task CreateCocktailRecipeAsync_AddsRecipeToDatabase()
        {
            // Arrange
            var cocktailRecipeDto = new CocktailRecipeDto { CocktailId = 1, StepNumber = 1, Instruction = "Add ice" };

            // Act
            var result = await _service.CreateCocktailRecipeAsync(cocktailRecipeDto);

            // Assert
            Assert.NotNull(result);
            Assert.Equal("Add ice", result.Instruction);
            Assert.NotEqual(0, result.CocktailId);
        }

        [Fact]
        public async Task UpdateCocktailRecipeAsync_ReturnsTrue_WhenRecipeIsUpdated()
        {
            // Arrange
            var cocktailRecipe = new CocktailRecipe { CocktailId = 1, StepNumber = 1, Instruction = "Add ice" };
            _context.CocktailRecipes.Add(cocktailRecipe);
            await _context.SaveChangesAsync();

            var cocktailRecipeDto = new CocktailRecipeDto { CocktailId = 1, StepNumber = 1, Instruction = "Updated ice" };

            // Act
            var result = await _service.UpdateCocktailRecipeAsync(cocktailRecipeDto);

            // Assert
            Assert.True(result);
            var updatedRecipe = await _context.CocktailRecipes.FindAsync(1, 1);
            Assert.Equal("Updated ice", updatedRecipe.Instruction);
        }

        [Fact]
        public async Task DeleteCocktailRecipeAsync_ReturnsTrue_WhenRecipeIsDeleted()
        {
            // Arrange
            var cocktailRecipe = new CocktailRecipe { CocktailId = 1, StepNumber = 1, Instruction = "Add ice" };
            _context.CocktailRecipes.Add(cocktailRecipe);
            await _context.SaveChangesAsync();

            // Act
            var result = await _service.DeleteCocktailRecipeAsync(1, 1);

            // Assert
            Assert.True(result);
            var deletedRecipe = await _context.CocktailRecipes.FindAsync(1, 1);
            Assert.Null(deletedRecipe);
        }

        [Fact]
        public async Task DeleteCocktailRecipeAsync_ReturnsFalse_WhenRecipeDoesNotExist()
        {
            // Act
            var result = await _service.DeleteCocktailRecipeAsync(1, 1);

            // Assert
            Assert.False(result);
        }
    }
}
