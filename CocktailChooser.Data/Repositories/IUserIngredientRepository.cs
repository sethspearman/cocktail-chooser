namespace CocktailChooser.Data.Repositories;

public interface IUserIngredientRepository
{
    Task<IEnumerable<UserIngredientRecord>> GetByUserIdAsync(int userId);
    Task<UserIngredientRecord> UpsertAsync(int userId, int ingredientId, int isInStock, string? notes, string updatedUtc);
    Task<bool> DeleteAsync(int userId, int ingredientId);
}
