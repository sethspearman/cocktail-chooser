using CocktailChooser.API.DTOs;
using CocktailChooser.Data.Repositories;

namespace CocktailChooser.API.Services;

public class CocktailIngredientService : ICocktailIngredientService
{
    private readonly ICocktailIngredientRepository _repository;

    public CocktailIngredientService(ICocktailIngredientRepository repository)
    {
        _repository = repository;
    }

    public async Task<IEnumerable<CocktailIngredientDto>> GetAllCocktailIngredientsAsync()
    {
        var rows = await _repository.GetAllAsync();
        return rows.Select(MapToDto);
    }

    public async Task<IEnumerable<CocktailIngredientDto>> GetCocktailIngredientsByCocktailIdAsync(int cocktailId)
    {
        var rows = await _repository.GetByCocktailIdAsync(cocktailId);
        return rows.Select(MapToDto);
    }

    private static CocktailIngredientDto MapToDto(CocktailIngredientRecord row)
    {
        return new CocktailIngredientDto
        {
            Id = row.Id,
            CocktailId = row.CocktailId,
            IngredientId = row.IngredientId,
            IngredientName = row.IngredientName,
            PrimarySpirit = row.PrimarySpirit,
            AmountId = row.AmountId,
            AmountName = row.AmountName,
            AmountText = row.AmountText,
            SortOrder = row.SortOrder
        };
    }
}
