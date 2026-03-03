namespace CocktailChooser.API.DTOs;

public class AdminCocktailPortDto
{
    public int? CocktailId { get; set; }
    public string? CanonicalKey { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string? Method { get; set; }
    public int? GlassTypeId { get; set; }
    public int? TimePeriodId { get; set; }
    public int? IsPopular { get; set; }
    public int? IsApproved { get; set; }
    public int? IsUserSubmitted { get; set; }
    public int? SubmittedByUserId { get; set; }
    public int? CocktailSourceId { get; set; }
    public List<CocktailIngredientEntryDto> StructuredIngredients { get; set; } = new();
    public List<CocktailStepEntryDto> StructuredSteps { get; set; } = new();
}

public class AdminCocktailImportRequestDto
{
    public List<AdminCocktailPortDto> Cocktails { get; set; } = new();
}

public class AdminCocktailImportItemResultDto
{
    public int InputIndex { get; set; }
    public int? CocktailId { get; set; }
    public string? CanonicalKey { get; set; }
    public string Action { get; set; } = string.Empty;
    public string? Error { get; set; }
}

public class AdminCocktailImportResultDto
{
    public int Created { get; set; }
    public int Updated { get; set; }
    public int Failed { get; set; }
    public List<AdminCocktailImportItemResultDto> Items { get; set; } = new();
}
