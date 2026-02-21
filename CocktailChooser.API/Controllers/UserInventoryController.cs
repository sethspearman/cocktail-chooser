using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using Microsoft.AspNetCore.Mvc;

namespace CocktailChooser.API.Controllers;

[Route("api/users/{userId:int}/inventory")]
[ApiController]
public class UserInventoryController : ControllerBase
{
    private readonly IUserInventoryService _inventoryService;

    public UserInventoryController(IUserInventoryService inventoryService)
    {
        _inventoryService = inventoryService;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<UserIngredientDto>>> GetUserInventory(int userId)
    {
        var rows = await _inventoryService.GetUserInventoryAsync(userId);
        return Ok(rows);
    }

    [HttpPut("{ingredientId:int}")]
    public async Task<ActionResult<UserIngredientDto>> PutUserInventoryItem(
        int userId,
        int ingredientId,
        UserIngredientUpsertDto upsertDto)
    {
        var row = await _inventoryService.UpsertInventoryItemAsync(userId, ingredientId, upsertDto);
        return Ok(row);
    }

    [HttpDelete("{ingredientId:int}")]
    public async Task<IActionResult> DeleteUserInventoryItem(int userId, int ingredientId)
    {
        var deleted = await _inventoryService.DeleteInventoryItemAsync(userId, ingredientId);
        if (!deleted)
        {
            return NotFound();
        }

        return NoContent();
    }
}
