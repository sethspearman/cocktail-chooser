namespace CocktailChooser.API.DTOs;

public class OcrImportItemDto
{
    public int Id { get; set; }
    public int OcrImportId { get; set; }
    public string? ItemKey { get; set; }
    public string RawText { get; set; } = null!;
    public string? RawOcrJson { get; set; }
    public double? Confidence { get; set; }
    public string Status { get; set; } = null!;
    public string? CreatedUtc { get; set; }
}
