using CocktailChooser.API.DTOs;

namespace CocktailChooser.API.Services
{
    public interface ICocktailService
    {
        Task<IEnumerable<CocktailDto>> GetAllCocktailsAsync(
            IEnumerable<string>? includeIngredientNames = null,
            string? includeMode = null,
            string? alcoholFilter = null);
        Task<IEnumerable<CocktailDto>> GetPendingCocktailsForUserAsync(int userId);
        Task<CocktailDto?> GetCocktailByIdAsync(int id);
        Task<CocktailDto> CreateCocktailAsync(CocktailDto cocktailDto);
        Task<CocktailTextPreviewResponseDto> PreviewFromTextAsync(CocktailTextPreviewRequestDto requestDto);
        Task<CocktailDto> SubmitFromTextAsync(CocktailTextSubmitRequestDto requestDto, int userId);
        Task<bool> ApproveCocktailAsync(int id);
        Task<bool> RejectCocktailAsync(int id, bool delete);
        Task<bool> UpdateCocktailAsync(CocktailDto cocktailDto);
        Task<bool> DeleteCocktailAsync(int id);
    }
}
