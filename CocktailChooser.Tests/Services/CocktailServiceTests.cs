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
    private readonly Mock<IRecipeSourceRepository> _recipeSourceRepositoryMock;
    private readonly Mock<ICocktailTagRepository> _cocktailTagRepositoryMock;
    private readonly Mock<IOcrRecipeParser> _recipeParserMock;
    private readonly CocktailService _service;

    public CocktailServiceTests()
    {
        _repositoryMock = new Mock<ICocktailRepository>();
        _ingredientRepositoryMock = new Mock<IIngredientRepository>();
        _cocktailIngredientRepositoryMock = new Mock<ICocktailIngredientRepository>();
        _cocktailRecipeRepositoryMock = new Mock<ICocktailRecipeRepository>();
        _amountRepositoryMock = new Mock<IAmountRepository>();
        _recipeSourceRepositoryMock = new Mock<IRecipeSourceRepository>();
        _cocktailTagRepositoryMock = new Mock<ICocktailTagRepository>();
        _recipeParserMock = new Mock<IOcrRecipeParser>();
        _repositoryMock.Setup(r => r.IsCanonicalKeyInUseAsync(It.IsAny<string>(), It.IsAny<int?>()))
            .ReturnsAsync(false);
        _cocktailTagRepositoryMock.Setup(r => r.GetCocktailTagsByCocktailIdsAsync(It.IsAny<IEnumerable<int>>()))
            .ReturnsAsync(new Dictionary<int, List<CocktailTagRecord>>());
        _cocktailTagRepositoryMock.Setup(r => r.GetCocktailIdsForTagsAsync(It.IsAny<IEnumerable<string>>(), It.IsAny<bool>()))
            .ReturnsAsync(new HashSet<int>());
        _service = new CocktailService(
            _repositoryMock.Object,
            _ingredientRepositoryMock.Object,
            _cocktailIngredientRepositoryMock.Object,
            _cocktailRecipeRepositoryMock.Object,
            _amountRepositoryMock.Object,
            _recipeSourceRepositoryMock.Object,
            _cocktailTagRepositoryMock.Object,
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
        _repositoryMock.Setup(r => r.GetByIdAsync(10))
            .ReturnsAsync(new CocktailRecord
            {
                Id = 10,
                Name = "Negroni",
                IsApproved = 1
            });
        _repositoryMock.Setup(r => r.UpdateAsync(It.IsAny<CocktailRecord>()))
            .ReturnsAsync(true);

        var updated = await _service.UpdateCocktailAsync(dto);

        Assert.True(updated);
        _repositoryMock.Verify(r => r.UpdateAsync(It.Is<CocktailRecord>(c =>
            c.Id == 10 && c.Name == "Negroni" && c.CanonicalKey == "manual::negroni")), Times.Once);
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
    public async Task GetAllCocktailsAsync_TagFilter_ReturnsOnlyMatchingTaggedCocktails()
    {
        _repositoryMock.Setup(r => r.GetAllAsync())
            .ReturnsAsync(new List<CocktailRecord>
            {
                new() { Id = 1, Name = "Negroni", IsApproved = 1 },
                new() { Id = 2, Name = "Daiquiri", IsApproved = 1 }
            });

        _cocktailTagRepositoryMock.Setup(r => r.GetCocktailIdsForTagsAsync(
                It.Is<IEnumerable<string>>(x => x.SequenceEqual(new[] { "bitter", "stirred" })),
                true))
            .ReturnsAsync(new HashSet<int> { 1 });
        _cocktailTagRepositoryMock.Setup(r => r.GetCocktailTagsByCocktailIdsAsync(It.IsAny<IEnumerable<int>>()))
            .ReturnsAsync(new Dictionary<int, List<CocktailTagRecord>>
            {
                [1] = new List<CocktailTagRecord>
                {
                    new() { CocktailId = 1, TagId = 10, TagTypeId = 1, TagTypeName = "Flavor Profile", TagName = "Bitter", TagNormalizedName = "bitter", CreatedUtc = "2026-03-13T00:00:00Z" },
                    new() { CocktailId = 1, TagId = 20, TagTypeId = 7, TagTypeName = "Build Method", TagName = "Stirred", TagNormalizedName = "stirred", CreatedUtc = "2026-03-13T00:00:00Z" }
                }
            });

        var result = (await _service.GetAllCocktailsAsync(tags: new[] { "bitter", "stirred" })).ToList();

        Assert.Single(result);
        Assert.Equal("Negroni", result[0].Name);
        Assert.Equal(2, result[0].Tags!.Count);
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

    [Fact]
    public async Task SubmitFromTextAsync_AutoApproves_WhenSubmittedByAdminUser()
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
            .ReturnsAsync((IngredientRecord input) => new IngredientRecord { Id = 78, Name = input.Name });
        _repositoryMock.Setup(r => r.CreateAsync(It.IsAny<CocktailRecord>()))
            .ReturnsAsync((CocktailRecord input) => new CocktailRecord
            {
                Id = 56,
                Name = input.Name,
                Description = input.Description,
                Method = input.Method,
                TimePeriodId = input.TimePeriodId,
                IsApproved = input.IsApproved,
                ApprovedUtc = input.ApprovedUtc,
                ApprovedByUserId = input.ApprovedByUserId,
                IsUserSubmitted = input.IsUserSubmitted,
                SubmittedByUserId = input.SubmittedByUserId,
                CocktailSourceId = input.CocktailSourceId
            });

        var result = await _service.SubmitFromTextAsync(new CocktailTextSubmitRequestDto
        {
            RawText = """
                Name: Admin Submission
                Description: Should auto approve
                Ingredients:
                - 2 oz gin
                Steps:
                1. Shake with ice
                """
        }, userId: 1);

        Assert.Equal("Admin Submission", result.Name);
        Assert.Equal(1, result.IsApproved);
        Assert.False(string.IsNullOrWhiteSpace(result.ApprovedUtc));
        Assert.Equal(1, result.ApprovedByUserId);
        Assert.Equal(1, result.IsUserSubmitted);
        Assert.Equal(1, result.SubmittedByUserId);
    }

    [Fact]
    public async Task CreateCocktailAsync_AutoApproves_WhenCreatedByAdminUser()
    {
        _repositoryMock.Setup(r => r.CreateAsync(It.IsAny<CocktailRecord>()))
            .ReturnsAsync((CocktailRecord input) => new CocktailRecord
            {
                Id = 81,
                Name = input.Name,
                CanonicalKey = input.CanonicalKey,
                IsApproved = input.IsApproved,
                ApprovedUtc = input.ApprovedUtc,
                ApprovedByUserId = input.ApprovedByUserId,
                RejectedUtc = input.RejectedUtc
            });

        var result = await _service.CreateCocktailAsync(new CocktailDto
        {
            Name = "Admin Entered"
        }, createdByUserId: 1);

        Assert.Equal("Admin Entered", result.Name);
        Assert.Equal(1, result.IsApproved);
        Assert.False(string.IsNullOrWhiteSpace(result.ApprovedUtc));
        Assert.Equal(1, result.ApprovedByUserId);
        Assert.Equal("approved", result.ModerationStatus);
    }

    [Fact]
    public async Task CreateCocktailAsync_StoresCanonicalAmountAndOriginalText_ForStructuredAmountText()
    {
        _repositoryMock.Setup(r => r.CreateAsync(It.IsAny<CocktailRecord>()))
            .ReturnsAsync(new CocktailRecord
            {
                Id = 99,
                Name = "Canonical Amount Test",
                IsApproved = 1
            });
        _ingredientRepositoryMock.Setup(r => r.GetAllAsync())
            .ReturnsAsync(new List<IngredientRecord>
            {
                new() { Id = 7, Name = "Gin" }
            });
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

        await _service.CreateCocktailAsync(new CocktailDto
        {
            Name = "Canonical Amount Test",
            StructuredIngredients = new List<CocktailIngredientEntryDto>
            {
                new()
                {
                    IngredientName = "Gin",
                    AmountText = "1.5 oz"
                }
            }
        });

        _cocktailIngredientRepositoryMock.Verify(
            r => r.CreateAsync(It.Is<CocktailIngredientRecord>(x =>
                x.AmountText == "1.5 oz"
                && x.AmountOriginalText == "1.5 oz"
                && x.CanonicalAmountValue == 1.5
                && x.CanonicalAmountUnit == "oz")),
            Times.Once);
    }
}
