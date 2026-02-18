using System;
using System.Threading.Tasks;
using CocktailChooser.API.DTOs;
using CocktailChooser.Data.Repositories;

namespace CocktailChooser.API.Services
{
    public class CocktailRecipeService : ICocktailRecipeService
    {
        private readonly ICocktailRecipeRepository _repository;

        public CocktailRecipeService(ICocktailRecipeRepository repository)
        {
            _repository = repository ?? throw new ArgumentNullException(nameof(repository));
        }

        public async Task<CocktailRecipeDto?> GetCocktailRecipeByIdAsync(int cocktailId, int stepNumber)
        {
            var recipe = await _repository.GetByIdAsync(cocktailId, stepNumber);

            if (recipe == null)
            {
                return null;
            }

            return MapToDto(recipe);
        }

        public async Task<IEnumerable<CocktailRecipeDto>> GetAllCocktailRecipesAsync()
        {
            var recipes = await _repository.GetAllAsync();
            return recipes.Select(MapToDto);
        }

        public async Task<IEnumerable<CocktailRecipeDto>> GetCocktailRecipesByCocktailIdAsync(int cocktailId)
        {
            var recipes = await _repository.GetByCocktailIdAsync(cocktailId);
            return recipes.Select(MapToDto);
        }

        public async Task<CocktailRecipeDto> CreateCocktailRecipeAsync(CocktailRecipeDto cocktailRecipeDto)
        {
            var recipe = await _repository.CreateAsync(MapToRecord(cocktailRecipeDto));
            return MapToDto(recipe);
        }

        public async Task<bool> UpdateCocktailRecipeAsync(CocktailRecipeDto cocktailRecipeDto)
        {
            return await _repository.UpdateAsync(MapToRecord(cocktailRecipeDto));
        }

        public async Task<bool> DeleteCocktailRecipeAsync(int cocktailId, int stepNumber)
        {
            return await _repository.DeleteAsync(cocktailId, stepNumber);
        }

        private static CocktailRecipeDto MapToDto(CocktailRecipeRecord recipe)
        {
            return new CocktailRecipeDto
            {
                CocktailId = recipe.CocktailId,
                StepNumber = recipe.StepNumber,
                Instruction = recipe.Instruction
            };
        }

        private static CocktailRecipeRecord MapToRecord(CocktailRecipeDto recipe)
        {
            return new CocktailRecipeRecord
            {
                CocktailId = recipe.CocktailId,
                StepNumber = recipe.StepNumber,
                Instruction = recipe.Instruction
            };
        }
    }
}
