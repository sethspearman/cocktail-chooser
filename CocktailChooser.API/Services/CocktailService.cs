using System.Globalization;
using System.Text;
using System.Text.RegularExpressions;
using CocktailChooser.API.DTOs;
using CocktailChooser.Data.Repositories;

namespace CocktailChooser.API.Services;

public class CocktailService : ICocktailService
{
    private static readonly Regex LeadingBulletRegex = new(@"^\s*[-*•]+\s*", RegexOptions.Compiled);
    private static readonly Regex LeadingStepNumberRegex = new(@"^\s*\d+[\).\:-]\s*", RegexOptions.Compiled);
    private static readonly Regex ParentheticalRegex = new(@"\([^)]*\)", RegexOptions.Compiled);
    private static readonly Regex HeaderLineRegex = new(@"^(?<header>Name|Description|Ingredients|Steps|Flavor Profile|Time Period)\s*:\s*(?<value>.*)$", RegexOptions.Compiled | RegexOptions.IgnoreCase);
    private static readonly string[] AlcoholicIngredientTokens =
    {
        "vodka",
        "gin",
        "rum",
        "tequila",
        "mezcal",
        "whiskey",
        "whisky",
        "bourbon",
        "scotch",
        "brandy",
        "cognac",
        "liqueur",
        "liquor",
        "vermouth",
        "amaro",
        "aperol",
        "campari",
        "chartreuse",
        "cointreau",
        "triple sec",
        "absinthe",
        "port",
        "wine",
        "champagne",
        "prosecco",
        "kahlua",
        "bitters",
        "creme de"
    };

    private readonly ICocktailRepository _cocktailRepository;
    private readonly IIngredientRepository _ingredientRepository;
    private readonly ICocktailIngredientRepository _cocktailIngredientRepository;
    private readonly ICocktailRecipeRepository _cocktailRecipeRepository;
    private readonly IAmountRepository _amountRepository;
    private readonly IRecipeSourceRepository _recipeSourceRepository;
    private readonly IOcrRecipeParser _recipeParser;

    public CocktailService(
        ICocktailRepository cocktailRepository,
        IIngredientRepository ingredientRepository,
        ICocktailIngredientRepository cocktailIngredientRepository,
        ICocktailRecipeRepository cocktailRecipeRepository,
        IAmountRepository amountRepository,
        IRecipeSourceRepository recipeSourceRepository,
        IOcrRecipeParser recipeParser)
    {
        _cocktailRepository = cocktailRepository;
        _ingredientRepository = ingredientRepository;
        _cocktailIngredientRepository = cocktailIngredientRepository;
        _cocktailRecipeRepository = cocktailRecipeRepository;
        _amountRepository = amountRepository;
        _recipeSourceRepository = recipeSourceRepository;
        _recipeParser = recipeParser;
    }

    public async Task<IEnumerable<CocktailDto>> GetAllCocktailsAsync(
        IEnumerable<string>? includeIngredientNames = null,
        string? includeMode = null,
        string? alcoholFilter = null)
    {
        var cocktails = (await _cocktailRepository.GetAllAsync())
            .Where(IsApprovedForPublicRead)
            .ToList();
        var normalizedAlcoholFilter = NormalizeAlcoholFilter(alcoholFilter);
        var requestedIngredientNames = (includeIngredientNames ?? Array.Empty<string>())
            .Select(x => (x ?? string.Empty).Trim())
            .Where(x => x.Length > 0)
            .Distinct(StringComparer.OrdinalIgnoreCase)
            .ToList();

        var normalizedMode = string.Equals(includeMode, "any", StringComparison.OrdinalIgnoreCase)
            ? "any"
            : "all";
        var needsCocktailIngredientRows = requestedIngredientNames.Count > 0 || normalizedAlcoholFilter != "all";
        var cocktailIngredientRows = needsCocktailIngredientRows
            ? (await _cocktailIngredientRepository.GetAllAsync()).ToList()
            : new List<CocktailIngredientRecord>();
        var filteredCocktails = cocktails;

        if (normalizedAlcoholFilter != "all")
        {
            var ingredientRowsByCocktailId = cocktailIngredientRows
                .GroupBy(x => x.CocktailId)
                .ToDictionary(g => g.Key, g => g.ToList());

            filteredCocktails = filteredCocktails
                .Where(c =>
                {
                    ingredientRowsByCocktailId.TryGetValue(c.Id, out var rows);
                    return MatchesAlcoholFilter(rows, normalizedAlcoholFilter);
                })
                .ToList();
        }

        if (requestedIngredientNames.Count == 0)
        {
            return filteredCocktails.Select(MapToDto);
        }

        var ingredients = (await _ingredientRepository.GetAllAsync()).ToList();
        var ingredientIdsByName = ingredients
            .GroupBy(i => (i.Name ?? string.Empty).Trim(), StringComparer.OrdinalIgnoreCase)
            .ToDictionary(g => g.Key, g => g.Select(x => x.Id).ToList(), StringComparer.OrdinalIgnoreCase);

        var matchedRequestedIngredientIds = new HashSet<int>();
        var missingRequestedNameCount = 0;
        foreach (var name in requestedIngredientNames)
        {
            if (!ingredientIdsByName.TryGetValue(name, out var ids) || ids.Count == 0)
            {
                missingRequestedNameCount++;
                continue;
            }

            foreach (var id in ids)
            {
                matchedRequestedIngredientIds.Add(id);
            }
        }

        if (normalizedMode == "all" && missingRequestedNameCount > 0)
        {
            return Array.Empty<CocktailDto>();
        }

        if (matchedRequestedIngredientIds.Count == 0)
        {
            return Array.Empty<CocktailDto>();
        }

        var ingredientIdsByCocktailId = cocktailIngredientRows
            .GroupBy(x => x.CocktailId)
            .ToDictionary(
                g => g.Key,
                g => g.Select(x => x.IngredientId).ToHashSet());

        var matchingCocktailIds = filteredCocktails
            .Where(c =>
            {
                if (!ingredientIdsByCocktailId.TryGetValue(c.Id, out var cocktailIngredientIds) || cocktailIngredientIds.Count == 0)
                {
                    return false;
                }

                if (normalizedMode == "any")
                {
                    return matchedRequestedIngredientIds.Any(cocktailIngredientIds.Contains);
                }

                return requestedIngredientNames.All(name =>
                    ingredientIdsByName.TryGetValue(name, out var candidateIds)
                    && candidateIds.Any(cocktailIngredientIds.Contains));
            })
            .Select(c => c.Id)
            .ToHashSet();

        return filteredCocktails
            .Where(c => matchingCocktailIds.Contains(c.Id))
            .Select(MapToDto);
    }

