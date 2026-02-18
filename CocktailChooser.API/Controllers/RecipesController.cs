using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using Microsoft.AspNetCore.Mvc;

namespace CocktailChooser.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RecipesController : ControllerBase
    {
        private readonly IRecipeService _recipeService;

        public RecipesController(IRecipeService recipeService)
        {
            _recipeService = recipeService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<RecipeDto>>> GetRecipes(
            [FromQuery] int? cocktailId,
            [FromQuery] int? recipeSourceId)
        {
            if (cocktailId.HasValue || recipeSourceId.HasValue)
            {
                var filtered = await _recipeService.SearchRecipesAsync(cocktailId, recipeSourceId);
                return Ok(filtered);
            }

            var recipes = await _recipeService.GetAllRecipesAsync();
            return Ok(recipes);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<RecipeDto>> GetRecipe(int id)
        {
            var recipe = await _recipeService.GetRecipeByIdAsync(id);
            if (recipe == null)
            {
                return NotFound();
            }

            return Ok(recipe);
        }

        [HttpGet("by-cocktail/{cocktailId}")]
        public async Task<ActionResult<IEnumerable<RecipeDto>>> GetRecipesByCocktailId(int cocktailId)
        {
            var recipes = await _recipeService.GetRecipesByCocktailIdAsync(cocktailId);
            return Ok(recipes);
        }

        [HttpGet("by-source/{recipeSourceId}")]
        public async Task<ActionResult<IEnumerable<RecipeDto>>> GetRecipesBySourceId(int recipeSourceId)
        {
            var recipes = await _recipeService.GetRecipesBySourceIdAsync(recipeSourceId);
            return Ok(recipes);
        }

        [HttpPost]
        public async Task<ActionResult<RecipeDto>> PostRecipe(RecipeDto recipeDto)
        {
            var newRecipe = await _recipeService.CreateRecipeAsync(recipeDto);
            return CreatedAtAction(nameof(GetRecipe), new { id = newRecipe.Id }, newRecipe);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutRecipe(int id, RecipeDto recipeDto)
        {
            if (id != recipeDto.Id)
            {
                return BadRequest();
            }

            var result = await _recipeService.UpdateRecipeAsync(recipeDto);
            if (!result)
            {
                return NotFound();
            }

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteRecipe(int id)
        {
            var result = await _recipeService.DeleteRecipeAsync(id);
            if (!result)
            {
                return NotFound();
            }

            return NoContent();
        }
    }
}
