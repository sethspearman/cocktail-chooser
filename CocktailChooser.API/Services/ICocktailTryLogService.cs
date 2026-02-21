using CocktailChooser.API.DTOs;

namespace CocktailChooser.API.Services;

public interface ICocktailTryLogService
{
    Task<CocktailTryLogDto?> GetCocktailTryLogByIdAsync(int id);
    Task<IEnumerable<CocktailTryLogDto>> GetCocktailTryLogsByCocktailIdAsync(int cocktailId, int? userId = null);
    Task<IEnumerable<CocktailTryLogDto>> GetCocktailTryLogsByUserIdAsync(int userId);
    Task<CocktailTryLogDto> CreateCocktailTryLogAsync(CocktailTryLogDto logDto);
    Task<bool> UpdateCocktailTryLogAsync(CocktailTryLogDto logDto);
    Task<bool> DeleteCocktailTryLogAsync(int id);
}
