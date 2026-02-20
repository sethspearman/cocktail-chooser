namespace CocktailChooser.Data.Repositories;

public class RecipeRecord
{
    public int Id { get; set; }
    public int CocktailId { get; set; }
    public int RecipeSourceId { get; set; }
    public string? SourceRecipeName { get; set; }
    public string? AttributionText { get; set; }
    public string? SourceUrl { get; set; }
    public string? Method { get; set; }
    public string? FlavorProfile { get; set; }
    public string? Notes { get; set; }
    public int IsUserSubmitted { get; set; }
    public string? CreatedUtc { get; set; }
    public string? UpdatedUtc { get; set; }
}
