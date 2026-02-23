namespace CocktailChooser.API.Auth;

public interface IPasswordHasher
{
    PasswordHashResult HashPassword(string password);
    bool VerifyPassword(string password, string passwordHash, string passwordSalt, int iterations);
}

public sealed record PasswordHashResult(string Hash, string Salt, int Iterations);
