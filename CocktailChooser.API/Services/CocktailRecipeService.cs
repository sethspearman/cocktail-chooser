using System;
using System.Linq;
using System.Threading.Tasks;
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
            _context = context ?? throw new ArgumentNullException(nameof(context));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        public async Task<CocktailRecipeDto> GetCocktailRecipeByIdAsync(int cocktailId, int stepNumber)
        {
            var recipe = await _context.CocktailRecipes
                .FirstOrDefaultAsync(cr => cr.CocktailId == cocktailId && cr.StepNumber == stepNumber);

            if (recipe == null)
            {
                return null;
            }

            return _mapper.Map<CocktailRecipeDto>(recipe);
        }

        public async Task<IEnumerable<CocktailRecipeDto>> GetAllCocktailRecipesAsync()
        {
            var recipes = await _context.CocktailRecipes.ToListAsync();
            return _mapper.Map<IEnumerable<CocktailRecipeDto>>(recipes);
        }

        public async Task<IEnumerable<CocktailRecipeDto>> GetCocktailRecipesByCocktailIdAsync(int cocktailId)
        {
            var recipes = await _context.CocktailRecipes
                .Where(cr => cr.CocktailId == cocktailId)
                .ToListAsync();

            return _mapper.Map<IEnumerable<CocktailRecipeDto>>(recipes);
        }

        public async Task<CocktailRecipeDto> CreateCocktailRecipeAsync(CocktailRecipeDto cocktailRecipeDto)
        {
            var recipe = _mapper.Map<CocktailRecipe>(cocktailRecipeDto);

            _context.CocktailRecipes.Add(recipe);
            await _context.SaveChangesAsync();

            return _mapper.Map<CocktailRecipeDto>(recipe);
        }

        public async Task<bool> UpdateCocktailRecipeAsync(CocktailRecipeDto cocktailRecipeDto)
        {
            var recipe = await _context.CocktailRecipes
                .FirstOrDefaultAsync(cr => cr.CocktailId == cocktailRecipeDto.CocktailId && cr.StepNumber == cocktailRecipeDto.StepNumber);

            if (recipe == null)
            {
                return false;
            }

            _mapper.Map(cocktailRecipeDto, recipe);
            await _context.SaveChangesAsync();

            return true;
        }

        public async Task<bool> DeleteCocktailRecipeAsync(int cocktailId, int stepNumber)
        {
            var recipe = await _context.CocktailRecipes
                .FirstOrDefaultAsync(cr => cr.CocktailId == cocktailId && cr.StepNumber == stepNumber);

            if (recipe == null)
            {
                return false;
            }

            _context.CocktailRecipes.Remove(recipe);
            await _context.SaveChangesAsync();

            return true;
        }
    }
}
