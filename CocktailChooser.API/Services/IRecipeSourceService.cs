using CocktailChooser.API.DTOs;

namespace CocktailChooser.API.Services
{
    public interface IRecipeSourceService
    {
        Task<IEnumerable<RecipeSourceDto>> GetAllRecipeSourcesAsync();
        Task<RecipeSourceDto?> GetRecipeSourceByIdAsync(int id);
        Task<bool> IsRecipeSourceInUseAsync(int id);
        Task<RecipeSourceDto> CreateRecipeSourceAsync(RecipeSourceDto sourceDto);
        Task<bool> UpdateRecipeSourceAsync(RecipeSourceDto sourceDto);
        Task<bool> DeleteRecipeSourceAsync(int id);
    }
}
