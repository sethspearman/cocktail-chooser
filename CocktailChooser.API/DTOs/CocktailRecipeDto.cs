namespace CocktailChooser.API.DTOs
{
    public class CocktailRecipeDto
    {
        public int CocktailId { get; set; }
        public int StepNumber { get; set; }
        public string? Instruction { get; set; }
    }
}