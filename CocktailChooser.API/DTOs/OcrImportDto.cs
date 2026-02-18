namespace CocktailChooser.API.DTOs;

public class OcrImportDto
{
    public int Id { get; set; }
    public int RecipeSourceId { get; set; }
    public string ImportName { get; set; } = null!;
    public string ImportType { get; set; } = null!;
    public string? FileName { get; set; }
    public string Status { get; set; } = null!;
    public string? Notes { get; set; }
    public string? CreatedUtc { get; set; }
    public string? CompletedUtc { get; set; }
    public List<OcrImportItemDto> Items { get; set; } = new();
}
