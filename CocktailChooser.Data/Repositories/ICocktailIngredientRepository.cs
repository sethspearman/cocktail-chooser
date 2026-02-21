namespace CocktailChooser.Data.Repositories;

public interface ICocktailIngredientRepository
{
    Task<IEnumerable<CocktailIngredientRecord>> GetAllAsync();
    Task<IEnumerable<CocktailIngredientRecord>> GetByCocktailIdAsync(int cocktailId);
}
