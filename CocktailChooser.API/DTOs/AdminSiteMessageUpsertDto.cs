namespace CocktailChooser.API.DTOs;

public class AdminSiteMessageUpsertDto
{
    public int? Id { get; set; }
    public string MessageText { get; set; } = string.Empty;
    public bool IsActive { get; set; }
    public string? StartUtc { get; set; }
    public string? EndUtc { get; set; }
    public string? Audience { get; set; }
}