    public async Task<IEnumerable<CocktailDto>> GetPendingCocktailsForUserAsync(int userId)
    {
        var cocktails = await _cocktailRepository.GetAllAsync();
        return cocktails
            .Where(c => c.IsApproved.GetValueOrDefault() == 0
                        && string.IsNullOrWhiteSpace(c.RejectedUtc)
                        && c.SubmittedByUserId.GetValueOrDefault() == userId)
            .OrderBy(c => c.Name, StringComparer.OrdinalIgnoreCase)
            .Select(MapToDto);
    }

    public async Task<IEnumerable<CocktailDto>> GetMyCocktailsForUserAsync(int userId)
    {
        var cocktails = await _cocktailRepository.GetAllAsync();
        return cocktails
            .Where(c => c.SubmittedByUserId.GetValueOrDefault() == userId
                        && c.IsUserSubmitted.GetValueOrDefault() == 1)
            .OrderByDescending(c => c.Id)
            .Select(MapToDto);
    }

    public async Task<IEnumerable<CocktailDto>> GetPendingCocktailsForAdminAsync()
    {
        var cocktails = await _cocktailRepository.GetAllAsync();
        return cocktails
            .Where(c => c.IsUserSubmitted.GetValueOrDefault() == 1
                        && c.IsApproved.GetValueOrDefault() == 0
                        && string.IsNullOrWhiteSpace(c.RejectedUtc))
            .OrderByDescending(c => c.Id)
            .Select(MapToDto);
    }

    public async Task<CocktailDto?> GetCocktailByIdAsync(int id)
    {
        var cocktail = await _cocktailRepository.GetByIdAsync(id);
        if (cocktail == null || !IsApprovedForPublicRead(cocktail))
        {
            return null;
        }

        return MapToDto(cocktail);
    }

    public async Task<IEnumerable<AdminCocktailPortDto>> ExportAdminCocktailsAsync(
        int? cocktailId = null,
        int? sourceId = null,
        int? offset = null,
        int? limit = null)
    {
        var cocktails = (await _cocktailRepository.GetAllAsync()).ToList();
        if (cocktailId.HasValue)
        {
            cocktails = cocktails.Where(c => c.Id == cocktailId.Value).ToList();
        }

        if (sourceId.HasValue)
        {
            cocktails = cocktails.Where(c => c.CocktailSourceId == sourceId.Value).ToList();
        }

        var normalizedOffset = Math.Max(offset.GetValueOrDefault(0), 0);
        var normalizedLimit = limit.HasValue ? Math.Max(limit.Value, 0) : (int?)null;
        IEnumerable<CocktailRecord> orderedCocktails = cocktails.OrderBy(c => c.Name, StringComparer.OrdinalIgnoreCase);
        if (normalizedOffset > 0)
        {
            orderedCocktails = orderedCocktails.Skip(normalizedOffset);
        }

        if (normalizedLimit.HasValue)
        {
            orderedCocktails = orderedCocktails.Take(normalizedLimit.Value);
        }

        var result = new List<AdminCocktailPortDto>();
        foreach (var cocktail in orderedCocktails)
        {
            var ingredientRows = (await _cocktailIngredientRepository.GetByCocktailIdAsync(cocktail.Id)).ToList();
            var stepRows = (await _cocktailRecipeRepository.GetByCocktailIdAsync(cocktail.Id))
                .OrderBy(s => s.StepNumber)
                .ToList();

            result.Add(new AdminCocktailPortDto
            {
                CocktailId = cocktail.Id,
                CanonicalKey = cocktail.CanonicalKey,
                Name = cocktail.Name,
                Description = cocktail.Description,
                Method = cocktail.Method,
                GlassTypeId = cocktail.GlassTypeId,
                TimePeriodId = cocktail.TimePeriodId,
                IsPopular = cocktail.IsPopular,
                IsApproved = cocktail.IsApproved,
                ApprovedUtc = cocktail.ApprovedUtc,
                ApprovedByUserId = cocktail.ApprovedByUserId,
                RejectedUtc = cocktail.RejectedUtc,
                IsUserSubmitted = cocktail.IsUserSubmitted,
                SubmittedByUserId = cocktail.SubmittedByUserId,
                CocktailSourceId = cocktail.CocktailSourceId,
                StructuredIngredients = ingredientRows
                    .Select(x => new CocktailIngredientEntryDto
                    {
                        IngredientName = x.IngredientName,
                        AmountId = x.AmountId,
                        AmountText = x.AmountText
                    })
                    .ToList(),
                StructuredSteps = stepRows
                    .Select(x => new CocktailStepEntryDto
                    {
                        Instruction = x.Instruction
                    })
                    .ToList()
            });
        }

        return result;
    }

