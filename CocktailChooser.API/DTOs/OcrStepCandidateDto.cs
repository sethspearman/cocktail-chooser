namespace CocktailChooser.API.DTOs;

public class OcrStepCandidateDto
{
    public int Id { get; set; }
    public int OcrRecipeCandidateId { get; set; }
    public int StepNumber { get; set; }
    public string Instruction { get; set; } = null!;
    public double? Confidence { get; set; }
    public string? CreatedUtc { get; set; }
}
