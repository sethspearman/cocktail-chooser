namespace CocktailChooser.Data.Repositories;

public class TagTypeRecord
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public int IsSeeded { get; set; }
    public string CreatedUtc { get; set; } = string.Empty;
}
