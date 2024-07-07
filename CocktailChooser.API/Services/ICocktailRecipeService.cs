using System.Collections.Generic;
using System.Threading.Tasks;
using CocktailChooser.API.DTOs;

public interface ICocktailRecipeService
{
    Task<IEnumerable<CocktailRecipeDto>> GetAllCocktailRecipesAsync();
    Task<IEnumerable<CocktailRecipeDto>> GetCocktailRecipesByCocktailIdAsync(int cocktailId);
    Task<CocktailRecipeDto> GetCocktailRecipeByIdAsync(int cocktailId, int stepNumber);
    Task<CocktailRecipeDto> CreateCocktailRecipeAsync(CocktailRecipeDto cocktailRecipeDto);
    Task<bool> UpdateCocktailRecipeAsync(CocktailRecipeDto cocktailRecipeDto);
    Task<bool> DeleteCocktailRecipeAsync(int cocktailId, int stepNumber);
}