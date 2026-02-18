namespace CocktailChooser.Data.Repositories;

public interface IIngredientRepository
{
    Task<IEnumerable<IngredientRecord>> GetAllAsync();
    Task<IngredientRecord?> GetByIdAsync(int id);
    Task<IngredientRecord> CreateAsync(IngredientRecord ingredient);
    Task<bool> UpdateAsync(IngredientRecord ingredient);
    Task<bool> DeleteAsync(int id);
}
