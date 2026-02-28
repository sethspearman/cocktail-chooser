namespace CocktailChooser.API.DTOs
{
    public class CocktailIngredientEntryDto
    {
        public int? AmountId { get; set; }
        public string? AmountText { get; set; }
        public string? IngredientName { get; set; }
    }

    public class CocktailStepEntryDto
    {
        public string? Instruction { get; set; }
    }

    public class CocktailDto
    {
        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public string? Description { get; set; }
        public string? Method { get; set; }
        public string? IngredientLines { get; set; }
        public string? StepLines { get; set; }
        public string? FlavorProfile { get; set; }
        public List<CocktailIngredientEntryDto>? StructuredIngredients { get; set; }
        public List<CocktailStepEntryDto>? StructuredSteps { get; set; }
        public int? GlassTypeId { get; set; }
        public int? TimePeriodId { get; set; }
        public int? IsPopular { get; set; }
        public int? IsApproved { get; set; }
        public int? IsUserSubmitted { get; set; }
        public int? SubmittedByUserId { get; set; }
        public int? CocktailSourceId { get; set; }
    }
}
