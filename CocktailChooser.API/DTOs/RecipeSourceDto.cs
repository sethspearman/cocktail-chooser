namespace CocktailChooser.API.DTOs
{
    public class RecipeSourceDto
    {
        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public string SourceType { get; set; } = null!;
        public string? CopyrightCredit { get; set; }
        public string? Url { get; set; }
        public string? Notes { get; set; }
        public int IsBuiltIn { get; set; }
        public string? CreatedUtc { get; set; }
    }
}
