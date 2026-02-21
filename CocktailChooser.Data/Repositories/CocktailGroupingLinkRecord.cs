namespace CocktailChooser.Data.Repositories;

public class CocktailGroupingLinkRecord
{
    public int CocktailId { get; set; }
    public int CocktailSourceId { get; set; }
    public string GroupingName { get; set; } = string.Empty;
}
