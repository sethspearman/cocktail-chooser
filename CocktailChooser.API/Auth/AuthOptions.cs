namespace CocktailChooser.API.Auth;

public class AuthOptions
{
    public string SecretKey { get; set; } = "replace-this-in-production";
    public int TokenLifetimeHours { get; set; } = 168;
}
