namespace CocktailChooser.API.DTOs;

public class OcrRecipeCandidateDto
{
    public int Id { get; set; }
    public int OcrImportItemId { get; set; }
    public string CocktailName { get; set; } = null!;
    public string? SourceRecipeName { get; set; }
    public string? MethodText { get; set; }
    public string? ParserVersion { get; set; }
    public double? Confidence { get; set; }
    public string Status { get; set; } = null!;
    public string? ParseWarnings { get; set; }
    public string? CreatedUtc { get; set; }
    public List<OcrIngredientCandidateDto> Ingredients { get; set; } = new();
    public List<OcrStepCandidateDto> Steps { get; set; } = new();
}
