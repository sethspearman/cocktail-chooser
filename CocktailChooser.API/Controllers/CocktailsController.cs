using Microsoft.AspNetCore.Mvc;
using CocktailChooser.API.Models;
using CocktailChooser.API.DTOs;
using Microsoft.EntityFrameworkCore;
using AutoMapper;

namespace CocktailChooser.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CocktailsController : ControllerBase
    {
        private readonly CocktailChooserContext _context;
        private readonly IMapper _mapper;

        public CocktailsController(CocktailChooserContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<CocktailDto>>> GetCocktails()
        {
            var cocktails = await _context.Cocktails.ToListAsync();
            return _mapper.Map<List<CocktailDto>>(cocktails);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<CocktailDto>> GetCocktail(int id)
        {
            var cocktail = await _context.Cocktails.FindAsync(id);

            if (cocktail == null)
            {
                return NotFound();
            }

            return _mapper.Map<CocktailDto>(cocktail);
        }

        [HttpPost]
        public async Task<ActionResult<CocktailDto>> PostCocktail(CocktailDto cocktailDto)
        {
            var cocktail = _mapper.Map<Cocktail>(cocktailDto);
            _context.Cocktails.Add(cocktail);
            await _context.SaveChangesAsync();

            cocktailDto.Id = cocktail.Id;

            return CreatedAtAction(nameof(GetCocktail), new { id = cocktailDto.Id }, cocktailDto);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutCocktail(int id, CocktailDto cocktailDto)
        {
            if (id != cocktailDto.Id)
            {
                return BadRequest();
            }

            var cocktail = _mapper.Map<Cocktail>(cocktailDto);
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
