using System.Globalization;
using System.Text.RegularExpressions;

namespace CocktailChooser.API.Services;

public static class AmountDisplayFormatter
{
    private static readonly Regex NumberTokenRegex = new(@"\b\d+(?:\.\d+)?\b", RegexOptions.Compiled);

    public static string? FormatForIngredient(string? amountOriginalText, string? amountName, string? amountText)
    {
        var source = !string.IsNullOrWhiteSpace(amountOriginalText)
            ? amountOriginalText
            : !string.IsNullOrWhiteSpace(amountName)
            ? amountName
            : amountText;
        return Format(source);
    }

    public static string? Format(string? value)
    {
        var cleaned = NormalizeWhitespace(value);
        if (cleaned is null)
        {
            return null;
        }

        var normalizedFractions = cleaned
            .Replace("1/4", "¼", StringComparison.Ordinal)
            .Replace("1/2", "½", StringComparison.Ordinal)
            .Replace("3/4", "¾", StringComparison.Ordinal);

        var converted = NumberTokenRegex.Replace(
            normalizedFractions,
            static match => ConvertDecimalTokenToFraction(match.Value));

        return converted;
    }

    private static string ConvertDecimalTokenToFraction(string token)
    {
        if (!token.Contains('.', StringComparison.Ordinal))
        {
            return token;
        }

        if (!double.TryParse(token, NumberStyles.Float, CultureInfo.InvariantCulture, out var numeric) ||
            !double.IsFinite(numeric))
        {
            return token;
        }

        var whole = Math.Truncate(numeric);
        var fractional = numeric - whole;
        const double epsilon = 0.0001;

        string fractionGlyph;
        if (Math.Abs(fractional - 0.25) < epsilon)
        {
            fractionGlyph = "¼";
        }
        else if (Math.Abs(fractional - 0.5) < epsilon)
        {
            fractionGlyph = "½";
        }
        else if (Math.Abs(fractional - 0.75) < epsilon)
        {
            fractionGlyph = "¾";
        }
        else if (Math.Abs(fractional) < epsilon)
        {
            return whole.ToString(CultureInfo.InvariantCulture);
        }
        else
        {
            return token;
        }

        if (whole == 0)
        {
            return fractionGlyph;
        }

        return $"{whole.ToString(CultureInfo.InvariantCulture)}{fractionGlyph}";
    }

    private static string? NormalizeWhitespace(string? value)
    {
        if (string.IsNullOrWhiteSpace(value))
        {
            return null;
        }

        return Regex.Replace(value.Trim(), @"\s+", " ");
    }
}
