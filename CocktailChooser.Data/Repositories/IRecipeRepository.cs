namespace CocktailChooser.Data.Repositories;

public interface IRecipeRepository
{
    Task<IEnumerable<RecipeRecord>> GetAllAsync();
    Task<RecipeRecord?> GetByIdAsync(int id);
    Task<IEnumerable<RecipeRecord>> GetByCocktailIdAsync(int cocktailId);
    Task<IEnumerable<RecipeRecord>> GetBySourceIdAsync(int recipeSourceId);
    Task<IEnumerable<RecipeRecord>> SearchAsync(int? cocktailId, int? recipeSourceId);
    Task<RecipeRecord> CreateAsync(RecipeRecord recipe);
    Task<bool> UpdateAsync(RecipeRecord recipe);
    Task<bool> DeleteAsync(int id);
}
