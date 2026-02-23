using CocktailChooser.API.DTOs;

namespace CocktailChooser.API.Services;

public interface IAuthService
{
    Task<AuthResponseDto> RegisterAsync(AuthRegisterRequestDto dto);
    Task<AuthResponseDto> LoginAsync(AuthLoginRequestDto dto);
    Task<UserDto?> GetUserAsync(int userId);
}
