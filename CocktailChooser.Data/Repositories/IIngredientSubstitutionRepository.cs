namespace CocktailChooser.Data.Repositories;

public interface IIngredientSubstitutionRepository
{
    Task<IEnumerable<IngredientSubstitutionRecord>> GetByIngredientIdsAsync(IEnumerable<int> ingredientIds);
}
