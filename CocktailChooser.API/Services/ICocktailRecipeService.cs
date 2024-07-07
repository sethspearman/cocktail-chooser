using CocktailChooser.API.DTOs;

namespace CocktailChooser.API.Services
{
    public interface ICocktailRecipeService
    {
        Task<IEnumerable<CocktailRecipeDto>> GetAllCocktailRecipesAsync();
        Task<IEnumerable<CocktailRecipeDto>> GetCocktailRecipesByCocktailIdAsync(int cocktailId);
        Task<CocktailRecipeDto> CreateCocktailRecipeAsync(CocktailRecipeDto cocktailRecipeDto);
        Task<bool> UpdateCocktailRecipeAsync(CocktailRecipeDto cocktailRecipeDto);
        Task<bool> DeleteCocktailRecipeAsync(int cocktailId, int stepNumber);
    }
}