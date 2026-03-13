namespace CocktailChooser.Data.Repositories;

public class CocktailTagRecord
{
    public int CocktailId { get; set; }
    public int TagId { get; set; }
    public int TagTypeId { get; set; }
    public string TagTypeName { get; set; } = string.Empty;
    public string TagName { get; set; } = string.Empty;
    public string TagNormalizedName { get; set; } = string.Empty;
    public string CreatedUtc { get; set; } = string.Empty;
}
