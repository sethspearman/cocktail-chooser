namespace CocktailChooser.Data.Repositories;

public interface ICocktailTagRepository
{
    Task<IEnumerable<TagTypeRecord>> GetTagTypesAsync();
    Task<IEnumerable<TagRecord>> GetTagsByTypeAsync(int? tagTypeId = null, string? tagTypeName = null);
    Task<IEnumerable<CocktailTagRecord>> GetCocktailTagsAsync(int cocktailId);
    Task<IDictionary<int, List<CocktailTagRecord>>> GetCocktailTagsByCocktailIdsAsync(IEnumerable<int> cocktailIds);
    Task<ISet<int>> GetCocktailIdsForTagsAsync(IEnumerable<string> normalizedTagNames, bool matchAll);
    Task AssignTagToCocktailAsync(int cocktailId, int tagId);
    Task<bool> RemoveTagFromCocktailAsync(int cocktailId, int tagId);
}
