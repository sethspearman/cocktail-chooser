namespace CocktailChooser.API.DTOs;

public class UserDto
{
    public int Id { get; set; }
    public string DisplayName { get; set; } = null!;
    public string? Email { get; set; }
    public string? CreatedUtc { get; set; }
    public string? UpdatedUtc { get; set; }
}
