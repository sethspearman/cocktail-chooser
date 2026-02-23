namespace CocktailChooser.API.Auth;

public interface ITokenService
{
    string CreateToken(int userId);
    bool TryGetUserId(string token, out int userId);
}
