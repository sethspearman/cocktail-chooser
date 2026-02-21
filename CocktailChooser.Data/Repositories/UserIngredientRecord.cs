namespace CocktailChooser.Data.Repositories;

public class UserIngredientRecord
{
    public int UserId { get; set; }
    public int IngredientId { get; set; }
    public string IngredientName { get; set; } = string.Empty;
    public int IsInStock { get; set; }
    public string? Notes { get; set; }
    public string? UpdatedUtc { get; set; }
}
