using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using CocktailChooser.Data.Repositories;
using Moq;

namespace CocktailChooser.Tests.Services;

public class CocktailServiceTests
{
    private readonly Mock<ICocktailRepository> _repositoryMock;
    private readonly Mock<IIngredientRepository> _ingredientRepositoryMock;
    private readonly Mock<ICocktailIngredientRepository> _cocktailIngredientRepositoryMock;
    private readonly Mock<ICocktailRecipeRepository> _cocktailRecipeRepositoryMock;
    private readonly Mock<IAmountRepository> _amountRepositoryMock;
    private readonly Mock<IOcrRecipeParser> _recipeParserMock;
    private readonly CocktailService _service;

    public CocktailServiceTests()
    {
        _repositoryMock = new Mock<ICocktailRepository>();
        _ingredientRepositoryMock = new Mock<IIngredientRepository>();
        _cocktailIngredientRepositoryMock = new Mock<ICocktailIngredientRepository>();
        _cocktailRecipeRepositoryMock = new Mock<ICocktailRecipeRepository>();
        _amountRepositoryMock = new Mock<IAmountRepository>();
        _recipeParserMock = new Mock<IOcrRecipeParser>();
        _service = new CocktailService(
            _repositoryMock.Object,
            _ingredientRepositoryMock.Object,
            _cocktailIngredientRepositoryMock.Object,
            _cocktailRecipeRepositoryMock.Object,
            _amountRepositoryMock.Object,
            _recipeParserMock.Object);
    }

    [Fact]
    public async Task GetCocktailByIdAsync_ReturnsNull_WhenNotFound()
    {
        _repositoryMock.Setup(r => r.GetByIdAsync(999))
            .ReturnsAsync((CocktailRecord?)null);

        var result = await _service.GetCocktailByIdAsync(999);

        Assert.Null(result);
    }

    [Fact]
    public async Task GetCocktailByIdAsync_MapsRepositoryRecordToDto()
    {
        _repositoryMock.Setup(r => r.GetByIdAsync(1))
            .ReturnsAsync(new CocktailRecord
            {
                Id = 1,
                Name = "Mojito",
                Method = "Build over ice",
                IsApproved = 1,
                CocktailSourceId = 2
            });

        var result = await _service.GetCocktailByIdAsync(1);

        Assert.NotNull(result);
        Assert.Equal(1, result.Id);
        Assert.Equal("Mojito", result.Name);
        Assert.Equal(2, result.CocktailSourceId);
    }

    [Fact]
    public async Task UpdateCocktailAsync_DelegatesToRepository()
    {
        var dto = new CocktailDto { Id = 10, Name = "Negroni" };
        _repositoryMock.Setup(r => r.UpdateAsync(It.IsAny<CocktailRecord>()))
            .ReturnsAsync(true);

        var updated = await _service.UpdateCocktailAsync(dto);

        Assert.True(updated);
        _repositoryMock.Verify(r => r.UpdateAsync(It.Is<CocktailRecord>(c =>
            c.Id == 10 && c.Name == "Negroni")), Times.Once);
    }

    [Fact]
    public async Task GetAllCocktailsAsync_AlcoholicFilter_ReturnsOnlyAlcoholicCocktails()
    {
        _repositoryMock.Setup(r => r.GetAllAsync())
            .ReturnsAsync(new List<CocktailRecord>
            {
                new() { Id = 1, Name = "Daiquiri", IsApproved = 1 },
                new() { Id = 2, Name = "Virgin Mule", IsApproved = 1 }
            });

        _cocktailIngredientRepositoryMock.Setup(r => r.GetAllAsync())
            .ReturnsAsync(new List<CocktailIngredientRecord>
            {
                new() { CocktailId = 1, IngredientId = 11, IngredientName = "White rum", PrimarySpirit = "Rum" },
                new() { CocktailId = 2, IngredientId = 22, IngredientName = "Ginger beer", PrimarySpirit = null }
            });

        var result = (await _service.GetAllCocktailsAsync(alcoholFilter: "alcoholic")).ToList();

        Assert.Single(result);
        Assert.Equal("Daiquiri", result[0].Name);
    }

