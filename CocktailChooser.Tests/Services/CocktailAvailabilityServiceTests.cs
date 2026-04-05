using CocktailChooser.API.Services;
using CocktailChooser.Data.Repositories;
using Moq;

namespace CocktailChooser.Tests.Services;

public class CocktailAvailabilityServiceTests
{
    private readonly Mock<ICocktailRepository> _cocktailRepositoryMock = new();
    private readonly Mock<ICocktailIngredientRepository> _cocktailIngredientRepositoryMock = new();
    private readonly Mock<IUserIngredientRepository> _userIngredientRepositoryMock = new();
    private readonly Mock<IIngredientSubstitutionRepository> _ingredientSubstitutionRepositoryMock = new();
    private readonly CocktailAvailabilityService _service;

    public CocktailAvailabilityServiceTests()
    {
        _service = new CocktailAvailabilityService(
            _cocktailRepositoryMock.Object,
            _cocktailIngredientRepositoryMock.Object,
            _userIngredientRepositoryMock.Object,
            _ingredientSubstitutionRepositoryMock.Object);
    }

    [Fact]
    public async Task GetAvailabilityForUserAsync_ReturnsNull_WhenCocktailDoesNotExist()
    {
        _cocktailRepositoryMock.Setup(x => x.GetByIdAsync(77))
            .ReturnsAsync((CocktailRecord?)null);

        var result = await _service.GetAvailabilityForUserAsync(77, 12);

        Assert.Null(result);
    }

    [Fact]
    public async Task GetAvailabilityForUserAsync_ReturnsCanMake_WhenAllIngredientsAreStocked()
    {
        SeedCocktailIngredients();
        _userIngredientRepositoryMock.Setup(x => x.GetByUserIdAsync(4))
            .ReturnsAsync(new List<UserIngredientRecord>
            {
                new() { UserId = 4, IngredientId = 1, IngredientName = "Gin", IsInStock = 1 },
                new() { UserId = 4, IngredientId = 2, IngredientName = "Campari", IsInStock = 1 },
                new() { UserId = 4, IngredientId = 3, IngredientName = "Sweet Vermouth", IsInStock = 1 }
            });
        _ingredientSubstitutionRepositoryMock.Setup(x => x.GetByIngredientIdsAsync(It.IsAny<IEnumerable<int>>()))
            .ReturnsAsync(Array.Empty<IngredientSubstitutionRecord>());

        var result = await _service.GetAvailabilityForUserAsync(10, 4);

        Assert.NotNull(result);
        Assert.True(result!.CanMake);
        Assert.False(result.CanMakeWithSubstitution);
        Assert.Empty(result.MissingIngredients);
        Assert.Empty(result.SubstitutionsAvailable);
    }

    [Fact]
    public async Task GetAvailabilityForUserAsync_ReturnsSubstitutionSuggestions_WhenMissingIngredientHasStockedSubstitute()
    {
        SeedCocktailIngredients();
        _userIngredientRepositoryMock.Setup(x => x.GetByUserIdAsync(4))
            .ReturnsAsync(new List<UserIngredientRecord>
            {
                new() { UserId = 4, IngredientId = 1, IngredientName = "Gin", IsInStock = 1 },
                new() { UserId = 4, IngredientId = 3, IngredientName = "Sweet Vermouth", IsInStock = 1 },
                new() { UserId = 4, IngredientId = 8, IngredientName = "Aperol", IsInStock = 1 }
            });
        _ingredientSubstitutionRepositoryMock.Setup(x => x.GetByIngredientIdsAsync(It.Is<IEnumerable<int>>(ids => ids.SequenceEqual(new[] { 2 }))))
            .ReturnsAsync(new List<IngredientSubstitutionRecord>
            {
                new()
                {
                    IngredientId = 2,
                    IngredientName = "Campari",
                    SubstituteIngredientId = 8,
                    SubstituteIngredientName = "Aperol",
                    ConfidenceScore = 0.85,
                    Notes = "Classic lower-bitterness substitute."
                }
            });

        var result = await _service.GetAvailabilityForUserAsync(10, 4);

        Assert.NotNull(result);
        Assert.False(result!.CanMake);
        Assert.True(result.CanMakeWithSubstitution);
        Assert.Single(result.MissingIngredients);
        Assert.Equal("Campari", result.MissingIngredients[0].IngredientName);
        Assert.Single(result.SubstitutionsAvailable);
        Assert.Equal("Aperol", result.SubstitutionsAvailable[0].SubstituteIngredientName);
    }

    [Fact]
    public async Task GetAvailabilityForUserAsync_DoesNotMarkAsSubstitutable_WhenAnyMissingIngredientLacksAStockedSubstitute()
    {
        _cocktailRepositoryMock.Setup(x => x.GetByIdAsync(11))
            .ReturnsAsync(new CocktailRecord { Id = 11, Name = "Corpse Reviver #2", IsApproved = 1 });
        _cocktailIngredientRepositoryMock.Setup(x => x.GetByCocktailIdAsync(11))
            .ReturnsAsync(new List<CocktailIngredientRecord>
            {
                new() { CocktailId = 11, IngredientId = 4, IngredientName = "Cointreau" },
                new() { CocktailId = 11, IngredientId = 5, IngredientName = "Lillet Blanc" }
            });
        _userIngredientRepositoryMock.Setup(x => x.GetByUserIdAsync(4))
            .ReturnsAsync(new List<UserIngredientRecord>
            {
                new() { UserId = 4, IngredientId = 6, IngredientName = "Triple Sec", IsInStock = 1 }
            });
        _ingredientSubstitutionRepositoryMock.Setup(x => x.GetByIngredientIdsAsync(It.Is<IEnumerable<int>>(ids => ids.OrderBy(x => x).SequenceEqual(new[] { 4, 5 }))))
            .ReturnsAsync(new List<IngredientSubstitutionRecord>
            {
                new()
                {
                    IngredientId = 4,
                    IngredientName = "Cointreau",
                    SubstituteIngredientId = 6,
                    SubstituteIngredientName = "Triple Sec",
                    ConfidenceScore = 0.9
                }
            });

        var result = await _service.GetAvailabilityForUserAsync(11, 4);

        Assert.NotNull(result);
        Assert.False(result!.CanMake);
        Assert.False(result.CanMakeWithSubstitution);
        Assert.Equal(2, result.MissingIngredients.Count);
        Assert.Single(result.SubstitutionsAvailable);
    }

    private void SeedCocktailIngredients()
    {
        _cocktailRepositoryMock.Setup(x => x.GetByIdAsync(10))
            .ReturnsAsync(new CocktailRecord { Id = 10, Name = "Negroni", IsApproved = 1 });
        _cocktailIngredientRepositoryMock.Setup(x => x.GetByCocktailIdAsync(10))
            .ReturnsAsync(new List<CocktailIngredientRecord>
            {
                new() { CocktailId = 10, IngredientId = 1, IngredientName = "Gin" },
                new() { CocktailId = 10, IngredientId = 2, IngredientName = "Campari" },
                new() { CocktailId = 10, IngredientId = 3, IngredientName = "Sweet Vermouth" }
            });
    }
}
