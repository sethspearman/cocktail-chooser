using AutoMapper;
using CocktailChooser.API.DTOs;
using CocktailChooser.API.Models;
using Microsoft.EntityFrameworkCore;

namespace CocktailChooser.API.Services
{
    public class IngredientService : IIngredientService
    {
        private readonly CocktailChooserContext _context;
        private readonly IMapper _mapper;

        public IngredientService(CocktailChooserContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<IEnumerable<IngredientDto>> GetAllIngredientsAsync()
        {
            var ingredients = await _context.Ingredients.ToListAsync();
            return _mapper.Map<List<IngredientDto>>(ingredients);
        }

        public async Task<IngredientDto> GetIngredientByIdAsync(int id)
        {
            var ingredient = await _context.Ingredients.FindAsync(id);
            if (ingredient == null)
            {
                return null;
            }
            return _mapper.Map<IngredientDto>(ingredient);
        }

        public async Task<IngredientDto> CreateIngredientAsync(IngredientDto ingredientDto)
        {
            var ingredient = _mapper.Map<Ingredient>(ingredientDto);
            _context.Ingredients.Add(ingredient);
            await _context.SaveChangesAsync();
            return _mapper.Map<IngredientDto>(ingredient);
        }

        public async Task<bool> UpdateIngredientAsync(IngredientDto ingredientDto)
        {
            var ingredient = _mapper.Map<Ingredient>(ingredientDto);
            _context.Entry(ingredient).State = EntityState.Modified;
            try
            {
                await _context.SaveChangesAsync();
                return true;
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!IngredientExists(ingredientDto.Id))
                {
                    return false;
                }
                throw;
            }
        }

        public async Task<bool> DeleteIngredientAsync(int id)
        {
            var ingredient = await _context.Ingredients.FindAsync(id);
            if (ingredient == null)
            {
                return false;
            }
            _context.Ingredients.Remove(ingredient);
            await _context.SaveChangesAsync();
            return true;
        }

        private bool IngredientExists(int id)
        {
            return _context.Ingredients.Any(e => e.Id == id);
        }
    }
}
