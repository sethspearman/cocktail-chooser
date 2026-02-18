using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using CocktailChooser.Data.Repositories;
using Moq;

public class CocktailRecipeServiceTests
{
    private readonly Mock<ICocktailRecipeRepository> _repositoryMock;
    private readonly CocktailRecipeService _service;

    public CocktailRecipeServiceTests()
    {
        _repositoryMock = new Mock<ICocktailRecipeRepository>();
        _service = new CocktailRecipeService(_repositoryMock.Object);
    }

    [Fact]
    public async Task GetCocktailRecipeByIdAsync_ReturnsNull_WhenMissing()
    {
        _repositoryMock.Setup(r => r.GetByIdAsync(1, 2))
            .ReturnsAsync((CocktailRecipeRecord?)null);

        var result = await _service.GetCocktailRecipeByIdAsync(1, 2);

        Assert.Null(result);
    }

    [Fact]
    public async Task GetCocktailRecipesByCocktailIdAsync_ReturnsMappedDtos()
    {
        _repositoryMock.Setup(r => r.GetByCocktailIdAsync(5))
            .ReturnsAsync(new[]
            {
                new CocktailRecipeRecord { CocktailId = 5, StepNumber = 1, Instruction = "Add ice" },
                new CocktailRecipeRecord { CocktailId = 5, StepNumber = 2, Instruction = "Stir" }
            });

        var result = (await _service.GetCocktailRecipesByCocktailIdAsync(5)).ToList();

        Assert.Equal(2, result.Count);
        Assert.Equal("Add ice", result[0].Instruction);
    }

    [Fact]
    public async Task DeleteCocktailRecipeAsync_DelegatesToRepository()
    {
        _repositoryMock.Setup(r => r.DeleteAsync(2, 3))
            .ReturnsAsync(true);

        var deleted = await _service.DeleteCocktailRecipeAsync(2, 3);

        Assert.True(deleted);
        _repositoryMock.Verify(r => r.DeleteAsync(2, 3), Times.Once);
    }
}
