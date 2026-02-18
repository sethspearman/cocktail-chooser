namespace CocktailChooser.Data.Repositories;

public interface IRecipeSourceRepository
{
    Task<IEnumerable<RecipeSourceRecord>> GetAllAsync();
    Task<RecipeSourceRecord?> GetByIdAsync(int id);
    Task<bool> IsInUseAsync(int id);
    Task<RecipeSourceRecord> CreateAsync(RecipeSourceRecord source);
    Task<bool> UpdateAsync(RecipeSourceRecord source);
    Task<bool> DeleteAsync(int id);
}
