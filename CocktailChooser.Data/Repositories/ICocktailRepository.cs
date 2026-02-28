namespace CocktailChooser.Data.Repositories;

public interface ICocktailRepository
{
    Task<IEnumerable<CocktailRecord>> GetAllAsync();
    Task<CocktailRecord?> GetByIdAsync(int id);
    Task<IEnumerable<LookupOptionRecord>> GetTimePeriodsAsync();
    Task<CocktailRecord> CreateAsync(CocktailRecord cocktail);
    Task<bool> UpdateAsync(CocktailRecord cocktail);
    Task<bool> DeleteAsync(int id);
}
