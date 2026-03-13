namespace CocktailChooser.Data.Repositories;

public interface ICollectionRepository
{
    Task<IEnumerable<CollectionRecord>> GetAllAsync(bool includeSystemCollections = true, int? ownerUserId = null);
    Task<CollectionRecord?> GetByIdAsync(int id);
    Task<IEnumerable<CollectionCocktailRecord>> GetCocktailsAsync(int collectionId);
    Task<CollectionRecord> CreateAsync(CollectionRecord collection);
    Task<bool> UpdateAsync(CollectionRecord collection);
    Task<bool> DeleteAsync(int id);
    Task AddCocktailAsync(int collectionId, int cocktailId);
    Task<bool> RemoveCocktailAsync(int collectionId, int cocktailId);
}
