using CocktailChooser.API.DTOs;
using CocktailChooser.Data.Repositories;

namespace CocktailChooser.API.Services;

public class AdminMaintenanceService : IAdminMaintenanceService
{
    private readonly IAdminMaintenanceRepository _repository;

    public AdminMaintenanceService(IAdminMaintenanceRepository repository)
    {
        _repository = repository;
    }

    public async Task<IngredientDuplicateGroupsResponseDto> GetIngredientDuplicateGroupsAsync()
    {
        var rows = (await _repository.GetIngredientDuplicateCandidatesAsync()).ToList();
        var groups = rows
            .GroupBy(x => x.NormalizedName, StringComparer.Ordinal)
            .OrderBy(g => g.Key, StringComparer.Ordinal)
            .Select(g => new IngredientDuplicateGroupDto
            {
                NormalizedName = g.Key,
                Candidates = g
                    .OrderBy(x => x.IngredientId)
                    .Select(x => new IngredientDuplicateCandidateDto
                    {
                        IngredientId = x.IngredientId,
                        Name = x.Name,
                        CocktailUsageCount = x.CocktailUsageCount,
                        UserUsageCount = x.UserUsageCount
                    })
                    .ToList()
            })
            .ToList();

        return new IngredientDuplicateGroupsResponseDto
        {
            Groups = groups
        };
    }

    public async Task<CocktailDuplicateGroupsResponseDto> GetCocktailDuplicateGroupsAsync()
    {
        var rows = (await _repository.GetCocktailDuplicateCandidatesAsync()).ToList();
        var groups = rows
            .GroupBy(x => x.NormalizedName, StringComparer.Ordinal)
            .OrderBy(g => g.Key, StringComparer.Ordinal)
            .Select(g => new CocktailDuplicateGroupDto
            {
                NormalizedName = g.Key,
                Candidates = g
                    .OrderBy(x => x.CocktailId)
                    .Select(x => new CocktailDuplicateCandidateDto
                    {
                        CocktailId = x.CocktailId,
                        Name = x.Name,
                        CocktailSourceId = x.CocktailSourceId,
                        CanonicalKey = x.CanonicalKey,
                        IngredientRowCount = x.IngredientRowCount,
                        StepRowCount = x.StepRowCount,
                        IsApproved = x.IsApproved
                    })
                    .ToList()
            })
            .ToList();

        return new CocktailDuplicateGroupsResponseDto
        {
            Groups = groups
        };
    }

    public async Task<IngredientMergeResultDto> MergeIngredientAsync(IngredientMergeRequestDto request, int performedByUserId)
    {
        var result = await _repository.MergeIngredientAsync(
            request.KeepIngredientId,
            request.RemoveIngredientId,
            performedByUserId,
            request.Reason);

        return new IngredientMergeResultDto
        {
            KeepIngredientId = result.KeepIngredientId,
            RemoveIngredientId = result.RemoveIngredientId,
            CocktailRowsRepointed = result.CocktailRowsRepointed,
            CocktailDuplicateRowsDeleted = result.CocktailDuplicateRowsDeleted,
            UserRowsRemovedFromSource = result.UserRowsRemovedFromSource
        };
    }

    public async Task<IngredientMergePreviewDto> PreviewIngredientMergeAsync(IngredientMergeRequestDto request)
    {
        var preview = await _repository.PreviewIngredientMergeAsync(
            request.KeepIngredientId,
            request.RemoveIngredientId);

        return new IngredientMergePreviewDto
        {
            KeepIngredientId = preview.KeepIngredientId,
            RemoveIngredientId = preview.RemoveIngredientId,
            CocktailRowsWouldRepoint = preview.CocktailRowsWouldRepoint,
            CocktailDuplicateRowsWouldDelete = preview.CocktailDuplicateRowsWouldDelete,
            UserRowsWouldRemoveFromSource = preview.UserRowsWouldRemoveFromSource
        };
    }

    public async Task<CocktailMergeResultDto> MergeCocktailAsync(CocktailMergeRequestDto request, int performedByUserId)
    {
        var result = await _repository.MergeCocktailAsync(
            request.KeepCocktailId,
            request.RemoveCocktailId,
            performedByUserId,
            request.Reason);

        return new CocktailMergeResultDto
        {
            KeepCocktailId = result.KeepCocktailId,
            RemoveCocktailId = result.RemoveCocktailId,
            IngredientRowsInsertedToKeep = result.IngredientRowsInsertedToKeep,
            IngredientRowsDeletedFromSource = result.IngredientRowsDeletedFromSource,
            StepsInsertedToKeep = result.StepsInsertedToKeep,
            StepsDeletedFromSource = result.StepsDeletedFromSource,
            TryLogRowsRepointed = result.TryLogRowsRepointed,
            GroupingRowsInsertedToKeep = result.GroupingRowsInsertedToKeep,
            GroupingRowsDeletedFromSource = result.GroupingRowsDeletedFromSource
        };
    }

    public async Task<CocktailMergePreviewDto> PreviewCocktailMergeAsync(CocktailMergeRequestDto request)
    {
        var preview = await _repository.PreviewCocktailMergeAsync(
            request.KeepCocktailId,
            request.RemoveCocktailId);

        return new CocktailMergePreviewDto
        {
            KeepCocktailId = preview.KeepCocktailId,
            RemoveCocktailId = preview.RemoveCocktailId,
            IngredientRowsWouldInsertToKeep = preview.IngredientRowsWouldInsertToKeep,
            IngredientRowsWouldDeleteFromSource = preview.IngredientRowsWouldDeleteFromSource,
            StepsWouldInsertToKeep = preview.StepsWouldInsertToKeep,
            StepsWouldDeleteFromSource = preview.StepsWouldDeleteFromSource,
            TryLogRowsWouldRepoint = preview.TryLogRowsWouldRepoint,
            GroupingRowsWouldInsertToKeep = preview.GroupingRowsWouldInsertToKeep,
            GroupingRowsWouldDeleteFromSource = preview.GroupingRowsWouldDeleteFromSource
        };
    }
}
