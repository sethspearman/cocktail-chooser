using Microsoft.AspNetCore.Mvc;
using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace CocktailChooser.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class IngredientsController : ControllerBase
    {
        private readonly IIngredientService _ingredientService;

        public IngredientsController(IIngredientService ingredientService)
        {
            _ingredientService = ingredientService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<IngredientDto>>> GetIngredients()
        {
            var ingredients = await _ingredientService.GetAllIngredientsAsync();
            return Ok(ingredients);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<IngredientDto>> GetIngredient(int id)
        {
            var ingredient = await _ingredientService.GetIngredientByIdAsync(id);
            if (ingredient == null)
            {
                return NotFound();
            }
            return Ok(ingredient);
        }

        [HttpPost]
        public async Task<ActionResult<IngredientDto>> PostIngredient(IngredientDto ingredientDto)
        {
            var newIngredient = await _ingredientService.CreateIngredientAsync(ingredientDto);
            return CreatedAtAction(nameof(GetIngredient), new { id = newIngredient.Id }, newIngredient);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutIngredient(int id, IngredientDto ingredientDto)
        {
            if (id != ingredientDto.Id)
            {
                return BadRequest();
            }

            var result = await _ingredientService.UpdateIngredientAsync(ingredientDto);
            if (!result)
            {
                return NotFound();
            }

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteIngredient(int id)
        {
            var result = await _ingredientService.DeleteIngredientAsync(id);
            if (!result)
            {
                return NotFound();
            }

            return NoContent();
        }
    }
}
