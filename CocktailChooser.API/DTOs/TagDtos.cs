namespace CocktailChooser.API.DTOs;

public class TagTypeDto
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public int IsSeeded { get; set; }
    public string CreatedUtc { get; set; } = string.Empty;
}

public class TagDto
{
    public int Id { get; set; }
    public int TagTypeId { get; set; }
    public string TagTypeName { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string NormalizedName { get; set; } = string.Empty;
    public string CreatedUtc { get; set; } = string.Empty;
}

public class CocktailTagAssignmentDto
{
    public int CocktailId { get; set; }
    public int TagId { get; set; }
}
