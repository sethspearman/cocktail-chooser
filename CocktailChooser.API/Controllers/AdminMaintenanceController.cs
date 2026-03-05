using CocktailChooser.API.Auth;
using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using Microsoft.AspNetCore.Mvc;

namespace CocktailChooser.API.Controllers;

[Route("api/admin/maintenance")]
[ApiController]
public class AdminMaintenanceController : ControllerBase
{
    private readonly IAdminMaintenanceService _service;
    private readonly ICurrentUserContext _currentUserContext;

    public AdminMaintenanceController(IAdminMaintenanceService service, ICurrentUserContext currentUserContext)
    {
        _service = service;
        _currentUserContext = currentUserContext;
    }

    [HttpGet("ingredient-duplicates")]
    public async Task<ActionResult<IngredientDuplicateGroupsResponseDto>> GetIngredientDuplicates()
    {
        if (!IsAdminUser())
        {
            return StatusCode(StatusCodes.Status403Forbidden);
        }

        var result = await _service.GetIngredientDuplicateGroupsAsync();
        return Ok(result);
    }

    [HttpGet("cocktail-duplicates")]
    public async Task<ActionResult<CocktailDuplicateGroupsResponseDto>> GetCocktailDuplicates()
    {
        if (!IsAdminUser())
        {
            return StatusCode(StatusCodes.Status403Forbidden);
        }

        var result = await _service.GetCocktailDuplicateGroupsAsync();
        return Ok(result);
    }

    [HttpPost("ingredient-merge")]
    public async Task<ActionResult<IngredientMergeResultDto>> MergeIngredient([FromBody] IngredientMergeRequestDto request)
    {
        if (!IsAdminUser())
        {
            return StatusCode(StatusCodes.Status403Forbidden);
        }

        try
        {
            var result = await _service.MergeIngredientAsync(request, _currentUserContext.UserId!.Value);
            return Ok(result);
        }
        catch (ArgumentException ex)
        {
            return BadRequest(ex.Message);
        }
        catch (InvalidOperationException ex)
        {
            return BadRequest(ex.Message);
        }
    }

    [HttpPost("ingredient-merge/dry-run")]
    public async Task<ActionResult<IngredientMergePreviewDto>> PreviewIngredientMerge([FromBody] IngredientMergeRequestDto request)
    {
        if (!IsAdminUser())
        {
            return StatusCode(StatusCodes.Status403Forbidden);
        }

        try
        {
            var preview = await _service.PreviewIngredientMergeAsync(request);
            return Ok(preview);
        }
        catch (ArgumentException ex)
        {
            return BadRequest(ex.Message);
        }
        catch (InvalidOperationException ex)
        {
            return BadRequest(ex.Message);
        }
    }

    [HttpPost("cocktail-merge")]
    public async Task<ActionResult<CocktailMergeResultDto>> MergeCocktail([FromBody] CocktailMergeRequestDto request)
    {
        if (!IsAdminUser())
        {
            return StatusCode(StatusCodes.Status403Forbidden);
        }

        try
        {
            var result = await _service.MergeCocktailAsync(request, _currentUserContext.UserId!.Value);
            return Ok(result);
        }
        catch (ArgumentException ex)
        {
            return BadRequest(ex.Message);
        }
        catch (InvalidOperationException ex)
        {
            return BadRequest(ex.Message);
        }
    }

    [HttpPost("cocktail-merge/dry-run")]
    public async Task<ActionResult<CocktailMergePreviewDto>> PreviewCocktailMerge([FromBody] CocktailMergeRequestDto request)
    {
        if (!IsAdminUser())
        {
            return StatusCode(StatusCodes.Status403Forbidden);
        }

        try
        {
            var preview = await _service.PreviewCocktailMergeAsync(request);
            return Ok(preview);
        }
        catch (ArgumentException ex)
        {
            return BadRequest(ex.Message);
        }
        catch (InvalidOperationException ex)
        {
            return BadRequest(ex.Message);
        }
    }

    private bool IsAdminUser()
    {
        return _currentUserContext.UserId.HasValue && _currentUserContext.UserId.Value == 1;
    }
}
