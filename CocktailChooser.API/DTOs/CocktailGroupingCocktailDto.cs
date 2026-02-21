namespace CocktailChooser.API.DTOs;

public class CocktailGroupingCocktailDto
{
    public string GroupingName { get; set; } = string.Empty;
    public int CocktailId { get; set; }
    public string CocktailName { get; set; } = string.Empty;
    public int CocktailSourceId { get; set; }
    public string CocktailSourceName { get; set; } = string.Empty;
}
