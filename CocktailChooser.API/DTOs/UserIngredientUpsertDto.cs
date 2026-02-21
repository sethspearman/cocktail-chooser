namespace CocktailChooser.API.DTOs;

public class UserIngredientUpsertDto
{
    public bool IsInStock { get; set; } = true;
    public string? Notes { get; set; }
}
