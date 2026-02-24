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

    public async Task<IEnumerable<CocktailDto>> GetAllCocktailsAsync()
    {
        var cocktails = await _cocktailRepository.GetAllAsync();
        return cocktails.Select(MapToDto);
    }

    public async Task<CocktailDto?> GetCocktailByIdAsync(int id)
    {
        var cocktail = await _cocktailRepository.GetByIdAsync(id);
        if (cocktail == null)
        {
            return null;
        }

        return MapToDto(cocktail);
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

                var amountMatch = FindBestAmountMatch(row.AmountText, allAmounts);
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
            CocktailSourceId = cocktail.CocktailSourceId
        };
    }
}
