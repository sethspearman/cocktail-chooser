namespace CocktailChooser.API.DTOs;

public class CocktailTextPreviewRequestDto
{
    public string RawText { get; set; } = string.Empty;
}

public class CocktailTextSubmitRequestDto
{
    public string RawText { get; set; } = string.Empty;
    public int? CocktailSourceId { get; set; }
    public int? TimePeriodIdOverride { get; set; }
}

public class CocktailTextIngredientPreviewDto
{
    public string Name { get; set; } = string.Empty;
    public bool IsNew { get; set; }
}

public class CocktailTextPreviewResponseDto
{
    public string? Name { get; set; }
    public string? Description { get; set; }
    public string? FlavorProfile { get; set; }
    public string? TimePeriodName { get; set; }
    public int? MatchedTimePeriodId { get; set; }
    public List<CocktailTextIngredientPreviewDto> Ingredients { get; set; } = new();
    public List<string> Steps { get; set; } = new();
    public List<string> Errors { get; set; } = new();
    public bool IsValid => Errors.Count == 0;
}
