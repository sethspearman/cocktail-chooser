namespace CocktailChooser.Data.Repositories;

public class OcrImportItemRecord
{
    public int Id { get; set; }
    public int OcrImportId { get; set; }
    public string? ItemKey { get; set; }
    public string RawText { get; set; } = string.Empty;
    // TODO: Replace/augment with external object-storage reference for uploaded image/PDF blobs.
    public string? RawOcrJson { get; set; }
    // TODO: Apply retention cleanup for raw OCR JSON after review/publish lifecycle completes.
    public double? Confidence { get; set; }
    public string Status { get; set; } = "Pending";
    public string? CreatedUtc { get; set; }
}
