namespace CocktailChooser.Data.Repositories;

public class IngredientRecord
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public int? IngredientTypeId { get; set; }
    public int? MixerSubtypeId { get; set; }
    public string? PrimarySpirit { get; set; }
    public string? LongDescription { get; set; }
}
