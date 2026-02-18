namespace CocktailChooser.Data.Repositories;

public class OcrStepCandidateRecord
{
    public int Id { get; set; }
    public int OcrRecipeCandidateId { get; set; }
    public int StepNumber { get; set; }
    public string Instruction { get; set; } = string.Empty;
    public double? Confidence { get; set; }
    public string? CreatedUtc { get; set; }
}
