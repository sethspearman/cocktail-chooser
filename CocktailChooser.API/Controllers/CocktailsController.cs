using Microsoft.AspNetCore.Mvc;
using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using CocktailChooser.API.Auth;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace CocktailChooser.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CocktailsController : ControllerBase
    {
        private readonly ICocktailService _cocktailService;
        private readonly ICurrentUserContext _currentUserContext;

        public CocktailsController(ICocktailService cocktailService, ICurrentUserContext currentUserContext)
        {
            _cocktailService = cocktailService;
            _currentUserContext = currentUserContext;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<CocktailDto>>> GetCocktails(
            [FromQuery] string? include = null,
            [FromQuery] string? mode = null,
            [FromQuery] string? alcohol = null)
        {
            var includeNames = string.IsNullOrWhiteSpace(include)
                ? null
                : include
                    .Split(',', System.StringSplitOptions.TrimEntries | System.StringSplitOptions.RemoveEmptyEntries);

            var cocktails = await _cocktailService.GetAllCocktailsAsync(includeNames, mode, alcohol);
            return Ok(cocktails);
        }

        [HttpGet("my-pending")]
        public async Task<ActionResult<IEnumerable<CocktailDto>>> GetMyPendingCocktails()
        {
            if (!_currentUserContext.UserId.HasValue)
            {
                return Unauthorized();
            }

            var cocktails = await _cocktailService.GetPendingCocktailsForUserAsync(_currentUserContext.UserId.Value);
            return Ok(cocktails);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<CocktailDto>> GetCocktail(int id)
        {
            var cocktail = await _cocktailService.GetCocktailByIdAsync(id);
            if (cocktail == null)
            {
                return NotFound();
            }
            return Ok(cocktail);
        }

        [HttpPost]
        public async Task<ActionResult<CocktailDto>> PostCocktail(CocktailDto cocktailDto)
        {
            var newCocktail = await _cocktailService.CreateCocktailAsync(cocktailDto);
            return CreatedAtAction(nameof(GetCocktail), new { id = newCocktail.Id }, newCocktail);
        }

        [HttpPost("preview-from-text")]
        public async Task<ActionResult<CocktailTextPreviewResponseDto>> PreviewFromText(CocktailTextPreviewRequestDto requestDto)
        {
            var preview = await _cocktailService.PreviewFromTextAsync(requestDto);
            return Ok(preview);
        }

        [HttpPost("submit-from-text")]
        public async Task<ActionResult<CocktailDto>> SubmitFromText(CocktailTextSubmitRequestDto requestDto)
        {
            if (!_currentUserContext.UserId.HasValue)
            {
                return Unauthorized();
            }

            try
            {
                var created = await _cocktailService.SubmitFromTextAsync(requestDto, _currentUserContext.UserId.Value);
                return CreatedAtAction(nameof(GetCocktail), new { id = created.Id }, created);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost("{id}/approve")]
        public async Task<IActionResult> ApproveCocktail(int id)
        {
            if (!IsAdminUser())
            {
                return Forbid();
            }

            var updated = await _cocktailService.ApproveCocktailAsync(id);
            if (!updated)
            {
                return NotFound();
            }

            return NoContent();
        }

        [HttpPost("{id}/reject")]
        public async Task<IActionResult> RejectCocktail(int id, [FromQuery] bool delete = true)
        {
            if (!IsAdminUser())
            {
                return Forbid();
            }

            var updated = await _cocktailService.RejectCocktailAsync(id, delete);
            if (!updated)
            {
                return NotFound();
            }

            return NoContent();
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutCocktail(int id, CocktailDto cocktailDto)
        {
            if (id != cocktailDto.Id)
            {
                return BadRequest();
            }

            var result = await _cocktailService.UpdateCocktailAsync(cocktailDto);
            if (!result)
            {
                return NotFound();
            }

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCocktail(int id)
        {
            var result = await _cocktailService.DeleteCocktailAsync(id);
            if (!result)
            {
                return NotFound();
            }

            return NoContent();
        }

        private bool IsAdminUser()
        {
            // MVP admin policy: first account (UserId=1) is treated as admin.
            return _currentUserContext.UserId.HasValue && _currentUserContext.UserId.Value == 1;
        }
    }
}
