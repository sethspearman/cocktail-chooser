using CocktailChooser.API.Auth;
using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using Microsoft.AspNetCore.Mvc;

namespace CocktailChooser.API.Controllers;

[Route("api/users/{userId:int}/inventory")]
[ApiController]
public class UserInventoryController : ControllerBase
{
    private readonly IUserInventoryService _inventoryService;
    private readonly ICurrentUserContext _currentUserContext;

    public UserInventoryController(IUserInventoryService inventoryService, ICurrentUserContext currentUserContext)
    {
        _inventoryService = inventoryService;
        _currentUserContext = currentUserContext;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<UserIngredientDto>>> GetUserInventory(int userId)
    {
        if (!IsAuthorizedUser(userId))
        {
            return Unauthorized();
        }

        var rows = await _inventoryService.GetUserInventoryAsync(userId);
        return Ok(rows);
    }

    [HttpPut("{ingredientId:int}")]
    public async Task<ActionResult<UserIngredientDto>> PutUserInventoryItem(
        int userId,
        int ingredientId,
        UserIngredientUpsertDto upsertDto)
    {
        if (!IsAuthorizedUser(userId))
        {
            return Unauthorized();
        }

        var row = await _inventoryService.UpsertInventoryItemAsync(userId, ingredientId, upsertDto);
        return Ok(row);
    }

    [HttpDelete("{ingredientId:int}")]
    public async Task<IActionResult> DeleteUserInventoryItem(int userId, int ingredientId)
    {
        if (!IsAuthorizedUser(userId))
        {
            return Unauthorized();
        }

        var deleted = await _inventoryService.DeleteInventoryItemAsync(userId, ingredientId);
        if (!deleted)
        {
            return NotFound();
        }

        return NoContent();
    }

    private bool IsAuthorizedUser(int userId)
    {
        return _currentUserContext.UserId.HasValue && _currentUserContext.UserId.Value == userId;
    }
}
