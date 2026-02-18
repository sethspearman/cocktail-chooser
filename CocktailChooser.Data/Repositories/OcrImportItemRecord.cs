namespace CocktailChooser.Data.Repositories;

public class OcrImportItemRecord
{
    public int Id { get; set; }
    public int OcrImportId { get; set; }
    public string? ItemKey { get; set; }
    public string RawText { get; set; } = string.Empty;
    public string? RawOcrJson { get; set; }
    public double? Confidence { get; set; }
    public string Status { get; set; } = "Pending";
    public string? CreatedUtc { get; set; }
}
