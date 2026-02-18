namespace CocktailChooser.Data.Repositories;

public class OcrRecipeCandidateRecord
{
    public int Id { get; set; }
    public int OcrImportItemId { get; set; }
    public string CocktailName { get; set; } = string.Empty;
    public string? SourceRecipeName { get; set; }
    public string? MethodText { get; set; }
    public string? ParserVersion { get; set; }
    public double? Confidence { get; set; }
    public string Status { get; set; } = "Pending";
    public string? ParseWarnings { get; set; }
    public string? CreatedUtc { get; set; }
}
