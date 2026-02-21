namespace CocktailChooser.API.DTOs;

public class CocktailGroupingRenameDto
{
    public int CocktailId { get; set; }
    public int CocktailSourceId { get; set; }
    public string GroupingName { get; set; } = string.Empty;
    public string NewGroupingName { get; set; } = string.Empty;
}