    public async Task<AdminCocktailImportResultDto> ImportAdminCocktailsAsync(AdminCocktailImportRequestDto request)
    {
        var response = new AdminCocktailImportResultDto();
        var inputCocktails = request?.Cocktails ?? new List<AdminCocktailPortDto>();

        for (var index = 0; index < inputCocktails.Count; index++)
        {
            var item = inputCocktails[index];
            var itemResult = new AdminCocktailImportItemResultDto { InputIndex = index };

            try
            {
                if (string.IsNullOrWhiteSpace(item.Name))
                {
                    throw new ArgumentException("Name is required.");
                }

                var existing = item.CocktailId.HasValue
                    ? await _cocktailRepository.GetByIdAsync(item.CocktailId.Value)
                    : !string.IsNullOrWhiteSpace(item.CanonicalKey)
                    ? await _cocktailRepository.GetByCanonicalKeyAsync(NormalizeCanonicalKey(item.CanonicalKey))
                    : null;

                var importRecord = new AdminCocktailImportRecord
                {
                    CocktailId = item.CocktailId,
                    CanonicalKey = item.CanonicalKey,
                    Name = item.Name.Trim(),
                    Description = NullIfWhiteSpace(item.Description),
                    Method = NullIfWhiteSpace(item.Method),
                    GlassTypeId = item.GlassTypeId,
                    TimePeriodId = item.TimePeriodId,
                    IsPopular = item.IsPopular,
                    IsApproved = item.IsApproved,
                    ApprovedUtc = item.ApprovedUtc,
                    ApprovedByUserId = item.ApprovedByUserId,
                    RejectedUtc = item.RejectedUtc,
                    IsUserSubmitted = item.IsUserSubmitted,
                    SubmittedByUserId = item.SubmittedByUserId,
                    CocktailSourceId = item.CocktailSourceId,
                    Ingredients = (item.StructuredIngredients ?? new List<CocktailIngredientEntryDto>())
                        .Where(x => !string.IsNullOrWhiteSpace(x.IngredientName))
                        .Select(x => new AdminCocktailImportIngredientRecord
                        {
                            IngredientName = x.IngredientName!.Trim(),
                            AmountId = x.AmountId,
                            AmountText = NullIfWhiteSpace(x.AmountText)
                        })
                        .ToList(),
                    Steps = (item.StructuredSteps ?? new List<CocktailStepEntryDto>())
                        .Where(x => !string.IsNullOrWhiteSpace(x.Instruction))
                        .Select(x => new AdminCocktailImportStepRecord
                        {
                            Instruction = x.Instruction!.Trim()
                        })
                        .ToList()
                };

                var savedRecord = await _cocktailRepository.UpsertAdminImportAsync(importRecord);

                if (existing == null)
                {
                    response.Created++;
                    itemResult.Action = "created";
                }
                else
                {
                    response.Updated++;
                    itemResult.Action = "updated";
                }

                itemResult.CocktailId = savedRecord.Id;
                itemResult.CanonicalKey = savedRecord.CanonicalKey;
            }
            catch (Exception ex)
            {
                response.Failed++;
                itemResult.Action = "failed";
                itemResult.Error = ex.Message;
            }

            response.Items.Add(itemResult);
        }

        return response;
    }

    public async Task<CocktailTextPreviewResponseDto> PreviewFromTextAsync(CocktailTextPreviewRequestDto requestDto)
    {
        var draft = ParsePasteDraft(requestDto.RawText);
        var response = new CocktailTextPreviewResponseDto
        {
            Name = draft.Name,
            Description = draft.Description,
            FlavorProfile = draft.FlavorProfile,
            TimePeriodName = draft.TimePeriodName,
            Steps = draft.Steps
        };

        response.Errors.AddRange(draft.Errors);

        var ingredients = (await _ingredientRepository.GetAllAsync()).ToList();
        foreach (var ingredientName in draft.Ingredients)
        {
            var exists = FindBestIngredientMatch(ingredientName, ingredients) != null;
            response.Ingredients.Add(new CocktailTextIngredientPreviewDto
            {
                Name = ingredientName,
                IsNew = !exists
            });
        }

        if (!string.IsNullOrWhiteSpace(draft.TimePeriodName))
        {
            var timePeriods = (await _cocktailRepository.GetTimePeriodsAsync()).ToList();
            var match = timePeriods.FirstOrDefault(x => string.Equals(x.Name, draft.TimePeriodName, StringComparison.OrdinalIgnoreCase));
            if (match == null)
            {
                response.Errors.Add($"Unknown time period: '{draft.TimePeriodName}'. Choose an existing time period.");
            }
            else
            {
                response.MatchedTimePeriodId = match.Id;
            }
        }

        return response;
    }

