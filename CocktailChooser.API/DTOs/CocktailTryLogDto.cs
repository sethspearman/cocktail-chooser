namespace CocktailChooser.API.DTOs;

public class CocktailTryLogDto
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public int CocktailId { get; set; }
    public int? Rating { get; set; }
    public string? Comment { get; set; }
    public string? TriedOnUtc { get; set; }
    public string? CreatedUtc { get; set; }
    public string? UpdatedUtc { get; set; }
}
