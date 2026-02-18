namespace CocktailChooser.Data.Repositories;

public class CocktailRecipeRecord
{
    public int CocktailId { get; set; }
    public int StepNumber { get; set; }
    public string? Instruction { get; set; }
}
