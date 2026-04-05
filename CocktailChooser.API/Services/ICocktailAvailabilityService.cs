using CocktailChooser.API.DTOs;

namespace CocktailChooser.API.Services;

public interface ICocktailAvailabilityService
{
    Task<CocktailAvailabilityDto?> GetAvailabilityForUserAsync(int cocktailId, int userId);
}
