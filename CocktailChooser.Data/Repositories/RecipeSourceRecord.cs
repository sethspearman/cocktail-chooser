namespace CocktailChooser.Data.Repositories;

public class RecipeSourceRecord
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string SourceType { get; set; } = string.Empty;
    public string? CopyrightCredit { get; set; }
    public string? Url { get; set; }
    public string? Notes { get; set; }
    public int IsBuiltIn { get; set; }
    public string? CreatedUtc { get; set; }
}
