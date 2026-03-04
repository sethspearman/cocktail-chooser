using CocktailChooser.API.DTOs;

namespace CocktailChooser.API.Services
{
    public interface ICocktailService
    {
        Task<IEnumerable<CocktailDto>> GetAllCocktailsAsync(
            IEnumerable<string>? includeIngredientNames = null,
            string? includeMode = null,
            string? alcoholFilter = null);
        Task<IEnumerable<CocktailDto>> GetMyCocktailsForUserAsync(int userId);
        Task<IEnumerable<CocktailDto>> GetPendingCocktailsForAdminAsync();
        Task<IEnumerable<CocktailDto>> GetPendingCocktailsForUserAsync(int userId);
        Task<CocktailDto?> GetCocktailByIdAsync(int id);
        Task<IEnumerable<AdminCocktailPortDto>> ExportAdminCocktailsAsync(
            int? cocktailId = null,
            int? sourceId = null,
            int? offset = null,
            int? limit = null);
        Task<AdminCocktailImportResultDto> ImportAdminCocktailsAsync(AdminCocktailImportRequestDto request);
        Task<CocktailDto> CreateCocktailAsync(CocktailDto cocktailDto);
        Task<CocktailTextPreviewResponseDto> PreviewFromTextAsync(CocktailTextPreviewRequestDto requestDto);
        Task<CocktailDto> SubmitFromTextAsync(CocktailTextSubmitRequestDto requestDto, int userId);
        Task<bool> ApproveCocktailAsync(int id, int approvedByUserId);
        Task<bool> RejectCocktailAsync(int id);
        Task<bool> UpdateCocktailAsync(CocktailDto cocktailDto);
        Task<bool> DeleteCocktailAsync(int id);
    }
}
