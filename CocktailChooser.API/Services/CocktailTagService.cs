using CocktailChooser.API.DTOs;
using CocktailChooser.Data.Repositories;

namespace CocktailChooser.API.Services;

public class CocktailTagService : ICocktailTagService
{
    private readonly ICocktailTagRepository _repository;

    public CocktailTagService(ICocktailTagRepository repository)
    {
        _repository = repository;
    }

    public async Task<IEnumerable<TagTypeDto>> GetTagTypesAsync()
    {
        var rows = await _repository.GetTagTypesAsync();
        return rows.Select(x => new TagTypeDto
        {
            Id = x.Id,
            Name = x.Name,
            Description = x.Description,
            IsSeeded = x.IsSeeded,
            CreatedUtc = x.CreatedUtc
        });
    }

    public async Task<IEnumerable<TagDto>> GetTagsAsync(int? tagTypeId = null, string? tagTypeName = null)
    {
        var rows = await _repository.GetTagsByTypeAsync(tagTypeId, tagTypeName);
        return rows.Select(MapTagToDto);
    }

    public async Task<IEnumerable<TagDto>> GetCocktailTagsAsync(int cocktailId)
    {
        var rows = await _repository.GetCocktailTagsAsync(cocktailId);
        return rows.Select(x => new TagDto
        {
            Id = x.TagId,
            TagTypeId = x.TagTypeId,
            TagTypeName = x.TagTypeName,
            Name = x.TagName,
            NormalizedName = x.TagNormalizedName,
            CreatedUtc = x.CreatedUtc
        });
    }

    public Task AssignTagToCocktailAsync(int cocktailId, int tagId)
    {
        return _repository.AssignTagToCocktailAsync(cocktailId, tagId);
    }

    public Task<bool> RemoveTagFromCocktailAsync(int cocktailId, int tagId)
    {
        return _repository.RemoveTagFromCocktailAsync(cocktailId, tagId);
    }

    private static TagDto MapTagToDto(TagRecord row)
    {
        return new TagDto
        {
            Id = row.Id,
            TagTypeId = row.TagTypeId,
            TagTypeName = row.TagTypeName,
            Name = row.Name,
            NormalizedName = row.NormalizedName,
            CreatedUtc = row.CreatedUtc
        };
    }
}
