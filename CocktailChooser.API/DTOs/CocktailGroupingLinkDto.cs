namespace CocktailChooser.API.DTOs;

public class CocktailGroupingLinkDto
{
    public int CocktailId { get; set; }
    public int CocktailSourceId { get; set; }
    public string GroupingName { get; set; } = string.Empty;
}
