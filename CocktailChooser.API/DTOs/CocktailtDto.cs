namespace CocktailChooser.API.DTOs
{
    public class CocktailDto
    {
        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public string? Description { get; set; }
        public string? Method { get; set; }
        public string? IngredientLines { get; set; }
        public string? StepLines { get; set; }
        public string? FlavorProfile { get; set; }
        public int? GlassTypeId { get; set; }
        public int? TimePeriodId { get; set; }
        public int? IsPopular { get; set; }
        public int? CocktailSourceId { get; set; }
    }
}
