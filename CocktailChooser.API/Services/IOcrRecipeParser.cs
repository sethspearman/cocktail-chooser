using CocktailChooser.Data.Repositories;

namespace CocktailChooser.API.Services;

public interface IOcrRecipeParser
{
    IReadOnlyList<OcrParsedRecipeDraft> Parse(string rawText);
}
