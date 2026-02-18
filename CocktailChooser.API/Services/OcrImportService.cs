using CocktailChooser.API.DTOs;
using CocktailChooser.Data.Repositories;

namespace CocktailChooser.API.Services;

public class OcrImportService : IOcrImportService
{
    private readonly IOcrImportRepository _repository;
    private readonly IOcrRecipeParser _parser;

    public OcrImportService(IOcrImportRepository repository, IOcrRecipeParser parser)
    {
        _repository = repository;
        _parser = parser;
    }

    public async Task<OcrImportDto> CreateImportAsync(OcrImportCreateDto createDto)
    {
        var record = new OcrImportRecord
        {
            RecipeSourceId = createDto.RecipeSourceId,
            ImportName = createDto.ImportName,
            ImportType = createDto.ImportType,
            FileName = createDto.FileName,
            Notes = createDto.Notes,
            Status = "Pending"
        };

        var created = await _repository.CreateImportAsync(record);
        return MapImport(created, Enumerable.Empty<OcrImportItemRecord>());
    }

    public async Task<OcrImportDto?> GetImportAsync(int id)
    {
        var import = await _repository.GetImportByIdAsync(id);
        if (import == null)
        {
            return null;
        }

        var items = await _repository.GetImportItemsAsync(id);
        return MapImport(import, items);
    }

    public async Task<OcrImportItemDto> CreateImportItemAsync(int importId, OcrImportItemCreateDto createDto)
    {
        var import = await _repository.GetImportByIdAsync(importId);
        if (import == null)
        {
            throw new InvalidOperationException($"OCR import {importId} does not exist.");
        }

        var item = new OcrImportItemRecord
        {
            OcrImportId = importId,
            ItemKey = createDto.ItemKey,
            RawText = createDto.RawText,
            RawOcrJson = createDto.RawOcrJson,
            Confidence = createDto.Confidence,
            Status = "Pending"
        };

        var created = await _repository.CreateImportItemAsync(item);
        return MapImportItem(created);
    }

    public async Task<IEnumerable<OcrRecipeCandidateDto>> ParseItemAsync(int itemId)
    {
        var item = await _repository.GetImportItemByIdAsync(itemId);
        if (item == null)
        {
            return Enumerable.Empty<OcrRecipeCandidateDto>();
        }

        await _repository.UpdateImportItemStatusAsync(itemId, "Parsing");
        var parsed = _parser.Parse(item.RawText);
        await _repository.ReplaceCandidatesForItemAsync(itemId, parsed);
        await _repository.UpdateImportItemStatusAsync(itemId, "Parsed");

        return await GetItemCandidatesAsync(itemId);
    }

    public async Task<IEnumerable<OcrRecipeCandidateDto>> GetItemCandidatesAsync(int itemId)
    {
        var candidates = (await _repository.GetRecipeCandidatesByItemIdAsync(itemId)).ToList();
        var ingredientTasks = candidates.Select(c => _repository.GetIngredientCandidatesByRecipeCandidateIdAsync(c.Id)).ToList();
        var stepTasks = candidates.Select(c => _repository.GetStepCandidatesByRecipeCandidateIdAsync(c.Id)).ToList();

        await Task.WhenAll(ingredientTasks.Concat(stepTasks));

        var ingredientLookup = candidates
            .Select((candidate, idx) => new
            {
                candidate.Id,
                Ingredients = ingredientTasks[idx].Result.Select(MapIngredient).ToList()
            })
            .ToDictionary(x => x.Id, x => x.Ingredients);

        var stepLookup = candidates
            .Select((candidate, idx) => new
            {
                candidate.Id,
                Steps = stepTasks[idx].Result.Select(MapStep).ToList()
            })
            .ToDictionary(x => x.Id, x => x.Steps);

        return candidates.Select(c => new OcrRecipeCandidateDto
        {
            Id = c.Id,
            OcrImportItemId = c.OcrImportItemId,
            CocktailName = c.CocktailName,
            SourceRecipeName = c.SourceRecipeName,
            MethodText = c.MethodText,
            ParserVersion = c.ParserVersion,
            Confidence = c.Confidence,
            Status = c.Status,
            ParseWarnings = c.ParseWarnings,
            CreatedUtc = c.CreatedUtc,
            Ingredients = ingredientLookup.TryGetValue(c.Id, out var ingredients) ? ingredients : new List<OcrIngredientCandidateDto>(),
            Steps = stepLookup.TryGetValue(c.Id, out var steps) ? steps : new List<OcrStepCandidateDto>()
        });
    }

    private static OcrImportDto MapImport(OcrImportRecord record, IEnumerable<OcrImportItemRecord> items)
    {
        return new OcrImportDto
        {
            Id = record.Id,
            RecipeSourceId = record.RecipeSourceId,
            ImportName = record.ImportName,
            ImportType = record.ImportType,
            FileName = record.FileName,
            Status = record.Status,
            Notes = record.Notes,
            CreatedUtc = record.CreatedUtc,
            CompletedUtc = record.CompletedUtc,
            Items = items.Select(MapImportItem).ToList()
        };
    }

    private static OcrImportItemDto MapImportItem(OcrImportItemRecord item)
    {
        return new OcrImportItemDto
        {
            Id = item.Id,
            OcrImportId = item.OcrImportId,
            ItemKey = item.ItemKey,
            RawText = item.RawText,
            RawOcrJson = item.RawOcrJson,
            Confidence = item.Confidence,
            Status = item.Status,
            CreatedUtc = item.CreatedUtc
        };
    }

    private static OcrIngredientCandidateDto MapIngredient(OcrIngredientCandidateRecord ingredient)
    {
        return new OcrIngredientCandidateDto
        {
            Id = ingredient.Id,
            OcrRecipeCandidateId = ingredient.OcrRecipeCandidateId,
            SortOrder = ingredient.SortOrder,
            RawLine = ingredient.RawLine,
            RawAmount = ingredient.RawAmount,
            RawIngredientName = ingredient.RawIngredientName,
            NormalizedAmountId = ingredient.NormalizedAmountId,
            NormalizedIngredientId = ingredient.NormalizedIngredientId,
            Confidence = ingredient.Confidence,
            ParseWarnings = ingredient.ParseWarnings,
            CreatedUtc = ingredient.CreatedUtc
        };
    }

    private static OcrStepCandidateDto MapStep(OcrStepCandidateRecord step)
    {
        return new OcrStepCandidateDto
        {
            Id = step.Id,
            OcrRecipeCandidateId = step.OcrRecipeCandidateId,
            StepNumber = step.StepNumber,
            Instruction = step.Instruction,
            Confidence = step.Confidence,
            CreatedUtc = step.CreatedUtc
        };
    }
}
