using Microsoft.AspNetCore.Mvc;
using CocktailChooser.API.Models;
using CocktailChooser.API.DTOs;
using Microsoft.EntityFrameworkCore;
using AutoMapper;

namespace CocktailChooser.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class IngredientsController : ControllerBase
    {
        private readonly CocktailChooserContext _context;
        private readonly IMapper _mapper;

        public IngredientsController(CocktailChooserContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<IngredientDto>>> GetIngredients()
        {
            var ingredients = await _context.Ingredients.ToListAsync();
            return _mapper.Map<List<IngredientDto>>(ingredients);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<IngredientDto>> GetIngredient(int id)
        {
            var ingredient = await _context.Ingredients.FindAsync(id);

            if (ingredient == null)
            {
                return NotFound();
            }

            return _mapper.Map<IngredientDto>(ingredient);
        }

        [HttpPost]
        public async Task<ActionResult<IngredientDto>> PostIngredient(IngredientDto ingredientDto)
        {
            var ingredient = _mapper.Map<Ingredient>(ingredientDto);
            _context.Ingredients.Add(ingredient);
            await _context.SaveChangesAsync();

            ingredientDto.Id = ingredient.Id;

            return CreatedAtAction(nameof(GetIngredient), new { id = ingredientDto.Id }, ingredientDto);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutIngredient(int id, IngredientDto ingredientDto)
        {
            if (id != ingredientDto.Id)
            {
                return BadRequest();
            }

            var ingredient = _mapper.Map<Ingredient>(ingredientDto);
            _context.Entry(ingredient).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!IngredientExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteIngredient(int id)
        {
            var ingredient = await _context.Ingredients.FindAsync(id);
            if (ingredient == null)
            {
                return NotFound();
            }

            _context.Ingredients.Remove(ingredient);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool IngredientExists(int id)
        {
            return _context.Ingredients.Any(e => e.Id == id);
        }
    }
}
