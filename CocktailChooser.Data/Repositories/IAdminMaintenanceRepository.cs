namespace CocktailChooser.Data.Repositories;

public interface IAdminMaintenanceRepository
{
    Task<IEnumerable<IngredientDuplicateCandidateRecord>> GetIngredientDuplicateCandidatesAsync();
    Task<IEnumerable<CocktailDuplicateCandidateRecord>> GetCocktailDuplicateCandidatesAsync();
    Task<IngredientMergePreviewRecord> PreviewIngredientMergeAsync(int keepIngredientId, int removeIngredientId);
    Task<IngredientMergeResultRecord> MergeIngredientAsync(int keepIngredientId, int removeIngredientId, int performedByUserId, string? reason);
    Task<CocktailMergePreviewRecord> PreviewCocktailMergeAsync(int keepCocktailId, int removeCocktailId);
    Task<CocktailMergeResultRecord> MergeCocktailAsync(int keepCocktailId, int removeCocktailId, int performedByUserId, string? reason);
}

public class IngredientDuplicateCandidateRecord
{
    public string NormalizedName { get; set; } = string.Empty;
    public int IngredientId { get; set; }
    public string Name { get; set; } = string.Empty;
    public int CocktailUsageCount { get; set; }
    public int UserUsageCount { get; set; }
}

public class IngredientMergeResultRecord
{
    public int KeepIngredientId { get; set; }
    public int RemoveIngredientId { get; set; }
    public int CocktailRowsRepointed { get; set; }
    public int CocktailDuplicateRowsDeleted { get; set; }
    public int UserRowsRemovedFromSource { get; set; }
}

public class IngredientMergePreviewRecord
{
    public int KeepIngredientId { get; set; }
    public int RemoveIngredientId { get; set; }
    public int CocktailRowsWouldRepoint { get; set; }
    public int CocktailDuplicateRowsWouldDelete { get; set; }
    public int UserRowsWouldRemoveFromSource { get; set; }
}

public class CocktailDuplicateCandidateRecord
{
    public string NormalizedName { get; set; } = string.Empty;
    public int CocktailId { get; set; }
    public string Name { get; set; } = string.Empty;
    public int? CocktailSourceId { get; set; }
    public string? CanonicalKey { get; set; }
    public int IngredientRowCount { get; set; }
    public int StepRowCount { get; set; }
    public int IsApproved { get; set; }
}

public class CocktailMergeResultRecord
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

public class CocktailMergePreviewRecord
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
