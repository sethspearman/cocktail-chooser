using System.Text.RegularExpressions;

namespace CocktailChooser.Data.Repositories;

public static class TagSlugNormalizer
{
    private static readonly Regex NonAlphaNumericRegex = new(@"[^a-z0-9]+", RegexOptions.Compiled);

    public static string Normalize(string? value)
    {
        if (string.IsNullOrWhiteSpace(value))
        {
            return string.Empty;
        }

        var normalized = value.Trim().ToLowerInvariant();
        normalized = normalized.Replace("&", " and ");
        normalized = NonAlphaNumericRegex.Replace(normalized, "-").Trim('-');
        return normalized;
    }
}
