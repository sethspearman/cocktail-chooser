namespace CocktailChooser.API.DTOs;

public class CocktailIngredientDto
{
    public int Id { get; set; }
    public int CocktailId { get; set; }
    public int IngredientId { get; set; }
    public string IngredientName { get; set; } = string.Empty;
    public string? PrimarySpirit { get; set; }
    public int? AmountId { get; set; }
    public string? AmountName { get; set; }
    public string? AmountText { get; set; }
    public double? CanonicalAmountValue { get; set; }
    public string? CanonicalAmountUnit { get; set; }
    public string? AmountOriginalText { get; set; }
    public string? DisplayAmount { get; set; }
    public int? SortOrder { get; set; }
}
