namespace CocktailChooser.API.DTOs;

public class OcrImportCreateDto
{
    public int RecipeSourceId { get; set; }
    public string ImportName { get; set; } = null!;
    public string ImportType { get; set; } = null!;
    public string? FileName { get; set; }
    public string? Notes { get; set; }
}
