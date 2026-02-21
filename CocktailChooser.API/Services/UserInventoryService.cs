using CocktailChooser.API.DTOs;
using CocktailChooser.Data.Repositories;

namespace CocktailChooser.API.Services;

public class UserInventoryService : IUserInventoryService
{
    private readonly IUserIngredientRepository _repository;

    public UserInventoryService(IUserIngredientRepository repository)
    {
        _repository = repository;
    }

    public async Task<IEnumerable<UserIngredientDto>> GetUserInventoryAsync(int userId)
    {
        var rows = await _repository.GetByUserIdAsync(userId);
        return rows.Select(MapToDto);
    }

    public async Task<UserIngredientDto> UpsertInventoryItemAsync(int userId, int ingredientId, UserIngredientUpsertDto upsertDto)
    {
        var row = await _repository.UpsertAsync(
            userId,
            ingredientId,
            upsertDto.IsInStock ? 1 : 0,
            upsertDto.Notes,
            DateTime.UtcNow.ToString("O"));

        return MapToDto(row);
    }

    public async Task<bool> DeleteInventoryItemAsync(int userId, int ingredientId)
    {
        return await _repository.DeleteAsync(userId, ingredientId);
    }

    private static UserIngredientDto MapToDto(UserIngredientRecord row)
    {
        return new UserIngredientDto
        {
            UserId = row.UserId,
            IngredientId = row.IngredientId,
            IngredientName = row.IngredientName,
            IsInStock = row.IsInStock == 1,
            Notes = row.Notes,
            UpdatedUtc = row.UpdatedUtc
        };
    }
}
