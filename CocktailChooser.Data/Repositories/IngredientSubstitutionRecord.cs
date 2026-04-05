namespace CocktailChooser.Data.Repositories;

public class IngredientSubstitutionRecord
{
    public int Id { get; set; }
    public int IngredientId { get; set; }
    public string IngredientName { get; set; } = string.Empty;
    public int SubstituteIngredientId { get; set; }
    public string SubstituteIngredientName { get; set; } = string.Empty;
    public double? ConfidenceScore { get; set; }
    public string? Notes { get; set; }
    public string? CreatedUtc { get; set; }
}
