namespace CocktailChooser.Data.Repositories;

public class CocktailRecord
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string? Method { get; set; }
    public int? GlassTypeId { get; set; }
    public int? TimePeriodId { get; set; }
    public int? IsPopular { get; set; }
    public int? IsApproved { get; set; }
    public int? IsUserSubmitted { get; set; }
    public int? SubmittedByUserId { get; set; }
    public int? CocktailSourceId { get; set; }
}
