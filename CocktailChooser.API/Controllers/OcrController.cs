using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using Microsoft.AspNetCore.Mvc;

namespace CocktailChooser.API.Controllers;

[Route("api/ocr")]
[ApiController]
public class OcrController : ControllerBase
{
    private readonly IOcrImportService _ocrImportService;

    public OcrController(IOcrImportService ocrImportService)
    {
        _ocrImportService = ocrImportService;
    }

    [HttpPost("imports")]
    public async Task<ActionResult<OcrImportDto>> CreateImport(OcrImportCreateDto createDto)
    {
        var created = await _ocrImportService.CreateImportAsync(createDto);
        return CreatedAtAction(nameof(GetImport), new { id = created.Id }, created);
    }

    [HttpGet("imports/{id}")]
    public async Task<ActionResult<OcrImportDto>> GetImport(int id)
    {
        var import = await _ocrImportService.GetImportAsync(id);
        if (import == null)
        {
            return NotFound();
        }

        return Ok(import);
    }

    [HttpPost("imports/{importId}/items")]
    public async Task<ActionResult<OcrImportItemDto>> CreateImportItem(int importId, OcrImportItemCreateDto createDto)
    {
        try
        {
            var created = await _ocrImportService.CreateImportItemAsync(importId, createDto);
            return CreatedAtAction(nameof(GetImport), new { id = importId }, created);
        }
        catch (InvalidOperationException ex)
        {
            return BadRequest(new { Message = ex.Message });
        }
    }

    [HttpPost("items/{itemId}/parse")]
    public async Task<ActionResult<IEnumerable<OcrRecipeCandidateDto>>> ParseItem(int itemId)
    {
        var candidates = (await _ocrImportService.ParseItemAsync(itemId)).ToList();
        if (candidates.Count == 0)
        {
            return NotFound();
        }

        return Ok(candidates);
    }

    [HttpGet("items/{itemId}/candidates")]
    public async Task<ActionResult<IEnumerable<OcrRecipeCandidateDto>>> GetItemCandidates(int itemId)
    {
        var candidates = (await _ocrImportService.GetItemCandidatesAsync(itemId)).ToList();
        if (candidates.Count == 0)
        {
            return NotFound();
        }

        return Ok(candidates);
    }
}
