namespace CocktailChooser.Data.Repositories;

public class TagRecord
{
    public int Id { get; set; }
    public int TagTypeId { get; set; }
    public string TagTypeName { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string NormalizedName { get; set; } = string.Empty;
    public string CreatedUtc { get; set; } = string.Empty;
}
