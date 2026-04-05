namespace CocktailChooser.API.DTOs;

public class CocktailAvailabilityIngredientDto
{
    public int IngredientId { get; set; }
    public string IngredientName { get; set; } = string.Empty;
}

public class CocktailSubstitutionSuggestionDto
{
    public int MissingIngredientId { get; set; }
    public string MissingIngredientName { get; set; } = string.Empty;
    public int SubstituteIngredientId { get; set; }
    public string SubstituteIngredientName { get; set; } = string.Empty;
    public double? ConfidenceScore { get; set; }
    public string? Notes { get; set; }
}

public class CocktailAvailabilityDto
{
    public int CocktailId { get; set; }
    public bool CanMake { get; set; }
    public bool CanMakeWithSubstitution { get; set; }
    public List<CocktailAvailabilityIngredientDto> MissingIngredients { get; set; } = new();
    public List<CocktailSubstitutionSuggestionDto> SubstitutionsAvailable { get; set; } = new();
}
