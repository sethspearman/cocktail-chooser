using CocktailChooser.API.DTOs;
using CocktailChooser.Data.Repositories;

namespace CocktailChooser.API.Services
{
    public class IngredientService : IIngredientService
    {
        private readonly IIngredientRepository _repository;

        public IngredientService(IIngredientRepository repository)
        {
            _repository = repository;
        }

        public async Task<IEnumerable<IngredientDto>> GetAllIngredientsAsync()
        {
            var ingredients = await _repository.GetAllAsync();
            return ingredients.Select(MapToDto);
        }

        public async Task<IngredientDto?> GetIngredientByIdAsync(int id)
        {
            var ingredient = await _repository.GetByIdAsync(id);
            if (ingredient == null)
            {
                return null;
            }

            return MapToDto(ingredient);
        }

        public async Task<IngredientDto> CreateIngredientAsync(IngredientDto ingredientDto)
        {
            var ingredient = await _repository.CreateAsync(MapToRecord(ingredientDto));
            return MapToDto(ingredient);
        }

        public async Task<bool> UpdateIngredientAsync(IngredientDto ingredientDto)
        {
            return await _repository.UpdateAsync(MapToRecord(ingredientDto));
        }

        public async Task<bool> DeleteIngredientAsync(int id)
        {
            return await _repository.DeleteAsync(id);
        }

        private static IngredientDto MapToDto(IngredientRecord ingredient)
        {
            return new IngredientDto
            {
                Id = ingredient.Id,
                Name = ingredient.Name,
                IngredientTypeId = ingredient.IngredientTypeId,
                MixerSubtypeId = ingredient.MixerSubtypeId,
                LongDescription = ingredient.LongDescription
            };
        }

        private static IngredientRecord MapToRecord(IngredientDto ingredient)
        {
            return new IngredientRecord
            {
                Id = ingredient.Id,
                Name = ingredient.Name,
                IngredientTypeId = ingredient.IngredientTypeId,
                MixerSubtypeId = ingredient.MixerSubtypeId,
                LongDescription = ingredient.LongDescription
            };
        }
    }
}
