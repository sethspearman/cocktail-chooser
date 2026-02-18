namespace CocktailChooser.Data.Repositories;

public interface ICocktailRecipeRepository
{
    Task<IEnumerable<CocktailRecipeRecord>> GetAllAsync();
    Task<IEnumerable<CocktailRecipeRecord>> GetByCocktailIdAsync(int cocktailId);
    Task<CocktailRecipeRecord?> GetByIdAsync(int cocktailId, int stepNumber);
    Task<CocktailRecipeRecord> CreateAsync(CocktailRecipeRecord recipe);
    Task<bool> UpdateAsync(CocktailRecipeRecord recipe);
    Task<bool> DeleteAsync(int cocktailId, int stepNumber);
}
