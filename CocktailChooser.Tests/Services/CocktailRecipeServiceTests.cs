using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using Moq;
using Xunit;

public class CocktailRecipeServiceTests
{
    private readonly Mock<ICocktailRecipeService> _mockService;
    private readonly IMapper _mapper;

    public CocktailRecipeServiceTests()
    {
        _mockService = new Mock<ICocktailRecipeService>();

        var mockMapper = new MapperConfiguration(cfg =>
        {
            cfg.AddProfile(new CocktailChooser.API.Mappings.MappingProfile());
        });
        _mapper = mockMapper.CreateMapper();
    }

    [Fact]
    public async Task GetAllCocktailRecipesAsync_ReturnsListOfCocktailRecipes()
    {
        // Arrange
        var cocktailRecipes = new List<CocktailRecipeDto>
        {
            new CocktailRecipeDto { CocktailId = 1, StepNumber = 1, Instruction = "Add ice" },
            new CocktailRecipeDto { CocktailId = 1, StepNumber = 2, Instruction = "Pour vodka" }
        };

        _mockService.Setup(s => s.GetAllCocktailRecipesAsync())
            .ReturnsAsync(cocktailRecipes);

        // Act
        var result = await _mockService.Object.GetAllCocktailRecipesAsync();

        // Assert
        Assert.Equal(2, result.Count());
        Assert.Equal("Add ice", result.First().Instruction);
    }

    [Fact]
    public async Task GetCocktailRecipesByCocktailIdAsync_ReturnsRecipes_WhenRecipesExist()
    {
        // Arrange
        var cocktailRecipes = new List<CocktailRecipeDto>
        {
            new CocktailRecipeDto { CocktailId = 1, StepNumber = 1, Instruction = "Add ice" },
            new CocktailRecipeDto { CocktailId = 1, StepNumber = 2, Instruction = "Pour vodka" }
        };

        _mockService.Setup(s => s.GetCocktailRecipesByCocktailIdAsync(1))
            .ReturnsAsync(cocktailRecipes);

        // Act
        var result = await _mockService.Object.GetCocktailRecipesByCocktailIdAsync(1);

        // Assert
        Assert.Equal(2, result.Count());
        Assert.Equal("Add ice", result.First().Instruction);
    }

    [Fact]
    public async Task GetCocktailRecipesByCocktailIdAsync_ReturnsEmptyList_WhenRecipesDoNotExist()
    {
        // Arrange
        _mockService.Setup(s => s.GetCocktailRecipesByCocktailIdAsync(1))
            .ReturnsAsync(new List<CocktailRecipeDto>());

        // Act
        var result = await _mockService.Object.GetCocktailRecipesByCocktailIdAsync(1);

        // Assert
        Assert.Empty(result);
    }

    [Fact]
    public async Task CreateCocktailRecipeAsync_AddsRecipeToDatabase()
    {
        // Arrange
        var cocktailRecipeDto = new CocktailRecipeDto { CocktailId = 1, StepNumber = 1, Instruction = "Add ice" };
        var createdCocktailRecipeDto = new CocktailRecipeDto { CocktailId = 1, StepNumber = 1, Instruction = "Add ice" };

        _mockService.Setup(s => s.CreateCocktailRecipeAsync(cocktailRecipeDto))
            .ReturnsAsync(createdCocktailRecipeDto);

        // Act
        var result = await _mockService.Object.CreateCocktailRecipeAsync(cocktailRecipeDto);

        // Assert
        Assert.NotNull(result);
        Assert.Equal("Add ice", result.Instruction);
    }

    [Fact]
    public async Task UpdateCocktailRecipeAsync_ReturnsTrue_WhenRecipeIsUpdated()
    {
        // Arrange
        var cocktailRecipeDto = new CocktailRecipeDto { CocktailId = 1, StepNumber = 1, Instruction = "Add ice" };

        _mockService.Setup(s => s.UpdateCocktailRecipeAsync(cocktailRecipeDto))
            .ReturnsAsync(true);

        // Act
        var result = await _mockService.Object.UpdateCocktailRecipeAsync(cocktailRecipeDto);

        // Assert
        Assert.True(result);
    }

    [Fact]
    public async Task DeleteCocktailRecipeAsync_ReturnsTrue_WhenRecipeIsDeleted()
    {
        // Arrange
        _mockService.Setup(s => s.DeleteCocktailRecipeAsync(1, 1))
            .ReturnsAsync(true);

        // Act
        var result = await _mockService.Object.DeleteCocktailRecipeAsync(1, 1);

        // Assert
        Assert.True(result);
    }

    [Fact]
    public async Task DeleteCocktailRecipeAsync_ReturnsFalse_WhenRecipeDoesNotExist()
    {
        // Arrange
        _mockService.Setup(s => s.DeleteCocktailRecipeAsync(1, 1))
            .ReturnsAsync(false);

        // Act
        var result = await _mockService.Object.DeleteCocktailRecipeAsync(1, 1);

        // Assert
        Assert.False(result);
    }
}
