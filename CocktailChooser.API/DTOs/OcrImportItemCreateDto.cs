namespace CocktailChooser.API.DTOs;

public class OcrImportItemCreateDto
{
    public string? ItemKey { get; set; }
    public string RawText { get; set; } = null!;
    // TODO: Add StorageObjectKey/StorageUrl for original OCR media once external file storage is introduced.
    public string? RawOcrJson { get; set; }
    public double? Confidence { get; set; }
}
