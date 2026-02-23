using CocktailChooser.API.Auth;
using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using Microsoft.AspNetCore.Mvc;

namespace CocktailChooser.API.Controllers;

[Route("api/[controller]")]
[ApiController]
public class AuthController : ControllerBase
{
    private readonly IAuthService _authService;
    private readonly ICurrentUserContext _currentUserContext;

    public AuthController(IAuthService authService, ICurrentUserContext currentUserContext)
    {
        _authService = authService;
        _currentUserContext = currentUserContext;
    }

    [HttpPost("register")]
    public async Task<ActionResult<AuthResponseDto>> Register(AuthRegisterRequestDto dto)
    {
        try
        {
            var result = await _authService.RegisterAsync(dto);
            return Ok(result);
        }
        catch (ArgumentException ex)
        {
            return BadRequest(ex.Message);
        }
        catch (InvalidOperationException ex)
        {
            return Conflict(ex.Message);
        }
    }

    [HttpPost("login")]
    public async Task<ActionResult<AuthResponseDto>> Login(AuthLoginRequestDto dto)
    {
        try
        {
            var result = await _authService.LoginAsync(dto);
            return Ok(result);
        }
        catch (UnauthorizedAccessException ex)
        {
            return Unauthorized(ex.Message);
        }
    }

    [HttpGet("me")]
    public async Task<ActionResult<UserDto>> Me()
    {
        if (!_currentUserContext.UserId.HasValue)
        {
            return Unauthorized();
        }

        var user = await _authService.GetUserAsync(_currentUserContext.UserId.Value);
        if (user == null)
        {
            return Unauthorized();
        }

        return Ok(user);
    }
}
