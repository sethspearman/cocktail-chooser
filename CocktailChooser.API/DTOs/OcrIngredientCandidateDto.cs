namespace CocktailChooser.API.DTOs;

public class OcrIngredientCandidateDto
{
    public int Id { get; set; }
    public int OcrRecipeCandidateId { get; set; }
    public int SortOrder { get; set; }
    public string RawLine { get; set; } = null!;
    public string? RawAmount { get; set; }
    public string? RawIngredientName { get; set; }
    public int? NormalizedAmountId { get; set; }
    public int? NormalizedIngredientId { get; set; }
    public double? Confidence { get; set; }
    public string? ParseWarnings { get; set; }
    public string? CreatedUtc { get; set; }
}
