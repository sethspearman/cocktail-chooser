namespace CocktailChooser.API.DTOs
{
    public class IngredientDto
    {
        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public int? IngredientTypeId { get; set; }
        public int? MixerSubtypeId { get; set; }
        public string? PrimarySpirit { get; set; }
        public string? LongDescription { get; set; }
    }
}
