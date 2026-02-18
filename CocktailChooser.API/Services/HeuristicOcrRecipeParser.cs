using System.Text.RegularExpressions;
using CocktailChooser.Data.Repositories;

namespace CocktailChooser.API.Services;

public class HeuristicOcrRecipeParser : IOcrRecipeParser
{
    private static readonly Regex AmountPrefixRegex = new(
        @"^\s*(?<amount>(\d+(\.\d+)?|\d+/\d+|to\s+\w+|dash(?:es)?|bar\s+spoon|teaspoon|tablespoon|oz|fl\s*oz)\b[^,;-]*)[\s,;-]+(?<name>.+)$",
        RegexOptions.IgnoreCase | RegexOptions.Compiled);

    public IReadOnlyList<OcrParsedRecipeDraft> Parse(string rawText)
    {
        if (string.IsNullOrWhiteSpace(rawText))
        {
            return Array.Empty<OcrParsedRecipeDraft>();
        }

        var lines = rawText
            .Replace("\r\n", "\n")
            .Split('\n')
            .Select(line => line.Trim())
            .Where(line => !string.IsNullOrWhiteSpace(line))
            .ToList();

        if (lines.Count == 0)
        {
            return Array.Empty<OcrParsedRecipeDraft>();
        }

        var title = lines[0];
        var ingredientLines = new List<string>();
        var methodLines = new List<string>();
        var warnings = new List<string>();

        var mode = SectionMode.Unknown;
        for (var i = 1; i < lines.Count; i++)
        {
            var line = lines[i];
            var lower = line.ToLowerInvariant();

            if (lower is "ingredients" or "ingredient" or "ingredients:")
            {
                mode = SectionMode.Ingredients;
                continue;
            }

            if (lower is "method" or "method:" or "directions" or "instructions" or "preparation")
            {
                mode = SectionMode.Method;
                continue;
            }

            if (mode == SectionMode.Unknown)
            {
                if (LooksLikeIngredient(line))
                {
                    ingredientLines.Add(line);
                }
                else
                {
                    methodLines.Add(line);
                }
            }
            else if (mode == SectionMode.Ingredients)
            {
                ingredientLines.Add(line);
            }
            else
            {
                methodLines.Add(line);
            }
        }

        if (ingredientLines.Count == 0)
        {
            warnings.Add("No explicit ingredient lines were detected.");
        }

        if (methodLines.Count == 0)
        {
            warnings.Add("No explicit method/instruction lines were detected.");
        }

        var ingredients = ingredientLines
            .Select((line, index) => ParseIngredientLine(line, index + 1))
            .ToList();

        var steps = ParseSteps(methodLines);
        var methodText = methodLines.Count > 0 ? string.Join(" ", methodLines) : null;

        return
        [
            new OcrParsedRecipeDraft
            {
                CocktailName = title,
                SourceRecipeName = title,
                MethodText = methodText,
                ParserVersion = "heuristic-v1",
                Confidence = 0.6,
                ParseWarnings = warnings.Count > 0 ? string.Join(" | ", warnings) : null,
                Ingredients = ingredients,
                Steps = steps
            }
        ];
    }

    private static bool LooksLikeIngredient(string line)
    {
        if (AmountPrefixRegex.IsMatch(line))
        {
            return true;
        }

        var lower = line.ToLowerInvariant();
        return lower.Contains(" oz") || lower.StartsWith("dash") || lower.Contains(" to top");
    }

    private static OcrParsedIngredientDraft ParseIngredientLine(string line, int sortOrder)
    {
        var match = AmountPrefixRegex.Match(line);
        if (match.Success)
        {
            return new OcrParsedIngredientDraft
            {
                SortOrder = sortOrder,
                RawLine = line,
                RawAmount = match.Groups["amount"].Value.Trim(),
                RawIngredientName = match.Groups["name"].Value.Trim(),
                Confidence = 0.65
            };
        }

        return new OcrParsedIngredientDraft
        {
            SortOrder = sortOrder,
            RawLine = line,
            RawIngredientName = line,
            Confidence = 0.4,
            ParseWarnings = "Could not split amount from ingredient."
        };
    }

    private static List<OcrParsedStepDraft> ParseSteps(List<string> methodLines)
    {
        if (methodLines.Count == 0)
        {
            return new List<OcrParsedStepDraft>();
        }

        var merged = string.Join(" ", methodLines);
        var chunks = merged
            .Split('.', StringSplitOptions.TrimEntries | StringSplitOptions.RemoveEmptyEntries)
            .Select(x => x.Trim())
            .Where(x => !string.IsNullOrWhiteSpace(x))
            .ToList();

        if (chunks.Count == 0)
        {
            chunks = methodLines;
        }

        return chunks
            .Select((chunk, idx) => new OcrParsedStepDraft
            {
                StepNumber = idx + 1,
                Instruction = chunk,
                Confidence = 0.55
            })
            .ToList();
    }

    private enum SectionMode
    {
        Unknown = 0,
        Ingredients = 1,
        Method = 2
    }
}
