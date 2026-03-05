using System.Globalization;
using System.Text.RegularExpressions;

namespace CocktailChooser.Data.Repositories;

public static class AmountCanonicalizer
{
    private static readonly Regex WhitespaceRegex = new(@"\s+", RegexOptions.Compiled);
    private static readonly Regex NumericWithUnitRegex = new(
        @"^(?<value>(?:\d+(?:\.\d+)?|\d+/\d+)(?:\s+\d+/\d+)?)\s*(?<unit>fl\s*oz|oz|ounce|ounces|ml|milliliter|milliliters|dash|dashes|tsp|teaspoon|teaspoons|tbsp|tablespoon|tablespoons|bar\s*spoon|barspoon|part|parts|drop|drops)\b",
        RegexOptions.Compiled | RegexOptions.IgnoreCase);
    private static readonly Regex AttachedMixedFractionRegex = new(@"(?<=\d)([¼½¾⅛⅓⅔])", RegexOptions.Compiled);

    public static CanonicalAmount Parse(string? rawAmountText)
    {
        var normalized = Normalize(rawAmountText);
        if (normalized is null)
        {
            return CanonicalAmount.Empty;
        }

        if (normalized is "to top")
        {
            return new CanonicalAmount(null, "top");
        }

        if (normalized is "to rinse" or "for rinse")
        {
            return new CanonicalAmount(null, "rinse");
        }

        var numericWithUnitMatch = NumericWithUnitRegex.Match(normalized);
        if (numericWithUnitMatch.Success)
        {
            var value = ParseNumericExpression(numericWithUnitMatch.Groups["value"].Value);
            var unit = NormalizeUnit(numericWithUnitMatch.Groups["unit"].Value);
            if (value.HasValue && unit is not null)
            {
                return new CanonicalAmount(value, unit);
            }
        }

        var countValue = ParseNumericExpression(normalized);
        if (countValue.HasValue)
        {
            return new CanonicalAmount(countValue, "count");
        }

        return CanonicalAmount.Empty;
    }

    public static CanonicalAmount FromAmountReference(string? measurementName, double? ounces)
    {
        var parsed = Parse(measurementName);
        if (parsed.HasData)
        {
            return parsed;
        }

        if (ounces.HasValue && double.IsFinite(ounces.Value))
        {
            return new CanonicalAmount(ounces.Value, "oz");
        }

        return CanonicalAmount.Empty;
    }

    private static string? Normalize(string? input)
    {
        if (string.IsNullOrWhiteSpace(input))
        {
            return null;
        }

        var value = input.Trim();
        value = AttachedMixedFractionRegex.Replace(value, " $1");
        value = value
            .Replace("¼", "1/4", StringComparison.Ordinal)
            .Replace("½", "1/2", StringComparison.Ordinal)
            .Replace("¾", "3/4", StringComparison.Ordinal)
            .Replace("⅛", "1/8", StringComparison.Ordinal)
            .Replace("⅓", "1/3", StringComparison.Ordinal)
            .Replace("⅔", "2/3", StringComparison.Ordinal);
        value = WhitespaceRegex.Replace(value, " ");
        return value.ToLowerInvariant();
    }

    private static string? NormalizeUnit(string raw)
    {
        var unit = WhitespaceRegex.Replace(raw.Trim().ToLowerInvariant(), " ");
        return unit switch
        {
            "fl oz" => "oz",
            "oz" => "oz",
            "ounce" => "oz",
            "ounces" => "oz",
            "ml" => "ml",
            "milliliter" => "ml",
            "milliliters" => "ml",
            "dash" => "dash",
            "dashes" => "dash",
            "tsp" => "tsp",
            "teaspoon" => "tsp",
            "teaspoons" => "tsp",
            "tbsp" => "tbsp",
            "tablespoon" => "tbsp",
            "tablespoons" => "tbsp",
            "bar spoon" => "barspoon",
            "barspoon" => "barspoon",
            "part" => "part",
            "parts" => "part",
            "drop" => "drop",
            "drops" => "drop",
            _ => null
        };
    }

    private static double? ParseNumericExpression(string? text)
    {
        if (string.IsNullOrWhiteSpace(text))
        {
            return null;
        }

        var tokens = text.Trim().Split(' ', StringSplitOptions.RemoveEmptyEntries);
        if (tokens.Length == 0)
        {
            return null;
        }

        double total = 0;
        foreach (var token in tokens)
        {
            if (token.Contains('/', StringComparison.Ordinal))
            {
                var parts = token.Split('/', StringSplitOptions.RemoveEmptyEntries);
                if (parts.Length != 2
                    || !double.TryParse(parts[0], NumberStyles.Integer, CultureInfo.InvariantCulture, out var numerator)
                    || !double.TryParse(parts[1], NumberStyles.Integer, CultureInfo.InvariantCulture, out var denominator)
                    || Math.Abs(denominator) < double.Epsilon)
                {
                    return null;
                }

                total += numerator / denominator;
                continue;
            }

            if (!double.TryParse(token, NumberStyles.Float, CultureInfo.InvariantCulture, out var numeric))
            {
                return null;
            }

            total += numeric;
        }

        return total;
    }
}

public readonly record struct CanonicalAmount(double? Value, string? Unit)
{
    public static CanonicalAmount Empty => new(null, null);
    public bool HasData => Value.HasValue || !string.IsNullOrWhiteSpace(Unit);
}
