using AutoMapper;
using CocktailChooser.API.DTOs;
using CocktailChooser.API.Models;
using Microsoft.EntityFrameworkCore;

namespace CocktailChooser.API.Services
{
    public class CocktailRecipeService : ICocktailRecipeService
    {
        private readonly CocktailChooserContext _context;
        private readonly IMapper _mapper;

        public CocktailRecipeService(CocktailChooserContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<IEnumerable<CocktailRecipeDto>> GetAllCocktailRecipesAsync()
        {
            var cocktailRecipes = await _context.CocktailRecipes.ToListAsync();
            return _mapper.Map<List<CocktailRecipeDto>>(cocktailRecipes);
        }

        public async Task<IEnumerable<CocktailRecipeDto>> GetCocktailRecipesByCocktailIdAsync(int cocktailId)
        {
            var cocktailRecipes = await _context.CocktailRecipes
                .Where(cr => cr.CocktailId == cocktailId)
                .ToListAsync();

            return _mapper.Map<List<CocktailRecipeDto>>(cocktailRecipes);
        }

        public async Task<CocktailRecipeDto> CreateCocktailRecipeAsync(CocktailRecipeDto cocktailRecipeDto)
        {
            var cocktailRecipe = _mapper.Map<CocktailRecipe>(cocktailRecipeDto);
            _context.CocktailRecipes.Add(cocktailRecipe);
            await _context.SaveChangesAsync();
            return _mapper.Map<CocktailRecipeDto>(cocktailRecipe);
        }

        public async Task<bool> UpdateCocktailRecipeAsync(CocktailRecipeDto cocktailRecipeDto)
        {
            var cocktailRecipe = _mapper.Map<CocktailRecipe>(cocktailRecipeDto);
            _context.Entry(cocktailRecipe).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
                return true;
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CocktailRecipeExists(cocktailRecipeDto.CocktailId, cocktailRecipeDto.StepNumber))
                {
                    return false;
                }
                throw;
            }
        }

        public async Task<bool> DeleteCocktailRecipeAsync(int cocktailId, int stepNumber)
        {
            var cocktailRecipe = await _context.CocktailRecipes
                .Where(cr => cr.CocktailId == cocktailId && cr.StepNumber == stepNumber)
                .FirstOrDefaultAsync();

            if (cocktailRecipe == null)
            {
                return false;
            }

            _context.CocktailRecipes.Remove(cocktailRecipe);
            await _context.SaveChangesAsync();
            return true;
        }

        private bool CocktailRecipeExists(int cocktailId, int stepNumber)
        {
            return _context.CocktailRecipes.Any(e => e.CocktailId == cocktailId && e.StepNumber == stepNumber);
        }
    }
}
