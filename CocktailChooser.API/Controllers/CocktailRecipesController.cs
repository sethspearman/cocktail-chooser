using Microsoft.AspNetCore.Mvc;
using CocktailChooser.API.Models;
using Microsoft.EntityFrameworkCore;

namespace CocktailChooser.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CocktailRecipesController : ControllerBase
    {
        private readonly CocktailChooserContext _context;

        public CocktailRecipesController(CocktailChooserContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<CocktailRecipe>>> GetCocktailRecipes()
        {
            return await _context.CocktailRecipes.ToListAsync();
        }

        [HttpGet("{cocktailId}")]
        public async Task<ActionResult<IEnumerable<CocktailRecipe>>> GetCocktailRecipesByCocktailId(int cocktailId)
        {
            return await _context.CocktailRecipes
                .Where(cr => cr.CocktailId == cocktailId)
                .ToListAsync();
        }

        [HttpPost]
        public async Task<ActionResult<CocktailRecipe>> PostCocktailRecipe(CocktailRecipe cocktailRecipe)
        {
            _context.CocktailRecipes.Add(cocktailRecipe);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetCocktailRecipesByCocktailId), new { cocktailId = cocktailRecipe.CocktailId }, cocktailRecipe);
        }

        [HttpPut("{cocktailId}/{stepNumber}")]
        public async Task<IActionResult> PutCocktailRecipe(int cocktailId, int stepNumber, CocktailRecipe cocktailRecipe)
        {
            if (cocktailId != cocktailRecipe.CocktailId || stepNumber != cocktailRecipe.StepNumber)
            {
                return BadRequest();
            }

            _context.Entry(cocktailRecipe).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CocktailRecipeExists(cocktailId, stepNumber))
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

        [HttpDelete("{cocktailId}/{stepNumber}")]
        public async Task<IActionResult> DeleteCocktailRecipe(int cocktailId, int stepNumber)
        {
            var cocktailRecipe = await _context.CocktailRecipes
                .Where(cr => cr.CocktailId == cocktailId && cr.StepNumber == stepNumber)
                .FirstOrDefaultAsync();
                
            if (cocktailRecipe == null)
            {
                return NotFound();
            }

            _context.CocktailRecipes.Remove(cocktailRecipe);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CocktailRecipeExists(int cocktailId, int stepNumber)
        {
            return _context.CocktailRecipes.Any(e => e.CocktailId == cocktailId && e.StepNumber == stepNumber);
        }
    }
}
