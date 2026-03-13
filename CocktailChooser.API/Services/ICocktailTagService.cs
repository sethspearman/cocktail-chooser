using CocktailChooser.API.DTOs;

namespace CocktailChooser.API.Services;

public interface ICocktailTagService
{
    Task<IEnumerable<TagTypeDto>> GetTagTypesAsync();
    Task<IEnumerable<TagDto>> GetTagsAsync(int? tagTypeId = null, string? tagTypeName = null);
    Task<IEnumerable<TagDto>> GetCocktailTagsAsync(int cocktailId);
    Task AssignTagToCocktailAsync(int cocktailId, int tagId);
    Task<bool> RemoveTagFromCocktailAsync(int cocktailId, int tagId);
}
