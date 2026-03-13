namespace CocktailChooser.Data.Repositories;

public class CollectionRecord
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public int? OwnerUserId { get; set; }
    public int IsSystemCollection { get; set; }
    public string CreatedUtc { get; set; } = string.Empty;
}
