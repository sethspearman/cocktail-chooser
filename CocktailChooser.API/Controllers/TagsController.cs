using CocktailChooser.API.Auth;
using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using Microsoft.AspNetCore.Mvc;

namespace CocktailChooser.API.Controllers;

[Route("api/[controller]")]
[ApiController]
public class TagsController : ControllerBase
{
    private readonly ICocktailTagService _service;
    private readonly ICurrentUserContext _currentUserContext;

    public TagsController(ICocktailTagService service, ICurrentUserContext currentUserContext)
    {
        _service = service;
        _currentUserContext = currentUserContext;
    }

    [HttpGet("types")]
    public async Task<ActionResult<IEnumerable<TagTypeDto>>> GetTagTypes()
    {
        var tagTypes = await _service.GetTagTypesAsync();
        return Ok(tagTypes);
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<TagDto>>> GetTags([FromQuery] int? tagTypeId = null, [FromQuery] string? tagType = null)
    {
        var tags = await _service.GetTagsAsync(tagTypeId, string.IsNullOrWhiteSpace(tagType) ? null : tagType.Trim());
        return Ok(tags);
    }

    [HttpGet("cocktails/{cocktailId:int}")]
    public async Task<ActionResult<IEnumerable<TagDto>>> GetCocktailTags(int cocktailId)
    {
        var tags = await _service.GetCocktailTagsAsync(cocktailId);
        return Ok(tags);
    }

    [HttpPost("cocktails/{cocktailId:int}/{tagId:int}")]
    public async Task<IActionResult> AssignTagToCocktail(int cocktailId, int tagId)
    {
        if (!IsAdminUser())
        {
            return Forbid();
        }

        await _service.AssignTagToCocktailAsync(cocktailId, tagId);
        return NoContent();
    }

    [HttpDelete("cocktails/{cocktailId:int}/{tagId:int}")]
    public async Task<IActionResult> RemoveTagFromCocktail(int cocktailId, int tagId)
    {
        if (!IsAdminUser())
        {
            return Forbid();
        }

        var removed = await _service.RemoveTagFromCocktailAsync(cocktailId, tagId);
        if (!removed)
        {
            return NotFound();
        }

        return NoContent();
    }

    private bool IsAdminUser()
    {
        return _currentUserContext.UserId.HasValue && _currentUserContext.UserId.Value == 1;
    }
}
