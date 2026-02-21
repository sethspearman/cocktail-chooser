namespace CocktailChooser.API.DTOs;

public class UserIngredientDto
{
    public int UserId { get; set; }
    public int IngredientId { get; set; }
    public string IngredientName { get; set; } = string.Empty;
    public bool IsInStock { get; set; }
    public string? Notes { get; set; }
    public string? UpdatedUtc { get; set; }
}
