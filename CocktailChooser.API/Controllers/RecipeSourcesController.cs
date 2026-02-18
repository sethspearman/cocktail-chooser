using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using Microsoft.Data.Sqlite;
using Microsoft.AspNetCore.Mvc;

namespace CocktailChooser.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RecipeSourcesController : ControllerBase
    {
        private readonly IRecipeSourceService _recipeSourceService;

        public RecipeSourcesController(IRecipeSourceService recipeSourceService)
        {
            _recipeSourceService = recipeSourceService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<RecipeSourceDto>>> GetRecipeSources()
        {
            var sources = await _recipeSourceService.GetAllRecipeSourcesAsync();
            return Ok(sources);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<RecipeSourceDto>> GetRecipeSource(int id)
        {
            var source = await _recipeSourceService.GetRecipeSourceByIdAsync(id);
            if (source == null)
            {
                return NotFound();
            }

            return Ok(source);
        }

        [HttpPost]
        public async Task<ActionResult<RecipeSourceDto>> PostRecipeSource(RecipeSourceDto sourceDto)
        {
            var newSource = await _recipeSourceService.CreateRecipeSourceAsync(sourceDto);
            return CreatedAtAction(nameof(GetRecipeSource), new { id = newSource.Id }, newSource);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutRecipeSource(int id, RecipeSourceDto sourceDto)
        {
            if (id != sourceDto.Id)
            {
                return BadRequest();
            }

            var result = await _recipeSourceService.UpdateRecipeSourceAsync(sourceDto);
            if (!result)
            {
                return NotFound();
            }

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteRecipeSource(int id)
        {
            var source = await _recipeSourceService.GetRecipeSourceByIdAsync(id);
            if (source == null)
            {
                return NotFound();
            }

            var inUse = await _recipeSourceService.IsRecipeSourceInUseAsync(id);
            if (inUse)
            {
                return Conflict(new
                {
                    Message = "Recipe source is in use by one or more recipes and cannot be deleted."
                });
            }

            try
            {
                var result = await _recipeSourceService.DeleteRecipeSourceAsync(id);
                if (!result)
                {
                    return NotFound();
                }
            }
            catch (SqliteException)
            {
                return Conflict(new
                {
                    Message = "Recipe source is in use by one or more recipes and cannot be deleted."
                });
            }

            return NoContent();
        }
    }
}
