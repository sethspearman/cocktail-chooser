using CocktailChooser.API.DTOs;

namespace CocktailChooser.API.Services;

public interface IAdminMaintenanceService
{
    Task<IngredientDuplicateGroupsResponseDto> GetIngredientDuplicateGroupsAsync();
    Task<CocktailDuplicateGroupsResponseDto> GetCocktailDuplicateGroupsAsync();
    Task<IngredientMergePreviewDto> PreviewIngredientMergeAsync(IngredientMergeRequestDto request);
    Task<IngredientMergeResultDto> MergeIngredientAsync(IngredientMergeRequestDto request, int performedByUserId);
    Task<CocktailMergePreviewDto> PreviewCocktailMergeAsync(CocktailMergeRequestDto request);
    Task<CocktailMergeResultDto> MergeCocktailAsync(CocktailMergeRequestDto request, int performedByUserId);
}
