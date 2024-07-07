using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using Moq;
using Xunit;

public class IngredientServiceTests
{
    private readonly Mock<IIngredientService> _mockService;
    private readonly IMapper _mapper;

    public IngredientServiceTests()
    {
        _mockService = new Mock<IIngredientService>();

        var mockMapper = new MapperConfiguration(cfg =>
        {
            cfg.AddProfile(new CocktailChooser.API.Mappings.MappingProfile());
        });
        _mapper = mockMapper.CreateMapper();
    }

    [Fact]
    public async Task GetAllIngredientsAsync_ReturnsListOfIngredients()
    {
        // Arrange
        var ingredients = new List<IngredientDto>
        {
            new IngredientDto { Id = 1, Name = "Vodka" },
            new IngredientDto { Id = 2, Name = "Gin" }
        };

        _mockService.Setup(s => s.GetAllIngredientsAsync())
            .ReturnsAsync(ingredients);

        // Act
        var result = await _mockService.Object.GetAllIngredientsAsync();

        // Assert
        Assert.Equal(2, result.Count());
        Assert.Equal("Vodka", result.First().Name);
    }

    [Fact]
    public async Task GetIngredientByIdAsync_ReturnsIngredient_WhenIngredientExists()
    {
        // Arrange
        var ingredient = new IngredientDto { Id = 1, Name = "Vodka" };
        _mockService.Setup(s => s.GetIngredientByIdAsync(1))
            .ReturnsAsync(ingredient);

        // Act
        var result = await _mockService.Object.GetIngredientByIdAsync(1);

        // Assert
        Assert.NotNull(result);
        Assert.Equal("Vodka", result.Name);
    }

    [Fact]
    public async Task GetIngredientByIdAsync_ReturnsNull_WhenIngredientDoesNotExist()
    {
        // Arrange
        _mockService.Setup(s => s.GetIngredientByIdAsync(1))
            .ReturnsAsync((IngredientDto)null);

        // Act
        var result = await _mockService.Object.GetIngredientByIdAsync(1);

        // Assert
        Assert.Null(result);
    }

    [Fact]
    public async Task CreateIngredientAsync_AddsIngredientToDatabase()
    {
        // Arrange
        var ingredientDto = new IngredientDto { Name = "Vodka" };
        var createdIngredientDto = new IngredientDto { Id = 1, Name = "Vodka" };

        _mockService.Setup(s => s.CreateIngredientAsync(ingredientDto))
            .ReturnsAsync(createdIngredientDto);

        // Act
        var result = await _mockService.Object.CreateIngredientAsync(ingredientDto);

        // Assert
        Assert.NotNull(result);
        Assert.Equal("Vodka", result.Name);
        Assert.NotEqual(0, result.Id);
    }

    [Fact]
    public async Task UpdateIngredientAsync_ReturnsTrue_WhenIngredientIsUpdated()
    {
        // Arrange
        var ingredientDto = new IngredientDto { Id = 1, Name = "Vodka" };

        _mockService.Setup(s => s.UpdateIngredientAsync(ingredientDto))
            .ReturnsAsync(true);

        // Act
        var result = await _mockService.Object.UpdateIngredientAsync(ingredientDto);

        // Assert
        Assert.True(result);
    }

    [Fact]
    public async Task DeleteIngredientAsync_ReturnsTrue_WhenIngredientIsDeleted()
    {
        // Arrange
        _mockService.Setup(s => s.DeleteIngredientAsync(1))
            .ReturnsAsync(true);

        // Act
        var result = await _mockService.Object.DeleteIngredientAsync(1);

        // Assert
        Assert.True(result);
    }

    [Fact]
    public async Task DeleteIngredientAsync_ReturnsFalse_WhenIngredientDoesNotExist()
    {
        // Arrange
        _mockService.Setup(s => s.DeleteIngredientAsync(1))
            .ReturnsAsync(false);

        // Act
        var result = await _mockService.Object.DeleteIngredientAsync(1);

        // Assert
        Assert.False(result);
    }
}
