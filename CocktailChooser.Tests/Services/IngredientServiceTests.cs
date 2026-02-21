using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using CocktailChooser.Data.Repositories;
using Moq;

namespace CocktailChooser.Tests.Services;

public class IngredientServiceTests
{
    private readonly Mock<IIngredientRepository> _repositoryMock;
    private readonly IngredientService _service;

    public IngredientServiceTests()
    {
        _repositoryMock = new Mock<IIngredientRepository>();
        _service = new IngredientService(_repositoryMock.Object);
    }

    [Fact]
    public async Task GetIngredientByIdAsync_ReturnsNull_WhenMissing()
    {
        _repositoryMock.Setup(r => r.GetByIdAsync(404))
            .ReturnsAsync((IngredientRecord?)null);

        var result = await _service.GetIngredientByIdAsync(404);

        Assert.Null(result);
    }

    [Fact]
    public async Task CreateIngredientAsync_ReturnsMappedDto()
    {
        _repositoryMock.Setup(r => r.CreateAsync(It.IsAny<IngredientRecord>()))
            .ReturnsAsync(new IngredientRecord
            {
                Id = 7,
                Name = "Lime Juice",
                IngredientTypeId = 2,
                PrimarySpirit = "Rum"
            });

        var result = await _service.CreateIngredientAsync(new IngredientDto { Name = "Lime Juice" });

        Assert.Equal(7, result.Id);
        Assert.Equal("Lime Juice", result.Name);
        Assert.Equal(2, result.IngredientTypeId);
        Assert.Equal("Rum", result.PrimarySpirit);
    }

    [Fact]
    public async Task UpdateIngredientAsync_DelegatesToRepository()
    {
        _repositoryMock.Setup(r => r.UpdateAsync(It.IsAny<IngredientRecord>()))
            .ReturnsAsync(true);

        var updated = await _service.UpdateIngredientAsync(new IngredientDto { Id = 3, Name = "Gin" });

        Assert.True(updated);
        _repositoryMock.Verify(r => r.UpdateAsync(It.Is<IngredientRecord>(i => i.Id == 3 && i.Name == "Gin")), Times.Once);
    }
}
