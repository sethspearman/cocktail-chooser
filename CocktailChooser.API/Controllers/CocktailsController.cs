using Microsoft.AspNetCore.Mvc;
using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace CocktailChooser.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CocktailsController : ControllerBase
    {
        private readonly ICocktailService _cocktailService;

        public CocktailsController(ICocktailService cocktailService)
        {
            _cocktailService = cocktailService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<CocktailDto>>> GetCocktails()
        {
            var cocktails = await _cocktailService.GetAllCocktailsAsync();
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
    }
}
