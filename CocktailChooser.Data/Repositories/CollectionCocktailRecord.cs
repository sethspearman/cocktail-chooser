namespace CocktailChooser.Data.Repositories;

public class CollectionCocktailRecord
{
    public int CollectionId { get; set; }
    public int CocktailId { get; set; }
    public string CreatedUtc { get; set; } = string.Empty;
    public string CocktailName { get; set; } = string.Empty;
    public string? CocktailCanonicalKey { get; set; }
}
