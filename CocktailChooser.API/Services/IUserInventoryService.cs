using CocktailChooser.API.DTOs;

namespace CocktailChooser.API.Services;

public interface IUserInventoryService
{
    Task<IEnumerable<UserIngredientDto>> GetUserInventoryAsync(int userId);
    Task<UserIngredientDto> UpsertInventoryItemAsync(int userId, int ingredientId, UserIngredientUpsertDto upsertDto);
    Task<bool> DeleteInventoryItemAsync(int userId, int ingredientId);
}
