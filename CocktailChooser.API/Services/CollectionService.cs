using CocktailChooser.API.DTOs;
using CocktailChooser.Data.Repositories;

namespace CocktailChooser.API.Services;

public class CollectionService : ICollectionService
{
    private readonly ICollectionRepository _repository;

    public CollectionService(ICollectionRepository repository)
    {
        _repository = repository;
    }

    public async Task<IEnumerable<CollectionDto>> GetCollectionsAsync(bool includeSystemCollections = true, int? ownerUserId = null)
    {
        var rows = await _repository.GetAllAsync(includeSystemCollections, ownerUserId);
        return rows.Select(MapCollectionToDto);
    }

    public async Task<CollectionDto?> GetCollectionByIdAsync(int id)
    {
        var row = await _repository.GetByIdAsync(id);
        return row is null ? null : MapCollectionToDto(row);
    }

    public async Task<IEnumerable<CollectionCocktailDto>> GetCollectionCocktailsAsync(int collectionId)
    {
        var rows = await _repository.GetCocktailsAsync(collectionId);
        return rows.Select(x => new CollectionCocktailDto
        {
            CollectionId = x.CollectionId,
            CocktailId = x.CocktailId,
            CreatedUtc = x.CreatedUtc,
            CocktailName = x.CocktailName,
            CocktailCanonicalKey = x.CocktailCanonicalKey
        });
    }

    public async Task<CollectionDto> CreateCollectionAsync(CollectionDto dto)
    {
        var created = await _repository.CreateAsync(MapCollectionToRecord(dto));
        return MapCollectionToDto(created);
    }

    public async Task<bool> UpdateCollectionAsync(CollectionDto dto)
    {
        return await _repository.UpdateAsync(MapCollectionToRecord(dto));
    }

    public async Task<bool> DeleteCollectionAsync(int id)
    {
        return await _repository.DeleteAsync(id);
    }

    public Task AddCocktailAsync(int collectionId, int cocktailId)
    {
        return _repository.AddCocktailAsync(collectionId, cocktailId);
    }

    public Task<bool> RemoveCocktailAsync(int collectionId, int cocktailId)
    {
        return _repository.RemoveCocktailAsync(collectionId, cocktailId);
    }

    private static CollectionDto MapCollectionToDto(CollectionRecord row)
    {
        return new CollectionDto
        {
            Id = row.Id,
            Name = row.Name,
            Description = row.Description,
            OwnerUserId = row.OwnerUserId,
            IsSystemCollection = row.IsSystemCollection,
            CreatedUtc = row.CreatedUtc
        };
    }

    private static CollectionRecord MapCollectionToRecord(CollectionDto dto)
    {
        return new CollectionRecord
        {
            Id = dto.Id,
            Name = dto.Name,
            Description = dto.Description,
            OwnerUserId = dto.OwnerUserId,
            IsSystemCollection = dto.IsSystemCollection,
            CreatedUtc = dto.CreatedUtc
        };
    }
}