    public async Task<CocktailDto> SubmitFromTextAsync(CocktailTextSubmitRequestDto requestDto, int userId)
    {
        var preview = await PreviewFromTextAsync(new CocktailTextPreviewRequestDto
        {
            RawText = requestDto.RawText
        });

        if (!preview.IsValid)
        {
            throw new ArgumentException(string.Join(" ", preview.Errors));
        }

        var timePeriodId = requestDto.TimePeriodIdOverride ?? preview.MatchedTimePeriodId;
        var ingredientLines = preview.Ingredients.Select(x => x.Name).ToList();
        var stepLines = preview.Steps.ToList();
        var methodText = stepLines.Count > 0 ? string.Join(". ", stepLines) : null;

        var dto = new CocktailDto
        {
            Name = preview.Name!,
            Description = preview.Description,
            Method = methodText,
            IngredientLines = ingredientLines.Count > 0 ? string.Join('\n', ingredientLines) : null,
            StepLines = stepLines.Count > 0 ? string.Join('\n', stepLines) : null,
            FlavorProfile = preview.FlavorProfile,
            StructuredIngredients = ingredientLines
                .Select(x => new CocktailIngredientEntryDto
                {
                    IngredientName = x
                })
                .ToList(),
            StructuredSteps = stepLines
                .Select(x => new CocktailStepEntryDto
                {
                    Instruction = x
                })
                .ToList(),
            TimePeriodId = timePeriodId,
            CocktailSourceId = requestDto.CocktailSourceId,
            IsPopular = 0,
            IsApproved = 0,
            ApprovedUtc = null,
            ApprovedByUserId = null,
            RejectedUtc = null,
            IsUserSubmitted = 1,
            SubmittedByUserId = userId
        };

        return await CreateCocktailAsync(dto);
    }

    public async Task<bool> ApproveCocktailAsync(int id, int approvedByUserId)
    {
        var existing = await _cocktailRepository.GetByIdAsync(id);
        if (existing == null)
        {
            return false;
        }

        existing.IsApproved = 1;
        existing.ApprovedUtc = DateTime.UtcNow.ToString("O");
        existing.ApprovedByUserId = approvedByUserId;
        existing.RejectedUtc = null;
        return await _cocktailRepository.UpdateAsync(existing);
    }

    public async Task<bool> RejectCocktailAsync(int id)
    {
        var existing = await _cocktailRepository.GetByIdAsync(id);
        if (existing == null)
        {
            return false;
        }

        existing.IsApproved = 0;
        existing.RejectedUtc = DateTime.UtcNow.ToString("O");
        return await _cocktailRepository.UpdateAsync(existing);
    }

    public async Task<CocktailDto> CreateCocktailAsync(CocktailDto cocktailDto)
    {
        if (string.IsNullOrWhiteSpace(cocktailDto.Name))
        {
            throw new ArgumentException("Cocktail name is required.", nameof(cocktailDto));
        }

        cocktailDto.Name = cocktailDto.Name.Trim();
        cocktailDto.Description = NullIfWhiteSpace(cocktailDto.Description);
        cocktailDto.Method = NullIfWhiteSpace(cocktailDto.Method);
        cocktailDto.IngredientLines = NullIfWhiteSpace(cocktailDto.IngredientLines);
        cocktailDto.StepLines = NullIfWhiteSpace(cocktailDto.StepLines);
        cocktailDto.IsApproved ??= 0;
        cocktailDto.IsUserSubmitted ??= 0;
        cocktailDto.CanonicalKey = await BuildUniqueCanonicalKeyAsync(cocktailDto);

        var createdCocktail = await _cocktailRepository.CreateAsync(MapToRecord(cocktailDto));

        await PopulateParsedRecipeDataAsync(createdCocktail, cocktailDto);

        return MapToDto(createdCocktail);
    }

    public async Task<bool> UpdateCocktailAsync(CocktailDto cocktailDto)
    {
        var existing = await _cocktailRepository.GetByIdAsync(cocktailDto.Id);
        if (existing == null)
        {
            return false;
        }

        cocktailDto.IsApproved ??= existing.IsApproved;
        cocktailDto.ApprovedUtc ??= existing.ApprovedUtc;
        cocktailDto.ApprovedByUserId ??= existing.ApprovedByUserId;
        cocktailDto.RejectedUtc ??= existing.RejectedUtc;
        cocktailDto.IsUserSubmitted ??= existing.IsUserSubmitted;
        cocktailDto.SubmittedByUserId ??= existing.SubmittedByUserId;

        cocktailDto.CanonicalKey = await BuildUniqueCanonicalKeyAsync(cocktailDto, cocktailDto.Id);
        return await _cocktailRepository.UpdateAsync(MapToRecord(cocktailDto));
    }

    public async Task<bool> DeleteCocktailAsync(int id)
    {
        return await _cocktailRepository.DeleteAsync(id);
    }

