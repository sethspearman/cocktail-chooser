using CocktailChooser.API.DTOs;

namespace CocktailChooser.API.Services
{
    public interface ICocktailService
    {
        Task<IEnumerable<CocktailDto>> GetAllCocktailsAsync();
        Task<CocktailDto?> GetCocktailByIdAsync(int id);
        Task<CocktailDto> CreateCocktailAsync(CocktailDto cocktailDto);
        Task<bool> UpdateCocktailAsync(CocktailDto cocktailDto);
        Task<bool> DeleteCocktailAsync(int id);
    }
}
