namespace CocktailChooser.API.DTOs;

public class AuthLoginRequestDto
{
    public string Email { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
}
