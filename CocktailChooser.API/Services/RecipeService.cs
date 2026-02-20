using CocktailChooser.API.DTOs;
using CocktailChooser.Data.Repositories;

namespace CocktailChooser.API.Services
{
    public class RecipeService : IRecipeService
    {
        private readonly IRecipeRepository _repository;

        public RecipeService(IRecipeRepository repository)
        {
            _repository = repository;
        }

        public async Task<IEnumerable<RecipeDto>> GetAllRecipesAsync()
        {
            var recipes = await _repository.GetAllAsync();
            return recipes.Select(MapToDto);
        }

        public async Task<RecipeDto?> GetRecipeByIdAsync(int id)
        {
            var recipe = await _repository.GetByIdAsync(id);
            if (recipe == null)
            {
                return null;
            }

            return MapToDto(recipe);
        }

        public async Task<IEnumerable<RecipeDto>> GetRecipesByCocktailIdAsync(int cocktailId)
        {
            var recipes = await _repository.GetByCocktailIdAsync(cocktailId);
            return recipes.Select(MapToDto);
        }

        public async Task<IEnumerable<RecipeDto>> GetRecipesBySourceIdAsync(int recipeSourceId)
        {
            var recipes = await _repository.GetBySourceIdAsync(recipeSourceId);
            return recipes.Select(MapToDto);
        }

        public async Task<IEnumerable<RecipeDto>> SearchRecipesAsync(int? cocktailId, int? recipeSourceId)
        {
            var recipes = await _repository.SearchAsync(cocktailId, recipeSourceId);
            return recipes.Select(MapToDto);
        }

        public async Task<RecipeDto> CreateRecipeAsync(RecipeDto recipeDto)
        {
            recipeDto.UpdatedUtc = DateTime.UtcNow.ToString("O");
            var recipe = await _repository.CreateAsync(MapToRecord(recipeDto));
            return MapToDto(recipe);
        }

        public async Task<bool> UpdateRecipeAsync(RecipeDto recipeDto)
        {
            recipeDto.UpdatedUtc = DateTime.UtcNow.ToString("O");
            return await _repository.UpdateAsync(MapToRecord(recipeDto));
        }

        public async Task<bool> DeleteRecipeAsync(int id)
        {
            return await _repository.DeleteAsync(id);
        }

        private static RecipeDto MapToDto(RecipeRecord recipe)
        {
            return new RecipeDto
            {
                Id = recipe.Id,
                CocktailId = recipe.CocktailId,
                RecipeSourceId = recipe.RecipeSourceId,
                SourceRecipeName = recipe.SourceRecipeName,
                AttributionText = recipe.AttributionText,
                SourceUrl = recipe.SourceUrl,
                Method = recipe.Method,
                FlavorProfile = recipe.FlavorProfile,
                Notes = recipe.Notes,
                IsUserSubmitted = recipe.IsUserSubmitted,
                CreatedUtc = recipe.CreatedUtc,
                UpdatedUtc = recipe.UpdatedUtc
            };
        }

        private static RecipeRecord MapToRecord(RecipeDto recipe)
        {
            return new RecipeRecord
            {
                Id = recipe.Id,
                CocktailId = recipe.CocktailId,
                RecipeSourceId = recipe.RecipeSourceId,
                SourceRecipeName = recipe.SourceRecipeName,
                AttributionText = recipe.AttributionText,
                SourceUrl = recipe.SourceUrl,
                Method = recipe.Method,
                FlavorProfile = recipe.FlavorProfile,
                Notes = recipe.Notes,
                IsUserSubmitted = recipe.IsUserSubmitted,
                CreatedUtc = recipe.CreatedUtc,
                UpdatedUtc = recipe.UpdatedUtc
            };
        }
    }
}
