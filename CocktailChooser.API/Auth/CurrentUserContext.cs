namespace CocktailChooser.API.Auth;

public interface ICurrentUserContext
{
    int? UserId { get; set; }
}

public class CurrentUserContext : ICurrentUserContext
{
    public int? UserId { get; set; }
}
