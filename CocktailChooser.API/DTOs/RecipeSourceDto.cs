namespace CocktailChooser.API.DTOs
{
    public class RecipeSourceDto
    {
        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public string SourceType { get; set; } = null!;
        public string? Publisher { get; set; }
        public string? PublishDate { get; set; }
        public string? Author { get; set; }
        public string? Isbn10 { get; set; }
        public string? Isbn13 { get; set; }
        public string? PurchaseUrl { get; set; }
        public string? Edition { get; set; }
        public string? Language { get; set; }
        public string? CopyrightCredit { get; set; }
        public string? Url { get; set; }
        public string? Notes { get; set; }
        public int IsBuiltIn { get; set; }
        public string? CreatedUtc { get; set; }
    }
}
