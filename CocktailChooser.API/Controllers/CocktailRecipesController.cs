using Microsoft.AspNetCore.Mvc;
using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace CocktailChooser.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CocktailRecipesController : ControllerBase
    {
        private readonly ICocktailRecipeService _cocktailRecipeService;

        public CocktailRecipesController(ICocktailRecipeService cocktailRecipeService)
        {
            _cocktailRecipeService = cocktailRecipeService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<CocktailRecipeDto>>> GetCocktailRecipes()
        {
            var cocktailRecipes = await _cocktailRecipeService.GetAllCocktailRecipesAsync();
            return Ok(cocktailRecipes);
        }

        [HttpGet("{cocktailId}")]
        public async Task<ActionResult<IEnumerable<CocktailRecipeDto>>> GetCocktailRecipesByCocktailId(int cocktailId)
        {
            var cocktailRecipes = await _cocktailRecipeService.GetCocktailRecipesByCocktailIdAsync(cocktailId);
            return Ok(cocktailRecipes);
        }

        [HttpPost]
        public async Task<ActionResult<CocktailRecipeDto>> PostCocktailRecipe(CocktailRecipeDto cocktailRecipeDto)
        {
            var newCocktailRecipe = await _cocktailRecipeService.CreateCocktailRecipeAsync(cocktailRecipeDto);
            return CreatedAtAction(nameof(GetCocktailRecipesByCocktailId), new { cocktailId = newCocktailRecipe.CocktailId }, newCocktailRecipe);
        }

        [HttpPut("{cocktailId}/{stepNumber}")]
        public async Task<IActionResult> PutCocktailRecipe(int cocktailId, int stepNumber, CocktailRecipeDto cocktailRecipeDto)
        {
            if (cocktailId != cocktailRecipeDto.CocktailId || stepNumber != cocktailRecipeDto.StepNumber)
            {
                return BadRequest();
            }

            var result = await _cocktailRecipeService.UpdateCocktailRecipeAsync(cocktailRecipeDto);
            if (!result)
            {
                return NotFound();
            }

            return NoContent();
        }

        [HttpDelete("{cocktailId}/{stepNumber}")]
        public async Task<IActionResult> DeleteCocktailRecipe(int cocktailId, int stepNumber)
        {
            var result = await _cocktailRecipeService.DeleteCocktailRecipeAsync(cocktailId, stepNumber);
            if (!result)
            {
                return NotFound();
            }

            return NoContent();
        }
    }
}
