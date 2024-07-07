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
    [Collection("Environment collection")]
    public class CocktailRecipeServiceTests
    {
        private readonly IMapper _mapper;

        public CocktailRecipeServiceTests()
        {
            var mockMapper = new MapperConfiguration(cfg =>
            {
                cfg.AddProfile(new CocktailChooser.API.Mappings.MappingProfile());
            });
            _mapper = mockMapper.CreateMapper();
        }

        private CocktailChooserContext GetInMemoryContext()
        {
            var options = new DbContextOptionsBuilder<CocktailChooserContext>()
                .UseInMemoryDatabase(databaseName: "TestDatabase")
                .Options;
            return new CocktailChooserContext(options);
        }

        [Fact]
        public async Task GetAllCocktailRecipesAsync_ReturnsListOfCocktailRecipes()
        {
            // Arrange
            using (var context = GetInMemoryContext())
            {
                var service = new CocktailRecipeService(context, _mapper);
                var cocktailRecipes = new List<CocktailRecipe>
                {
                    new CocktailRecipe { CocktailId = 1, StepNumber = 1, Instruction = "Add ice" },
                    new CocktailRecipe { CocktailId = 1, StepNumber = 2, Instruction = "Pour vodka" }
                };

                context.CocktailRecipes.AddRange(cocktailRecipes);
                await context.SaveChangesAsync();

                // Act
                var result = await service.GetAllCocktailRecipesAsync();

                // Assert
                Assert.Equal(2, result.Count());
                Assert.Equal("Add ice", result.First().Instruction);
            }
        }

        [Fact]
        public async Task GetCocktailRecipesByCocktailIdAsync_ReturnsRecipes_WhenRecipesExist()
        {
            // Arrange
            using (var context = GetInMemoryContext())
            {
                var service = new CocktailRecipeService(context, _mapper);
                var cocktailRecipes = new List<CocktailRecipe>
                {
                    new CocktailRecipe { CocktailId = 1, StepNumber = 1, Instruction = "Add ice" },
                    new CocktailRecipe { CocktailId = 1, StepNumber = 2, Instruction = "Pour vodka" }
                };

                context.CocktailRecipes.AddRange(cocktailRecipes);
                await context.SaveChangesAsync();

                // Act
                var result = await service.GetCocktailRecipesByCocktailIdAsync(1);

                // Assert
                Assert.Equal(2, result.Count());
                Assert.Equal("Add ice", result.First().Instruction);
            }
        }

        [Fact]
        public async Task GetCocktailRecipesByCocktailIdAsync_ReturnsEmptyList_WhenRecipesDoNotExist()
        {
            // Arrange
            using (var context = GetInMemoryContext())
            {
                var service = new CocktailRecipeService(context, _mapper);

                // Act
                var result = await service.GetCocktailRecipesByCocktailIdAsync(1);

                // Assert
                Assert.Empty(result);
            }
        }

        [Fact]
        public async Task CreateCocktailRecipeAsync_AddsRecipeToDatabase()
        {
            // Arrange
            using (var context = GetInMemoryContext())
            {
                var service = new CocktailRecipeService(context, _mapper);
                var cocktailRecipeDto = new CocktailRecipeDto { CocktailId = 1, StepNumber = 1, Instruction = "Add ice" };

                // Act
                var result = await service.CreateCocktailRecipeAsync(cocktailRecipeDto);

                // Assert
                Assert.NotNull(result);
                Assert.Equal("Add ice", result.Instruction);
                Assert.NotEqual(0, result.CocktailId);
            }
        }

        [Fact]
        public async Task UpdateCocktailRecipeAsync_ReturnsTrue_WhenRecipeIsUpdated()
        {
            // Arrange
            using (var context = GetInMemoryContext())
            {
                var service = new CocktailRecipeService(context, _mapper);
                var cocktailRecipe = new CocktailRecipe { CocktailId = 1, StepNumber = 1, Instruction = "Add ice" };
                context.CocktailRecipes.Add(cocktailRecipe);
                await context.SaveChangesAsync();

                var cocktailRecipeDto = new CocktailRecipeDto { CocktailId = 1, StepNumber = 1, Instruction = "Updated ice" };

                // Act
                var result = await service.UpdateCocktailRecipeAsync(cocktailRecipeDto);

                // Assert
                Assert.True(result);
                var updatedRecipe = await context.CocktailRecipes.FindAsync(1, 1);
                Assert.Equal("Updated ice", updatedRecipe.Instruction);
            }
        }

        [Fact]
        public async Task DeleteCocktailRecipeAsync_ReturnsTrue_WhenRecipeIsDeleted()
        {
            // Arrange
            using (var context = GetInMemoryContext())
            {
                var service = new CocktailRecipeService(context, _mapper);
                var cocktailRecipe = new CocktailRecipe { CocktailId = 1, StepNumber = 1, Instruction = "Add ice" };
                context.CocktailRecipes.Add(cocktailRecipe);
                await context.SaveChangesAsync();

                // Act
                var result = await service.DeleteCocktailRecipeAsync(1, 1);

                // Assert
                Assert.True(result);
                var deletedRecipe = await context.CocktailRecipes.FindAsync(1, 1);
                Assert.Null(deletedRecipe);
            }
        }

        [Fact]
        public async Task DeleteCocktailRecipeAsync_ReturnsFalse_WhenRecipeDoesNotExist()
        {
            // Arrange
            using (var context = GetInMemoryContext())
            {
                var service = new CocktailRecipeService(context, _mapper);

                // Act
                var result = await service.DeleteCocktailRecipeAsync(1, 1);

                // Assert
                Assert.False(result);
            }
        }
    }
}
