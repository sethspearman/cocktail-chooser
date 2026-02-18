using CocktailChooser.API.DTOs;

namespace CocktailChooser.API.Services;

public interface IOcrImportService
{
    Task<OcrImportDto> CreateImportAsync(OcrImportCreateDto createDto);
    Task<OcrImportDto?> GetImportAsync(int id);
    Task<OcrImportItemDto> CreateImportItemAsync(int importId, OcrImportItemCreateDto createDto);
    Task<IEnumerable<OcrRecipeCandidateDto>> ParseItemAsync(int itemId);
    Task<IEnumerable<OcrRecipeCandidateDto>> GetItemCandidatesAsync(int itemId);
}
