using CocktailChooser.API.DTOs;

namespace CocktailChooser.API.Services
{
    public interface IIngredientService
    {
        Task<IEnumerable<IngredientDto>> GetAllIngredientsAsync();
        Task<IngredientDto?> GetIngredientByIdAsync(int id);
        Task<IngredientDto> CreateIngredientAsync(IngredientDto ingredientDto);
        Task<bool> UpdateIngredientAsync(IngredientDto ingredientDto);
        Task<bool> DeleteIngredientAsync(int id);
    }
}
