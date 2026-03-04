namespace CocktailChooser.Data.Repositories;

public class AdminCocktailImportRecord
{
    public int? CocktailId { get; set; }
    public string? CanonicalKey { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string? Method { get; set; }
    public int? GlassTypeId { get; set; }
    public int? TimePeriodId { get; set; }
    public int? IsPopular { get; set; }
    public int? IsApproved { get; set; }
    public string? ApprovedUtc { get; set; }
    public int? ApprovedByUserId { get; set; }
    public string? RejectedUtc { get; set; }
    public int? IsUserSubmitted { get; set; }
    public int? SubmittedByUserId { get; set; }
    public int? CocktailSourceId { get; set; }
    public List<AdminCocktailImportIngredientRecord> Ingredients { get; set; } = new();
    public List<AdminCocktailImportStepRecord> Steps { get; set; } = new();
}

public class AdminCocktailImportIngredientRecord
{
    public int? AmountId { get; set; }
    public string? AmountText { get; set; }
    public string IngredientName { get; set; } = string.Empty;
}

public class AdminCocktailImportStepRecord
{
    public string Instruction { get; set; } = string.Empty;
}