    private async Task PopulateParsedRecipeDataAsync(CocktailRecord createdCocktail, CocktailDto requestDto)
    {
        var structuredIngredients = (requestDto.StructuredIngredients ?? new List<CocktailIngredientEntryDto>())
            .Where(x => !string.IsNullOrWhiteSpace(x.IngredientName))
            .Select((x, idx) => new
            {
                SortOrder = idx + 1,
                AmountId = x.AmountId,
                IngredientName = x.IngredientName!.Trim(),
                AmountText = NullIfWhiteSpace(x.AmountText)
            })
            .ToList();

        var structuredSteps = (requestDto.StructuredSteps ?? new List<CocktailStepEntryDto>())
            .Where(x => !string.IsNullOrWhiteSpace(x.Instruction))
            .Select((x, idx) => new OcrParsedStepDraft
            {
                StepNumber = idx + 1,
                Instruction = x.Instruction!.Trim()
            })
            .ToList();

        var ingredientLines = SplitInputLines(requestDto.IngredientLines);
        var stepLines = SplitInputLines(requestDto.StepLines);

        if (structuredIngredients.Count == 0
            && structuredSteps.Count == 0
            && ingredientLines.Count == 0
            && stepLines.Count == 0
            && string.IsNullOrWhiteSpace(requestDto.Method))
        {
            return;
        }

        var parserInput = BuildParserInput(createdCocktail.Name, ingredientLines, stepLines, requestDto.Method);
        var parsed = _recipeParser.Parse(parserInput).FirstOrDefault();
        if (parsed == null)
        {
            return;
        }

        var allIngredients = (await _ingredientRepository.GetAllAsync()).ToList();
        var allAmounts = (await _amountRepository.GetAllAsync()).ToList();

        if (structuredIngredients.Count > 0)
        {
            foreach (var row in structuredIngredients)
            {
                var matchedIngredient = FindBestIngredientMatch(row.IngredientName, allIngredients);
                if (matchedIngredient == null)
                {
                    matchedIngredient = await _ingredientRepository.CreateAsync(new IngredientRecord
                    {
                        Name = row.IngredientName
                    });
                    allIngredients.Add(matchedIngredient);
                }

                var amountMatch = row.AmountId.HasValue
                    ? allAmounts.FirstOrDefault(a => a.Id == row.AmountId.Value)
                    : FindBestAmountMatch(row.AmountText, allAmounts);
                var amountText = amountMatch == null ? row.AmountText : null;

                await _cocktailIngredientRepository.CreateAsync(new CocktailIngredientRecord
                {
                    CocktailId = createdCocktail.Id,
                    IngredientId = matchedIngredient.Id,
                    AmountId = amountMatch?.Id,
                    AmountText = amountText,
                    SortOrder = row.SortOrder
                });
            }
        }
        else
        {
            foreach (var parsedIngredient in parsed.Ingredients.OrderBy(i => i.SortOrder))
            {
                var rawIngredientName = NullIfWhiteSpace(parsedIngredient.RawIngredientName)
                    ?? ExtractIngredientNameFallback(parsedIngredient.RawLine);
                if (string.IsNullOrWhiteSpace(rawIngredientName))
                {
                    continue;
                }

                var matchedIngredient = FindBestIngredientMatch(rawIngredientName, allIngredients);
                if (matchedIngredient == null)
                {
                    matchedIngredient = await _ingredientRepository.CreateAsync(new IngredientRecord
                    {
                        Name = ToTitleLikeName(rawIngredientName)
                    });
                    allIngredients.Add(matchedIngredient);
                }

                var amountMatch = FindBestAmountMatch(parsedIngredient.RawAmount, allAmounts);
                var amountText = amountMatch == null ? NullIfWhiteSpace(parsedIngredient.RawAmount) : null;

                await _cocktailIngredientRepository.CreateAsync(new CocktailIngredientRecord
                {
                    CocktailId = createdCocktail.Id,
                    IngredientId = matchedIngredient.Id,
                    AmountId = amountMatch?.Id,
                    AmountText = amountText,
                    SortOrder = parsedIngredient.SortOrder > 0 ? parsedIngredient.SortOrder : null
                });
            }
        }

        // Structured UI now sends explicit step lines. Use them as canonical to avoid
        // collapsing multiple steps into one when lines don't end with periods.
        var parsedSteps = structuredSteps.Count > 0
            ? structuredSteps
            : stepLines.Count > 0
            ? stepLines.Select((line, idx) => new OcrParsedStepDraft
                {
                    StepNumber = idx + 1,
                    Instruction = line
                })
                .ToList()
            : parsed.Steps
                .Where(s => !string.IsNullOrWhiteSpace(s.Instruction))
                .OrderBy(s => s.StepNumber)
                .ToList();

        foreach (var step in parsedSteps)
        {
            await _cocktailRecipeRepository.CreateAsync(new CocktailRecipeRecord
            {
                CocktailId = createdCocktail.Id,
                StepNumber = step.StepNumber > 0 ? step.StepNumber : 1,
                Instruction = step.Instruction.Trim()
            });
        }
    }

    private static ParsedPasteDraft ParsePasteDraft(string? rawText)
    {
        var draft = new ParsedPasteDraft();
        var text = (rawText ?? string.Empty).Replace("\r\n", "\n");
        var lines = text.Split('\n');
        var sectionLines = new Dictionary<string, List<string>>(StringComparer.OrdinalIgnoreCase);
        string? currentHeader = null;

        foreach (var rawLine in lines)
        {
            var line = rawLine ?? string.Empty;
            var headerMatch = HeaderLineRegex.Match(line);
            if (headerMatch.Success)
            {
                currentHeader = NormalizeHeaderName(headerMatch.Groups["header"].Value);
                if (!sectionLines.ContainsKey(currentHeader))
                {
                    sectionLines[currentHeader] = new List<string>();
                }

                var firstValue = headerMatch.Groups["value"].Value.Trim();
                if (firstValue.Length > 0)
                {
                    sectionLines[currentHeader].Add(firstValue);
                }

                continue;
            }

            if (string.IsNullOrWhiteSpace(line))
            {
                continue;
            }

            if (currentHeader == null)
            {
                draft.Errors.Add("Paste format must include section headers like 'Name:' and 'Ingredients:'.");
                continue;
            }

            sectionLines[currentHeader].Add(line.Trim());
        }

        var requiredHeaders = new[] { "name", "description", "ingredients", "steps" };
        foreach (var required in requiredHeaders)
        {
            if (!sectionLines.ContainsKey(required))
            {
                draft.Errors.Add($"Missing required header: {HeaderDisplayName(required)}:");
            }
        }

        draft.Name = JoinSection(sectionLines, "name");
        draft.Description = JoinSection(sectionLines, "description");
        draft.FlavorProfile = JoinSection(sectionLines, "flavor profile");
        draft.TimePeriodName = JoinSection(sectionLines, "time period");

        if (string.IsNullOrWhiteSpace(draft.Name))
        {
            draft.Errors.Add("Name is required.");
        }

        draft.Ingredients = (sectionLines.TryGetValue("ingredients", out var ingredientLines) ? ingredientLines : new List<string>())
            .Select(CleanListPrefix)
            .Select(ExtractIngredientNameFromLine)
            .Where(x => !string.IsNullOrWhiteSpace(x))
            .Distinct(StringComparer.OrdinalIgnoreCase)
            .ToList();

        if (draft.Ingredients.Count == 0)
        {
            draft.Errors.Add("At least one ingredient is required.");
        }

        draft.Steps = (sectionLines.TryGetValue("steps", out var stepLines) ? stepLines : new List<string>())
            .Select(CleanListPrefix)
            .Where(x => !string.IsNullOrWhiteSpace(x))
            .ToList();

        if (draft.Steps.Count == 0)
        {
            draft.Errors.Add("At least one step is required.");
        }

        return draft;
    }

