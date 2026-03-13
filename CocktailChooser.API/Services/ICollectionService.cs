using CocktailChooser.API.DTOs;

namespace CocktailChooser.API.Services;

public interface ICollectionService
{
    Task<IEnumerable<CollectionDto>> GetCollectionsAsync(bool includeSystemCollections = true, int? ownerUserId = null);
    Task<CollectionDto?> GetCollectionByIdAsync(int id);
    Task<IEnumerable<CollectionCocktailDto>> GetCollectionCocktailsAsync(int collectionId);
    Task<CollectionDto> CreateCollectionAsync(CollectionDto dto);
    Task<bool> UpdateCollectionAsync(CollectionDto dto);
    Task<bool> DeleteCollectionAsync(int id);
    Task AddCocktailAsync(int collectionId, int cocktailId);
    Task<bool> RemoveCocktailAsync(int collectionId, int cocktailId);
}
