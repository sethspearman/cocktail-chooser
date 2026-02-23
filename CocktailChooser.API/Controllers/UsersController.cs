using CocktailChooser.API.Auth;
using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using Microsoft.AspNetCore.Mvc;

namespace CocktailChooser.API.Controllers;

[Route("api/[controller]")]
[ApiController]
public class UsersController : ControllerBase
{
    private readonly IUserService _userService;
    private readonly ICurrentUserContext _currentUserContext;

    public UsersController(IUserService userService, ICurrentUserContext currentUserContext)
    {
        _userService = userService;
        _currentUserContext = currentUserContext;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<UserDto>>> GetUsers()
    {
        if (!_currentUserContext.UserId.HasValue)
        {
            return Unauthorized();
        }

        var user = await _userService.GetUserByIdAsync(_currentUserContext.UserId.Value);
        if (user == null)
        {
            return NotFound();
        }

        return Ok(new[] { user });
    }

    [HttpGet("{id:int}")]
    public async Task<ActionResult<UserDto>> GetUser(int id)
    {
        if (!IsAuthorizedUser(id))
        {
            return Unauthorized();
        }

        var user = await _userService.GetUserByIdAsync(id);
        if (user == null)
        {
            return NotFound();
        }

        return Ok(user);
    }

    [HttpPost]
    public ActionResult<UserDto> PostUser(UserDto userDto)
    {
        return BadRequest("Use /api/auth/register to create an account.");
    }

    [HttpPut("{id:int}")]
    public async Task<IActionResult> PutUser(int id, UserDto userDto)
    {
        if (!IsAuthorizedUser(id))
        {
            return Unauthorized();
        }

        if (id != userDto.Id)
        {
            return BadRequest();
        }

        var updated = await _userService.UpdateUserAsync(userDto);
        if (!updated)
        {
            return NotFound();
        }

        return NoContent();
    }

    [HttpDelete("{id:int}")]
    public async Task<IActionResult> DeleteUser(int id)
    {
        if (!IsAuthorizedUser(id))
        {
            return Unauthorized();
        }

        var deleted = await _userService.DeleteUserAsync(id);
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