    private static string NormalizeHeaderName(string header)
    {
        return header.Trim().ToLowerInvariant();
    }

    private static string HeaderDisplayName(string normalizedHeader)
    {
        return normalizedHeader switch
        {
            "flavor profile" => "Flavor Profile",
            "time period" => "Time Period",
            "name" => "Name",
            "description" => "Description",
            "ingredients" => "Ingredients",
            "steps" => "Steps",
            _ => normalizedHeader
        };
    }

    private static string? JoinSection(IReadOnlyDictionary<string, List<string>> sections, string key)
    {
        if (!sections.TryGetValue(key, out var lines))
        {
            return null;
        }

        var joined = string.Join('\n', lines.Select(x => x.Trim()).Where(x => x.Length > 0));
        return string.IsNullOrWhiteSpace(joined) ? null : joined;
    }

    private static string ExtractIngredientNameFromLine(string line)
    {
        var trimmed = line.Trim();
        if (trimmed.Length == 0)
        {
            return trimmed;
        }

        var commaIndex = trimmed.IndexOf(',');
        if (commaIndex >= 0 && commaIndex < trimmed.Length - 1)
        {
            return trimmed[(commaIndex + 1)..].Trim();
        }

        return ExtractIngredientNameFallback(trimmed);
    }

    private static string BuildParserInput(string cocktailName, IReadOnlyList<string> ingredientLines, IReadOnlyList<string> stepLines, string? methodText)
    {
        var sb = new StringBuilder();
        sb.AppendLine(cocktailName);

        if (ingredientLines.Count > 0)
        {
            sb.AppendLine("Ingredients");
            foreach (var line in ingredientLines)
            {
                sb.AppendLine(line);
            }
        }

        var normalizedSteps = stepLines.Count > 0
            ? stepLines
            : SplitInputLines(methodText);

        if (normalizedSteps.Count > 0)
        {
            sb.AppendLine("Method");
            foreach (var line in normalizedSteps)
            {
                sb.AppendLine(line);
            }
        }

        return sb.ToString();
    }

    private static List<string> SplitInputLines(string? raw)
    {
        if (string.IsNullOrWhiteSpace(raw))
        {
            return new List<string>();
        }

        return raw
            .Replace("\r\n", "\n")
            .Split('\n', StringSplitOptions.TrimEntries | StringSplitOptions.RemoveEmptyEntries)
            .Select(CleanListPrefix)
            .Where(x => !string.IsNullOrWhiteSpace(x))
            .ToList();
    }

    private static string CleanListPrefix(string line)
    {
        var cleaned = LeadingBulletRegex.Replace(line, string.Empty);
        cleaned = LeadingStepNumberRegex.Replace(cleaned, string.Empty);
        return cleaned.Trim();
    }

    private static IngredientRecord? FindBestIngredientMatch(string rawIngredientName, IReadOnlyList<IngredientRecord> ingredients)
    {
        var raw = rawIngredientName.Trim();
        if (raw.Length == 0 || ingredients.Count == 0)
        {
            return null;
        }

        var exact = ingredients.FirstOrDefault(i => string.Equals(i.Name, raw, StringComparison.OrdinalIgnoreCase));
        if (exact != null)
        {
            return exact;
        }

        var normalizedRaw = NormalizeIngredientName(raw);
        if (normalizedRaw.Length == 0)
        {
            return null;
        }

        var best = ingredients
            .Select(i => new
            {
                Ingredient = i,
                Score = ScoreIngredientMatch(normalizedRaw, NormalizeIngredientName(i.Name))
            })
            .OrderByDescending(x => x.Score)
            .ThenBy(x => x.Ingredient.Name.Length)
            .FirstOrDefault();

        return best is { Score: >= 0.72 } ? best.Ingredient : null;
    }

    private static double ScoreIngredientMatch(string raw, string candidate)
    {
        if (raw == candidate)
        {
            return 1.0;
        }

        if (raw.Length == 0 || candidate.Length == 0)
        {
            return 0;
        }

        if (raw.Contains(candidate, StringComparison.Ordinal) || candidate.Contains(raw, StringComparison.Ordinal))
        {
            return 0.85;
        }

        var rawTokens = raw.Split(' ', StringSplitOptions.RemoveEmptyEntries);
        var candidateTokens = candidate.Split(' ', StringSplitOptions.RemoveEmptyEntries);
        if (rawTokens.Length == 0 || candidateTokens.Length == 0)
        {
            return 0;
        }

        var rawSet = rawTokens.ToHashSet(StringComparer.Ordinal);
        var candidateSet = candidateTokens.ToHashSet(StringComparer.Ordinal);
        var overlap = rawSet.Intersect(candidateSet).Count();
        var union = rawSet.Union(candidateSet).Count();
        var jaccard = union == 0 ? 0 : (double)overlap / union;

        var prefixBoost = rawTokens[0] == candidateTokens[0] ? 0.08 : 0.0;
        return Math.Min(0.99, jaccard + prefixBoost);
    }

