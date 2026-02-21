using CocktailChooser.API.DTOs;

namespace CocktailChooser.API.Services;

public interface ICocktailGroupingService
{
    Task<IEnumerable<CocktailGroupingLinkDto>> GetLinksByGroupingNameAsync(string groupingName);
    Task<IEnumerable<CocktailGroupingCocktailDto>> GetCocktailsByGroupingNameAsync(string groupingName);
    Task<CocktailGroupingLinkDto> UpsertLinkAsync(CocktailGroupingLinkDto linkDto);
    Task<bool> RenameLinkAsync(CocktailGroupingRenameDto renameDto);
}
