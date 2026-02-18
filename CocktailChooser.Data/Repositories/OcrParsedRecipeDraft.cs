namespace CocktailChooser.Data.Repositories;

public class OcrParsedRecipeDraft
{
    public string CocktailName { get; set; } = string.Empty;
    public string? SourceRecipeName { get; set; }
    public string? MethodText { get; set; }
    public string? ParserVersion { get; set; }
    public double? Confidence { get; set; }
    public string? ParseWarnings { get; set; }
    public List<OcrParsedIngredientDraft> Ingredients { get; set; } = new();
    public List<OcrParsedStepDraft> Steps { get; set; } = new();
}

public class OcrParsedIngredientDraft
{
    public int SortOrder { get; set; }
    public string RawLine { get; set; } = string.Empty;
    public string? RawAmount { get; set; }
    public string? RawIngredientName { get; set; }
    public double? Confidence { get; set; }
    public string? ParseWarnings { get; set; }
}

public class OcrParsedStepDraft
{
    public int StepNumber { get; set; }
    public string Instruction { get; set; } = string.Empty;
    public double? Confidence { get; set; }
}
