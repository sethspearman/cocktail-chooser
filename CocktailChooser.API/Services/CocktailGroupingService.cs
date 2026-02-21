using CocktailChooser.API.DTOs;
using CocktailChooser.Data.Repositories;

namespace CocktailChooser.API.Services;

public class CocktailGroupingService : ICocktailGroupingService
{
    private readonly ICocktailGroupingRepository _repository;

    public CocktailGroupingService(ICocktailGroupingRepository repository)
    {
        _repository = repository;
    }

    public async Task<IEnumerable<CocktailGroupingLinkDto>> GetLinksByGroupingNameAsync(string groupingName)
    {
        var rows = await _repository.GetByGroupingNameAsync(groupingName);
        return rows.Select(MapLinkToDto);
    }

    public async Task<IEnumerable<CocktailGroupingCocktailDto>> GetCocktailsByGroupingNameAsync(string groupingName)
    {
        var rows = await _repository.GetCocktailsByGroupingNameAsync(groupingName);
        return rows.Select(MapCocktailToDto);
    }

    public async Task<CocktailGroupingLinkDto> UpsertLinkAsync(CocktailGroupingLinkDto linkDto)
    {
        var row = await _repository.UpsertAsync(MapLinkToRecord(linkDto));
        return MapLinkToDto(row);
    }

    public async Task<bool> RenameLinkAsync(CocktailGroupingRenameDto renameDto)
    {
        return await _repository.RenameAsync(
            renameDto.CocktailId,
            renameDto.CocktailSourceId,
            renameDto.GroupingName,
            renameDto.NewGroupingName);
    }

    private static CocktailGroupingLinkDto MapLinkToDto(CocktailGroupingLinkRecord row)
    {
        return new CocktailGroupingLinkDto
        {
            CocktailId = row.CocktailId,
            CocktailSourceId = row.CocktailSourceId,
            GroupingName = row.GroupingName
        };
    }

    private static CocktailGroupingLinkRecord MapLinkToRecord(CocktailGroupingLinkDto dto)
    {
        return new CocktailGroupingLinkRecord
        {
            CocktailId = dto.CocktailId,
            CocktailSourceId = dto.CocktailSourceId,
            GroupingName = dto.GroupingName
        };
    }

    private static CocktailGroupingCocktailDto MapCocktailToDto(CocktailGroupingCocktailRecord row)
    {
        return new CocktailGroupingCocktailDto
        {
            GroupingName = row.GroupingName,
            CocktailId = row.CocktailId,
            CocktailName = row.CocktailName,
            CocktailSourceId = row.CocktailSourceId,
            CocktailSourceName = row.CocktailSourceName
        };
    }
}
