namespace CocktailChooser.Data.Repositories;

public interface IOcrImportRepository
{
    Task<OcrImportRecord?> GetImportByIdAsync(int id);
    Task<IEnumerable<OcrImportItemRecord>> GetImportItemsAsync(int importId);
    Task<OcrImportRecord> CreateImportAsync(OcrImportRecord importRecord);
    Task<OcrImportItemRecord> CreateImportItemAsync(OcrImportItemRecord importItemRecord);
    Task<OcrImportItemRecord?> GetImportItemByIdAsync(int itemId);
    Task<bool> UpdateImportItemStatusAsync(int itemId, string status);
    Task ReplaceCandidatesForItemAsync(int itemId, IEnumerable<OcrParsedRecipeDraft> drafts);
    Task<IEnumerable<OcrRecipeCandidateRecord>> GetRecipeCandidatesByItemIdAsync(int itemId);
    Task<IEnumerable<OcrIngredientCandidateRecord>> GetIngredientCandidatesByRecipeCandidateIdAsync(int recipeCandidateId);
    Task<IEnumerable<OcrStepCandidateRecord>> GetStepCandidatesByRecipeCandidateIdAsync(int recipeCandidateId);
}
