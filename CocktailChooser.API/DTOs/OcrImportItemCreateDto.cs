namespace CocktailChooser.API.DTOs;

public class OcrImportItemCreateDto
{
    public string? ItemKey { get; set; }
    public string RawText { get; set; } = null!;
    public string? RawOcrJson { get; set; }
    public double? Confidence { get; set; }
}
