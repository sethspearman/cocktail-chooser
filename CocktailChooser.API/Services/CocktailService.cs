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
    private readonly IOcrRecipeParser _recipeParser;

    public CocktailService(
        ICocktailRepository cocktailRepository,
        IIngredientRepository ingredientRepository,
        ICocktailIngredientRepository cocktailIngredientRepository,
        ICocktailRecipeRepository cocktailRecipeRepository,
        IAmountRepository amountRepository,
        IOcrRecipeParser recipeParser)
    {
        _cocktailRepository = cocktailRepository;
        _ingredientRepository = ingredientRepository;
        _cocktailIngredientRepository = cocktailIngredientRepository;
        _cocktailRecipeRepository = cocktailRecipeRepository;
        _amountRepository = amountRepository;
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
                        && c.SubmittedByUserId.GetValueOrDefault() == userId)
            .OrderBy(c => c.Name, StringComparer.OrdinalIgnoreCase)
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
            IsUserSubmitted = 1,
            SubmittedByUserId = userId
        };

        return await CreateCocktailAsync(dto);
    }

    public async Task<bool> ApproveCocktailAsync(int id)
    {
        var existing = await _cocktailRepository.GetByIdAsync(id);
        if (existing == null)
        {
            return false;
        }

        existing.IsApproved = 1;
        return await _cocktailRepository.UpdateAsync(existing);
    }

    public async Task<bool> RejectCocktailAsync(int id, bool delete)
    {
        var existing = await _cocktailRepository.GetByIdAsync(id);
        if (existing == null)
        {
            return false;
        }

        if (delete)
        {
            return await _cocktailRepository.DeleteAsync(id);
        }

        existing.IsApproved = 0;
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

        var createdCocktail = await _cocktailRepository.CreateAsync(MapToRecord(cocktailDto));

        await PopulateParsedRecipeDataAsync(createdCocktail, cocktailDto);

        return MapToDto(createdCocktail);
    }

    public async Task<bool> UpdateCocktailAsync(CocktailDto cocktailDto)
    {
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
            Name = cocktail.Name,
            Description = cocktail.Description,
            Method = cocktail.Method,
            GlassTypeId = cocktail.GlassTypeId,
            TimePeriodId = cocktail.TimePeriodId,
            IsPopular = cocktail.IsPopular,
            IsApproved = cocktail.IsApproved,
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
            Name = cocktail.Name,
            Description = cocktail.Description,
            Method = cocktail.Method,
            GlassTypeId = cocktail.GlassTypeId,
            TimePeriodId = cocktail.TimePeriodId,
            IsPopular = cocktail.IsPopular,
            IsApproved = cocktail.IsApproved,
            IsUserSubmitted = cocktail.IsUserSubmitted,
            SubmittedByUserId = cocktail.SubmittedByUserId,
            CocktailSourceId = cocktail.CocktailSourceId
        };
    }

    private static bool IsApprovedForPublicRead(CocktailRecord cocktail)
    {
        return cocktail.IsApproved.GetValueOrDefault() == 1;
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