    private static AmountRecord? FindBestAmountMatch(string? rawAmount, IReadOnlyList<AmountRecord> amounts)
    {
        var cleaned = NullIfWhiteSpace(rawAmount);
        if (cleaned == null)
        {
            return null;
        }

        var exact = amounts.FirstOrDefault(a =>
            string.Equals(a.MeasurementName, cleaned, StringComparison.OrdinalIgnoreCase));
        if (exact != null)
        {
            return exact;
        }

        var normalizedRaw = NormalizeAmount(cleaned);
        return amounts.FirstOrDefault(a => NormalizeAmount(a.MeasurementName) == normalizedRaw);
    }

    private static string NormalizeAmount(string input)
    {
        var value = RemoveDiacritics(input).ToLowerInvariant().Trim();
        value = value.Replace("fluid ounce", "fl oz")
            .Replace("fluid ounces", "fl oz")
            .Replace("ounces", "oz")
            .Replace("ounce", "oz")
            .Replace("dashes", "dashes")
            .Replace("dash", "dash");
        value = Regex.Replace(value, @"\bbarspoon\b", "bar spoon");
        value = Regex.Replace(value, @"\s+", " ");
        return value;
    }

    private static string NormalizeIngredientName(string input)
    {
        var value = RemoveDiacritics(input).ToLowerInvariant();
        value = ParentheticalRegex.Replace(value, " ");
        value = value.Replace("&", " and ");
        value = value.Replace("-", " ");
        value = Regex.Replace(value, @"\b(fresh|freshly|squeezed|freshly squeezed|freshly squeezed)\b", " ");
        value = Regex.Replace(value, @"\b(optional|for garnish|garnish)\b", " ");
        value = Regex.Replace(value, @"[^a-z0-9\s]", " ");
        value = Regex.Replace(value, @"\s+", " ").Trim();
        value = value.Replace("whisky", "whiskey");
        value = value.Replace("creme", "cream"); // intentionally broad for diacritic/encoding issues
        return value;
    }

    private static string RemoveDiacritics(string input)
    {
        var normalized = input.Normalize(NormalizationForm.FormD);
        var sb = new StringBuilder(normalized.Length);
        foreach (var c in normalized)
        {
            if (CharUnicodeInfo.GetUnicodeCategory(c) != UnicodeCategory.NonSpacingMark)
            {
                sb.Append(c);
            }
        }

        return sb.ToString().Normalize(NormalizationForm.FormC);
    }

    private static string ExtractIngredientNameFallback(string rawLine)
    {
        if (string.IsNullOrWhiteSpace(rawLine))
        {
            return string.Empty;
        }

        var line = CleanListPrefix(rawLine);
        var parts = line.Split(',', 2, StringSplitOptions.TrimEntries);
        return parts.Length == 2 ? parts[1] : line;
    }

    private static string ToTitleLikeName(string raw)
    {
        var trimmed = Regex.Replace(raw.Trim(), @"\s+", " ");
        if (trimmed.Length == 0)
        {
            return trimmed;
        }

        return char.ToUpperInvariant(trimmed[0]) + trimmed[1..];
    }

    private static string? NullIfWhiteSpace(string? value)
    {
        return string.IsNullOrWhiteSpace(value) ? null : value.Trim();
    }

    private static string NormalizeAlcoholFilter(string? filter)
    {
        if (string.Equals(filter, "alcoholic", StringComparison.OrdinalIgnoreCase))
        {
            return "alcoholic";
        }

        if (string.Equals(filter, "non-alcoholic", StringComparison.OrdinalIgnoreCase)
            || string.Equals(filter, "nonalcoholic", StringComparison.OrdinalIgnoreCase))
        {
            return "non-alcoholic";
        }

        return "all";
    }

    private static bool MatchesAlcoholFilter(IReadOnlyList<CocktailIngredientRecord>? rows, string filter)
    {
        var isAlcoholic = IsAlcoholic(rows);
        return filter switch
        {
            "alcoholic" => isAlcoholic,
            "non-alcoholic" => !isAlcoholic,
            _ => true
        };
    }

    private static bool IsAlcoholic(IReadOnlyList<CocktailIngredientRecord>? rows)
    {
        if (rows == null || rows.Count == 0)
        {
            return false;
        }

        foreach (var row in rows)
        {
            if (!string.IsNullOrWhiteSpace(row.PrimarySpirit))
            {
                return true;
            }

            var ingredientName = (row.IngredientName ?? string.Empty).Trim().ToLowerInvariant();
            if (ingredientName.Length == 0)
            {
                continue;
            }

            if (ingredientName.Contains("non-alcoholic", StringComparison.Ordinal)
                || ingredientName.Contains("non alcoholic", StringComparison.Ordinal)
                || ingredientName.Contains("alcohol-free", StringComparison.Ordinal)
                || ingredientName.Contains("alcohol free", StringComparison.Ordinal))
            {
                continue;
            }

            if (ContainsAlcoholicToken(ingredientName))
            {
                return true;
            }
        }

        return false;
    }

    private static bool ContainsAlcoholicToken(string ingredientName)
    {
        var normalized = NormalizeIngredientForAlcoholCheck(ingredientName);
        if (normalized.Length == 0)
        {
            return false;
        }

        return AlcoholicIngredientTokens.Any(token =>
            normalized.Contains($" {token} ", StringComparison.Ordinal));
    }

    private static string NormalizeIngredientForAlcoholCheck(string ingredientName)
    {
        var normalized = Regex.Replace(ingredientName.ToLowerInvariant(), @"[^a-z0-9\s]", " ");
        normalized = Regex.Replace(normalized, @"\s+", " ").Trim();
        return normalized.Length == 0 ? string.Empty : $" {normalized} ";
    }

