using Microsoft.AspNetCore.Mvc;
using CocktailChooser.API.Models;
using CocktailChooser.API.DTOs;
using Microsoft.EntityFrameworkCore;
using AutoMapper;

namespace CocktailChooser.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CocktailRecipesController : ControllerBase
    {
        private readonly CocktailChooserContext _context;
        private readonly IMapper _mapper;

        public CocktailRecipesController(CocktailChooserContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<CocktailRecipeDto>>> GetCocktailRecipes()
        {
            var cocktailRecipes = await _context.CocktailRecipes.ToListAsync();
            return _mapper.Map<List<CocktailRecipeDto>>(cocktailRecipes);
        }

        [HttpGet("{cocktailId}")]
        public async Task<ActionResult<IEnumerable<CocktailRecipeDto>>> GetCocktailRecipesByCocktailId(int cocktailId)
        {
            var cocktailRecipes = await _context.CocktailRecipes
                .Where(cr => cr.CocktailId == cocktailId)
                .ToListAsync();

            return _mapper.Map<List<CocktailRecipeDto>>(cocktailRecipes);
        }

        [HttpPost]
        public async Task<ActionResult<CocktailRecipeDto>> PostCocktailRecipe(CocktailRecipeDto cocktailRecipeDto)
        {
            var cocktailRecipe = _mapper.Map<CocktailRecipe>(cocktailRecipeDto);
            _context.CocktailRecipes.Add(cocktailRecipe);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetCocktailRecipesByCocktailId), new { cocktailId = cocktailRecipe.CocktailId }, cocktailRecipeDto);
        }

        [HttpPut("{cocktailId}/{stepNumber}")]
        public async Task<IActionResult> PutCocktailRecipe(int cocktailId, int stepNumber, CocktailRecipeDto cocktailRecipeDto)
        {
            if (cocktailId != cocktailRecipeDto.CocktailId || stepNumber != cocktailRecipeDto.StepNumber)
            {
                return BadRequest();
            }

            var cocktailRecipe = _mapper.Map<CocktailRecipe>(cocktailRecipeDto);
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
