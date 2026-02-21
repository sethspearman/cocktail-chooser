using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using Microsoft.AspNetCore.Mvc;

namespace CocktailChooser.API.Controllers;

[Route("api/[controller]")]
[ApiController]
public class CocktailGroupingsController : ControllerBase
{
    private readonly ICocktailGroupingService _service;

    public CocktailGroupingsController(ICocktailGroupingService service)
    {
        _service = service;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<CocktailGroupingLinkDto>>> GetLinks([FromQuery] string groupingName)
    {
        if (string.IsNullOrWhiteSpace(groupingName))
        {
            return BadRequest("groupingName is required.");
        }

        var links = await _service.GetLinksByGroupingNameAsync(groupingName);
        return Ok(links);
    }

    [HttpGet("{groupingName}/cocktails")]
    public async Task<ActionResult<IEnumerable<CocktailGroupingCocktailDto>>> GetCocktailsByGroupingName(string groupingName)
    {
        var cocktails = await _service.GetCocktailsByGroupingNameAsync(groupingName);
        return Ok(cocktails);
    }

    [HttpPost]
    public async Task<ActionResult<CocktailGroupingLinkDto>> PostLink(CocktailGroupingLinkDto linkDto)
    {
        var created = await _service.UpsertLinkAsync(linkDto);
        return Ok(created);
    }

    [HttpPut("rename")]
    public async Task<IActionResult> RenameLink(CocktailGroupingRenameDto renameDto)
    {
        var updated = await _service.RenameLinkAsync(renameDto);
        if (!updated)
        {
            return NotFound();
        }

        return NoContent();
    }
}
