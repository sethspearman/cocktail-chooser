using CocktailChooser.API.DTOs;

namespace CocktailChooser.API.Services;

public interface ICocktailGroupingService
{
    Task<IEnumerable<string>> GetGroupingNamesAsync();
    Task<IEnumerable<CocktailGroupingLinkDto>> GetLinksByGroupingNameAsync(string groupingName);
    Task<IEnumerable<CocktailGroupingLinkDto>> GetLinksByCocktailIdAsync(int cocktailId);
    Task<IEnumerable<CocktailGroupingCocktailDto>> GetCocktailsByGroupingNameAsync(string groupingName);
    Task<CocktailGroupingLinkDto> UpsertLinkAsync(CocktailGroupingLinkDto linkDto);
    Task<bool> RenameLinkAsync(CocktailGroupingRenameDto renameDto);
    Task<bool> DeleteLinkAsync(int cocktailId, int cocktailSourceId, string groupingName);
}
