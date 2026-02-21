using CocktailChooser.API.DTOs;

namespace CocktailChooser.API.Services;

public interface ICocktailIngredientService
{
    Task<IEnumerable<CocktailIngredientDto>> GetAllCocktailIngredientsAsync();
    Task<IEnumerable<CocktailIngredientDto>> GetCocktailIngredientsByCocktailIdAsync(int cocktailId);
}
