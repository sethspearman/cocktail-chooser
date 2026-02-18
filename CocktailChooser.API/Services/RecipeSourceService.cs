using CocktailChooser.API.DTOs;
using CocktailChooser.Data.Repositories;

namespace CocktailChooser.API.Services
{
    public class RecipeSourceService : IRecipeSourceService
    {
        private readonly IRecipeSourceRepository _repository;

        public RecipeSourceService(IRecipeSourceRepository repository)
        {
            _repository = repository;
        }

        public async Task<IEnumerable<RecipeSourceDto>> GetAllRecipeSourcesAsync()
        {
            var sources = await _repository.GetAllAsync();
            return sources.Select(MapToDto);
        }

        public async Task<RecipeSourceDto?> GetRecipeSourceByIdAsync(int id)
        {
            var source = await _repository.GetByIdAsync(id);
            if (source == null)
            {
                return null;
            }

            return MapToDto(source);
        }

        public async Task<bool> IsRecipeSourceInUseAsync(int id)
        {
            return await _repository.IsInUseAsync(id);
        }

        public async Task<RecipeSourceDto> CreateRecipeSourceAsync(RecipeSourceDto sourceDto)
        {
            var source = await _repository.CreateAsync(MapToRecord(sourceDto));
            return MapToDto(source);
        }

        public async Task<bool> UpdateRecipeSourceAsync(RecipeSourceDto sourceDto)
        {
            return await _repository.UpdateAsync(MapToRecord(sourceDto));
        }

        public async Task<bool> DeleteRecipeSourceAsync(int id)
        {
            return await _repository.DeleteAsync(id);
        }

        private static RecipeSourceDto MapToDto(RecipeSourceRecord source)
        {
            return new RecipeSourceDto
            {
                Id = source.Id,
                Name = source.Name,
                SourceType = source.SourceType,
                Publisher = source.Publisher,
                PublishDate = source.PublishDate,
                Author = source.Author,
                Isbn10 = source.Isbn10,
                Isbn13 = source.Isbn13,
                PurchaseUrl = source.PurchaseUrl,
                Edition = source.Edition,
                Language = source.Language,
                CopyrightCredit = source.CopyrightCredit,
                Url = source.Url,
                Notes = source.Notes,
                IsBuiltIn = source.IsBuiltIn,
                CreatedUtc = source.CreatedUtc
            };
        }

        private static RecipeSourceRecord MapToRecord(RecipeSourceDto source)
        {
            return new RecipeSourceRecord
            {
                Id = source.Id,
                Name = source.Name,
                SourceType = source.SourceType,
                Publisher = source.Publisher,
                PublishDate = source.PublishDate,
                Author = source.Author,
                Isbn10 = source.Isbn10,
                Isbn13 = source.Isbn13,
                PurchaseUrl = source.PurchaseUrl,
                Edition = source.Edition,
                Language = source.Language,
                CopyrightCredit = source.CopyrightCredit,
                Url = source.Url,
                Notes = source.Notes,
                IsBuiltIn = source.IsBuiltIn,
                CreatedUtc = source.CreatedUtc
            };
        }
    }
}
