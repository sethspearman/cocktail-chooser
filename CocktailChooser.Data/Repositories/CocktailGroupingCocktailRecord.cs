namespace CocktailChooser.Data.Repositories;

public class CocktailGroupingCocktailRecord
{
    public string GroupingName { get; set; } = string.Empty;
    public int CocktailId { get; set; }
    public string CocktailName { get; set; } = string.Empty;
    public int CocktailSourceId { get; set; }
    public string CocktailSourceName { get; set; } = string.Empty;
}
