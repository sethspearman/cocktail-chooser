namespace CocktailChooser.Data.Repositories;

public interface ICocktailIngredientRepository
{
    Task<IEnumerable<CocktailIngredientRecord>> GetAllAsync();
    Task<IEnumerable<CocktailIngredientRecord>> GetByCocktailIdAsync(int cocktailId);
    Task<CocktailIngredientRecord> CreateAsync(CocktailIngredientRecord row);
    Task<int> DeleteByCocktailIdAsync(int cocktailId);
}