    [Fact]
    public async Task GetAllCocktailsAsync_NonAlcoholicFilter_CombinesWithIngredientAllFilter()
    {
        _repositoryMock.Setup(r => r.GetAllAsync())
            .ReturnsAsync(new List<CocktailRecord>
            {
                new() { Id = 1, Name = "Daiquiri", IsApproved = 1 },
                new() { Id = 2, Name = "Virgin Mule", IsApproved = 1 },
                new() { Id = 3, Name = "Ginger Fizz", IsApproved = 1 }
            });

        _ingredientRepositoryMock.Setup(r => r.GetAllAsync())
            .ReturnsAsync(new List<IngredientRecord>
            {
                new() { Id = 1, Name = "White rum" },
                new() { Id = 2, Name = "Ginger beer" },
                new() { Id = 3, Name = "Lime juice" }
            });

        _cocktailIngredientRepositoryMock.Setup(r => r.GetAllAsync())
            .ReturnsAsync(new List<CocktailIngredientRecord>
            {
                new() { CocktailId = 1, IngredientId = 1, IngredientName = "White rum", PrimarySpirit = "Rum" },
                new() { CocktailId = 1, IngredientId = 3, IngredientName = "Lime juice" },
                new() { CocktailId = 2, IngredientId = 2, IngredientName = "Ginger beer" },
                new() { CocktailId = 2, IngredientId = 3, IngredientName = "Lime juice" },
                new() { CocktailId = 3, IngredientId = 2, IngredientName = "Ginger beer" }
            });

        var result = (await _service.GetAllCocktailsAsync(
            includeIngredientNames: new[] { "Ginger beer", "Lime juice" },
            includeMode: "all",
            alcoholFilter: "non-alcoholic")).ToList();

        Assert.Single(result);
        Assert.Equal("Virgin Mule", result[0].Name);
    }

    [Fact]
    public async Task PreviewFromTextAsync_ReturnsValidationErrors_WhenRequiredHeadersMissing()
    {
        var preview = await _service.PreviewFromTextAsync(new CocktailTextPreviewRequestDto
        {
            RawText = "Name: Broken Cocktail\nIngredients:\n- Gin"
        });

        Assert.False(preview.IsValid);
        Assert.Contains(preview.Errors, e => e.Contains("Missing required header: Description:", StringComparison.Ordinal));
        Assert.Contains(preview.Errors, e => e.Contains("Missing required header: Steps:", StringComparison.Ordinal));
    }

    [Fact]
    public async Task SubmitFromTextAsync_CreatesPendingUserSubmittedCocktail()
    {
        _ingredientRepositoryMock.Setup(r => r.GetAllAsync())
            .ReturnsAsync(new List<IngredientRecord>());
        _repositoryMock.Setup(r => r.GetTimePeriodsAsync())
            .ReturnsAsync(new List<LookupOptionRecord>());
        _amountRepositoryMock.Setup(r => r.GetAllAsync())
            .ReturnsAsync(new List<AmountRecord>());
        _recipeParserMock.Setup(r => r.Parse(It.IsAny<string>()))
            .Returns(new List<OcrParsedRecipeDraft>
            {
                new()
                {
                    Ingredients = new List<OcrParsedIngredientDraft>(),
                    Steps = new List<OcrParsedStepDraft>()
                }
            });
        _ingredientRepositoryMock.Setup(r => r.CreateAsync(It.IsAny<IngredientRecord>()))
            .ReturnsAsync((IngredientRecord input) => new IngredientRecord { Id = 77, Name = input.Name });
        _repositoryMock.Setup(r => r.CreateAsync(It.IsAny<CocktailRecord>()))
            .ReturnsAsync((CocktailRecord input) => new CocktailRecord
            {
                Id = 55,
                Name = input.Name,
                Description = input.Description,
                Method = input.Method,
                TimePeriodId = input.TimePeriodId,
                IsApproved = input.IsApproved,
                IsUserSubmitted = input.IsUserSubmitted,
                SubmittedByUserId = input.SubmittedByUserId,
                CocktailSourceId = input.CocktailSourceId
            });

        var result = await _service.SubmitFromTextAsync(new CocktailTextSubmitRequestDto
        {
            RawText = """
                Name: Test Submission
                Description: A pending cocktail
                Ingredients:
                - 2 oz gin
                Steps:
                1. Shake with ice
                """
        }, userId: 42);

        Assert.Equal("Test Submission", result.Name);
        Assert.Equal(0, result.IsApproved);
        Assert.Equal(1, result.IsUserSubmitted);
        Assert.Equal(42, result.SubmittedByUserId);
        _cocktailIngredientRepositoryMock.Verify(r => r.CreateAsync(It.IsAny<CocktailIngredientRecord>()), Times.AtLeastOnce);
    }
}
