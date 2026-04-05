using CocktailChooser.API.DTOs;
using CocktailChooser.Data.Repositories;

namespace CocktailChooser.API.Services;

public class CocktailAvailabilityService : ICocktailAvailabilityService
{
    private readonly ICocktailRepository _cocktailRepository;
    private readonly ICocktailIngredientRepository _cocktailIngredientRepository;
    private readonly IUserIngredientRepository _userIngredientRepository;
    private readonly IIngredientSubstitutionRepository _ingredientSubstitutionRepository;

    public CocktailAvailabilityService(
        ICocktailRepository cocktailRepository,
        ICocktailIngredientRepository cocktailIngredientRepository,
        IUserIngredientRepository userIngredientRepository,
        IIngredientSubstitutionRepository ingredientSubstitutionRepository)
    {
        _cocktailRepository = cocktailRepository;
        _cocktailIngredientRepository = cocktailIngredientRepository;
        _userIngredientRepository = userIngredientRepository;
        _ingredientSubstitutionRepository = ingredientSubstitutionRepository;
    }

    public async Task<CocktailAvailabilityDto?> GetAvailabilityForUserAsync(int cocktailId, int userId)
    {
        var cocktail = await _cocktailRepository.GetByIdAsync(cocktailId);
        if (cocktail is null)
        {
            return null;
        }

        var cocktailIngredients = (await _cocktailIngredientRepository.GetByCocktailIdAsync(cocktailId))
            .GroupBy(x => x.IngredientId)
            .Select(g => g.First())
            .ToList();

        var stockedIngredientIds = (await _userIngredientRepository.GetByUserIdAsync(userId))
            .Where(x => x.IsInStock == 1)
            .Select(x => x.IngredientId)
            .ToHashSet();

        var missingIngredients = cocktailIngredients
            .Where(x => !stockedIngredientIds.Contains(x.IngredientId))
            .ToList();

        var substitutions = (await _ingredientSubstitutionRepository.GetByIngredientIdsAsync(
                missingIngredients.Select(x => x.IngredientId)))
            .Where(x => stockedIngredientIds.Contains(x.SubstituteIngredientId))
            .ToList();

        var canMake = missingIngredients.Count == 0;
        var canMakeWithSubstitution = !canMake
            && missingIngredients.All(missing => substitutions.Any(x => x.IngredientId == missing.IngredientId));

        return new CocktailAvailabilityDto
        {
            CocktailId = cocktailId,
            CanMake = canMake,
            CanMakeWithSubstitution = canMakeWithSubstitution,
            MissingIngredients = missingIngredients
                .Select(x => new CocktailAvailabilityIngredientDto
                {
                    IngredientId = x.IngredientId,
                    IngredientName = x.IngredientName
                })
                .ToList(),
            SubstitutionsAvailable = substitutions
                .Select(x => new CocktailSubstitutionSuggestionDto
                {
                    MissingIngredientId = x.IngredientId,
                    MissingIngredientName = x.IngredientName,
                    SubstituteIngredientId = x.SubstituteIngredientId,
                    SubstituteIngredientName = x.SubstituteIngredientName,
                    ConfidenceScore = x.ConfidenceScore,
                    Notes = x.Notes
                })
                .ToList()
        };
    }
}
