using CocktailChooser.API.DTOs;

namespace CocktailChooser.API.Services
{
    public interface IRecipeService
    {
        Task<IEnumerable<RecipeDto>> GetAllRecipesAsync();
        Task<RecipeDto?> GetRecipeByIdAsync(int id);
        Task<IEnumerable<RecipeDto>> GetRecipesByCocktailIdAsync(int cocktailId);
        Task<IEnumerable<RecipeDto>> GetRecipesBySourceIdAsync(int recipeSourceId);
        Task<IEnumerable<RecipeDto>> SearchRecipesAsync(int? cocktailId, int? recipeSourceId);
        Task<RecipeDto> CreateRecipeAsync(RecipeDto recipeDto);
        Task<bool> UpdateRecipeAsync(RecipeDto recipeDto);
        Task<bool> DeleteRecipeAsync(int id);
    }
}
