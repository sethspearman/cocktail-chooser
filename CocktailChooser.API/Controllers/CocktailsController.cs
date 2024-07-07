using Microsoft.AspNetCore.Mvc;
using CocktailChooser.API.Models;
using Microsoft.EntityFrameworkCore;

namespace CocktailChooser.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CocktailsController : ControllerBase
    {
        private readonly CocktailChooserContext _context;

        public CocktailsController(CocktailChooserContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Cocktail>>> GetCocktails()
        {
            return await _context.Cocktails.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Cocktail>> GetCocktail(int id)
        {
            var cocktail = await _context.Cocktails.FindAsync(id);

            if (cocktail == null)
            {
                return NotFound();
            }

            return cocktail;
        }

        [HttpPost]
        public async Task<ActionResult<Cocktail>> PostCocktail(Cocktail cocktail)
        {
            _context.Cocktails.Add(cocktail);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetCocktail), new { id = cocktail.Id }, cocktail);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutCocktail(int id, Cocktail cocktail)
        {
            if (id != cocktail.Id)
            {
                return BadRequest();
            }

            _context.Entry(cocktail).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CocktailExists(id))
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
        public async Task<IActionResult> DeleteCocktail(int id)
        {
            var cocktail = await _context.Cocktails.FindAsync(id);
            if (cocktail == null)
            {
                return NotFound();
            }

            _context.Cocktails.Remove(cocktail);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CocktailExists(int id)
        {
            return _context.Cocktails.Any(e => e.Id == id);
        }
    }
}
