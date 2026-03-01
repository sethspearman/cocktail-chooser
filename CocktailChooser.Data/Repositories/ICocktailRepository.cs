namespace CocktailChooser.Data.Repositories;

public interface ICocktailRepository
{
    Task<IEnumerable<CocktailRecord>> GetAllAsync();
    Task<CocktailRecord?> GetByIdAsync(int id);
    Task<CocktailRecord?> GetByCanonicalKeyAsync(string canonicalKey);
    Task<bool> IsCanonicalKeyInUseAsync(string canonicalKey, int? excludeCocktailId = null);
    Task<CocktailRecord> UpsertAdminImportAsync(AdminCocktailImportRecord importRecord);
    Task<IEnumerable<LookupOptionRecord>> GetTimePeriodsAsync();
    Task<CocktailRecord> CreateAsync(CocktailRecord cocktail);
    Task<bool> UpdateAsync(CocktailRecord cocktail);
    Task<bool> DeleteAsync(int id);
}
