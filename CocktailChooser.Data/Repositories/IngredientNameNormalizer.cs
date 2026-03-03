using System.Text.RegularExpressions;

namespace CocktailChooser.Data.Repositories;

public static class IngredientNameNormalizer
{
    private static readonly Regex WhitespaceRegex = new(@"\s+", RegexOptions.Compiled);

    public static string Normalize(string? name)
    {
        var cleaned = CleanupDisplayName(name);
        return cleaned.ToLowerInvariant();
    }

    public static string CleanupDisplayName(string? name)
    {
        var trimmed = (name ?? string.Empty).Trim();
        return WhitespaceRegex.Replace(trimmed, " ");
    }
}
