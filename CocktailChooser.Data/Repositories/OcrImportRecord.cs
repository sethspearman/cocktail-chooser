namespace CocktailChooser.Data.Repositories;

public class OcrImportRecord
{
    public int Id { get; set; }
    public int RecipeSourceId { get; set; }
    public string ImportName { get; set; } = string.Empty;
    public string ImportType { get; set; } = string.Empty;
    public string? FileName { get; set; }
    public string Status { get; set; } = "Pending";
    public string? Notes { get; set; }
    public string? CreatedUtc { get; set; }
    public string? CompletedUtc { get; set; }
}