    private static CocktailDto MapToDto(CocktailRecord cocktail)
    {
        return new CocktailDto
        {
            Id = cocktail.Id,
            CanonicalKey = cocktail.CanonicalKey,
            Name = cocktail.Name,
            Description = cocktail.Description,
            Method = cocktail.Method,
            GlassTypeId = cocktail.GlassTypeId,
            TimePeriodId = cocktail.TimePeriodId,
            IsPopular = cocktail.IsPopular,
            IsApproved = cocktail.IsApproved,
            ApprovedUtc = cocktail.ApprovedUtc,
            ApprovedByUserId = cocktail.ApprovedByUserId,
            RejectedUtc = cocktail.RejectedUtc,
            ModerationStatus = GetModerationStatus(cocktail),
            IsUserSubmitted = cocktail.IsUserSubmitted,
            SubmittedByUserId = cocktail.SubmittedByUserId,
            CocktailSourceId = cocktail.CocktailSourceId
        };
    }

    private static CocktailRecord MapToRecord(CocktailDto cocktail)
    {
        return new CocktailRecord
        {
            Id = cocktail.Id,
            CanonicalKey = cocktail.CanonicalKey ?? string.Empty,
            Name = cocktail.Name,
            Description = cocktail.Description,
            Method = cocktail.Method,
            GlassTypeId = cocktail.GlassTypeId,
            TimePeriodId = cocktail.TimePeriodId,
            IsPopular = cocktail.IsPopular,
            IsApproved = cocktail.IsApproved,
            ApprovedUtc = cocktail.ApprovedUtc,
            ApprovedByUserId = cocktail.ApprovedByUserId,
            RejectedUtc = cocktail.RejectedUtc,
            IsUserSubmitted = cocktail.IsUserSubmitted,
            SubmittedByUserId = cocktail.SubmittedByUserId,
            CocktailSourceId = cocktail.CocktailSourceId
        };
    }

    private static string GetModerationStatus(CocktailRecord cocktail)
    {
        if (cocktail.IsApproved.GetValueOrDefault() == 1)
        {
            return "approved";
        }

        if (!string.IsNullOrWhiteSpace(cocktail.RejectedUtc))
        {
            return "rejected";
        }

        return "pending";
    }

    private static bool IsApprovedForPublicRead(CocktailRecord cocktail)
    {
        return cocktail.IsApproved.GetValueOrDefault() == 1;
    }

    private async Task<string> BuildUniqueCanonicalKeyAsync(CocktailDto cocktailDto, int? existingCocktailId = null)
    {
        var canonicalKeyBase = string.IsNullOrWhiteSpace(cocktailDto.CanonicalKey)
            ? BuildCanonicalKeyBase(await ResolveCanonicalSourceTokenAsync(cocktailDto.CocktailSourceId), cocktailDto.Name)
            : NormalizeCanonicalKey(cocktailDto.CanonicalKey);
        if (!await _cocktailRepository.IsCanonicalKeyInUseAsync(canonicalKeyBase, existingCocktailId))
        {
            return canonicalKeyBase;
        }

        var suffix = 2;
        while (true)
        {
            var candidate = $"{canonicalKeyBase}_{suffix}";
            if (!await _cocktailRepository.IsCanonicalKeyInUseAsync(candidate, existingCocktailId))
            {
                return candidate;
            }

            suffix++;
        }
    }

    private async Task<string> ResolveCanonicalSourceTokenAsync(int? cocktailSourceId)
    {
        if (!cocktailSourceId.HasValue)
        {
            return "manual";
        }

        var source = await _recipeSourceRepository.GetByIdAsync(cocktailSourceId.Value);
        return source == null || string.IsNullOrWhiteSpace(source.Name) ? "manual" : source.Name;
    }

    private static string BuildCanonicalKeyBase(string sourceToken, string cocktailName)
    {
        var normalizedSource = NormalizeCanonicalToken(sourceToken);
        var normalizedName = NormalizeCanonicalToken(cocktailName);
        return $"{normalizedSource}::{normalizedName}";
    }

    private static string NormalizeCanonicalKey(string? canonicalKey)
    {
        if (string.IsNullOrWhiteSpace(canonicalKey))
        {
            return "unknown::unknown";
        }

        var separatorIndex = canonicalKey.IndexOf("::", StringComparison.Ordinal);
        if (separatorIndex < 0)
        {
            return NormalizeCanonicalToken(canonicalKey);
        }

        var sourceToken = canonicalKey[..separatorIndex];
        var nameToken = canonicalKey[(separatorIndex + 2)..];
        return $"{NormalizeCanonicalToken(sourceToken)}::{NormalizeCanonicalToken(nameToken)}";
    }

    private static string NormalizeCanonicalToken(string? input)
    {
        if (string.IsNullOrWhiteSpace(input))
        {
            return "unknown";
        }

        var normalized = input.ToLowerInvariant().Trim();
        normalized = Regex.Replace(normalized, @"[^a-z0-9]+", "_");
        normalized = Regex.Replace(normalized, @"_+", "_").Trim('_');
        return normalized.Length == 0 ? "unknown" : normalized;
    }

    private sealed class ParsedPasteDraft
    {
        public string? Name { get; set; }
        public string? Description { get; set; }
        public string? FlavorProfile { get; set; }
        public string? TimePeriodName { get; set; }
        public List<string> Ingredients { get; set; } = new();
        public List<string> Steps { get; set; } = new();
        public List<string> Errors { get; } = new();
    }
}
