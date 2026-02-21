using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using Microsoft.AspNetCore.Mvc;

namespace CocktailChooser.API.Controllers;

[Route("api/[controller]")]
[ApiController]
public class CocktailTryLogsController : ControllerBase
{
    private readonly ICocktailTryLogService _service;

    public CocktailTryLogsController(ICocktailTryLogService service)
    {
        _service = service;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<CocktailTryLogDto>>> GetCocktailTryLogs(
        [FromQuery] int? cocktailId,
        [FromQuery] int? userId)
    {
        if (cocktailId.HasValue)
        {
            var logsByCocktail = await _service.GetCocktailTryLogsByCocktailIdAsync(cocktailId.Value, userId);
            return Ok(logsByCocktail);
        }

        if (userId.HasValue)
        {
            var logsByUser = await _service.GetCocktailTryLogsByUserIdAsync(userId.Value);
            return Ok(logsByUser);
        }

        return BadRequest("Provide cocktailId or userId.");
    }

    [HttpGet("{id:int}")]
    public async Task<ActionResult<CocktailTryLogDto>> GetCocktailTryLog(int id)
    {
        var log = await _service.GetCocktailTryLogByIdAsync(id);
        if (log == null)
        {
            return NotFound();
        }

        return Ok(log);
    }

    [HttpPost]
    public async Task<ActionResult<CocktailTryLogDto>> PostCocktailTryLog(CocktailTryLogDto logDto)
    {
        var created = await _service.CreateCocktailTryLogAsync(logDto);
        return CreatedAtAction(nameof(GetCocktailTryLog), new { id = created.Id }, created);
    }

    [HttpPut("{id:int}")]
    public async Task<IActionResult> PutCocktailTryLog(int id, CocktailTryLogDto logDto)
    {
        if (id != logDto.Id)
        {
            return BadRequest();
        }

        var updated = await _service.UpdateCocktailTryLogAsync(logDto);
        if (!updated)
        {
            return NotFound();
        }

        return NoContent();
    }

    [HttpDelete("{id:int}")]
    public async Task<IActionResult> DeleteCocktailTryLog(int id)
    {
        var deleted = await _service.DeleteCocktailTryLogAsync(id);
        if (!deleted)
        {
            return NotFound();
        }

        return NoContent();
    }
}
