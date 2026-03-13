namespace CocktailChooser.API.DTOs;

public class CollectionDto
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public int? OwnerUserId { get; set; }
    public int IsSystemCollection { get; set; }
    public string CreatedUtc { get; set; } = string.Empty;
}

public class CollectionCocktailDto
{
    public int CollectionId { get; set; }
    public int CocktailId { get; set; }
    public string CreatedUtc { get; set; } = string.Empty;
    public string CocktailName { get; set; } = string.Empty;
    public string? CocktailCanonicalKey { get; set; }
}

public class CollectionCocktailUpsertDto
{
    public int CocktailId { get; set; }
}
