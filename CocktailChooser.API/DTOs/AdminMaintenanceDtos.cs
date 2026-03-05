namespace CocktailChooser.API.DTOs;

public class IngredientDuplicateGroupsResponseDto
{
    public List<IngredientDuplicateGroupDto> Groups { get; set; } = new();
}

public class CocktailDuplicateGroupsResponseDto
{
    public List<CocktailDuplicateGroupDto> Groups { get; set; } = new();
}

public class IngredientDuplicateGroupDto
{
    public string NormalizedName { get; set; } = string.Empty;
    public List<IngredientDuplicateCandidateDto> Candidates { get; set; } = new();
}

public class IngredientDuplicateCandidateDto
{
    public int IngredientId { get; set; }
    public string Name { get; set; } = string.Empty;
    public int CocktailUsageCount { get; set; }
    public int UserUsageCount { get; set; }
}

public class CocktailDuplicateGroupDto
{
    public string NormalizedName { get; set; } = string.Empty;
    public List<CocktailDuplicateCandidateDto> Candidates { get; set; } = new();
}

public class CocktailDuplicateCandidateDto
{
    public int CocktailId { get; set; }
    public string Name { get; set; } = string.Empty;
    public int? CocktailSourceId { get; set; }
    public string? CanonicalKey { get; set; }
    public int IngredientRowCount { get; set; }
    public int StepRowCount { get; set; }
    public int IsApproved { get; set; }
}

public class IngredientMergeRequestDto
{
    public int KeepIngredientId { get; set; }
    public int RemoveIngredientId { get; set; }
    public string? Reason { get; set; }
}

public class IngredientMergeResultDto
{
    public int KeepIngredientId { get; set; }
    public int RemoveIngredientId { get; set; }
    public int CocktailRowsRepointed { get; set; }
    public int CocktailDuplicateRowsDeleted { get; set; }
    public int UserRowsRemovedFromSource { get; set; }
}

public class IngredientMergePreviewDto
{
    public int KeepIngredientId { get; set; }
    public int RemoveIngredientId { get; set; }
    public int CocktailRowsWouldRepoint { get; set; }
    public int CocktailDuplicateRowsWouldDelete { get; set; }
    public int UserRowsWouldRemoveFromSource { get; set; }
}

public class CocktailMergeRequestDto
{
    public int KeepCocktailId { get; set; }
    public int RemoveCocktailId { get; set; }
    public string? Reason { get; set; }
}

public class CocktailMergeResultDto
{
    public int KeepCocktailId { get; set; }
    public int RemoveCocktailId { get; set; }
    public int IngredientRowsInsertedToKeep { get; set; }
    public int IngredientRowsDeletedFromSource { get; set; }
    public int StepsInsertedToKeep { get; set; }
    public int StepsDeletedFromSource { get; set; }
    public int TryLogRowsRepointed { get; set; }
    public int GroupingRowsInsertedToKeep { get; set; }
    public int GroupingRowsDeletedFromSource { get; set; }
}

public class CocktailMergePreviewDto
{
    public int KeepCocktailId { get; set; }
    public int RemoveCocktailId { get; set; }
    public int IngredientRowsWouldInsertToKeep { get; set; }
    public int IngredientRowsWouldDeleteFromSource { get; set; }
    public int StepsWouldInsertToKeep { get; set; }
    public int StepsWouldDeleteFromSource { get; set; }
    public int TryLogRowsWouldRepoint { get; set; }
    public int GroupingRowsWouldInsertToKeep { get; set; }
    public int GroupingRowsWouldDeleteFromSource { get; set; }
}
