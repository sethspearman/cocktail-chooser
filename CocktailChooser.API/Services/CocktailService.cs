using CocktailChooser.API.DTOs;
using CocktailChooser.Data.Repositories;

namespace CocktailChooser.API.Services
{
    public class CocktailService : ICocktailService
    {
        private readonly ICocktailRepository _repository;

        public CocktailService(ICocktailRepository repository)
        {
            _repository = repository;
        }

        public async Task<IEnumerable<CocktailDto>> GetAllCocktailsAsync()
        {
            var cocktails = await _repository.GetAllAsync();
            return cocktails.Select(MapToDto);
        }

        public async Task<CocktailDto?> GetCocktailByIdAsync(int id)
        {
            var cocktail = await _repository.GetByIdAsync(id);
            if (cocktail == null)
            {
                return null;
            }

            return MapToDto(cocktail);
        }

        public async Task<CocktailDto> CreateCocktailAsync(CocktailDto cocktailDto)
        {
            var createdCocktail = await _repository.CreateAsync(MapToRecord(cocktailDto));
            return MapToDto(createdCocktail);
        }

        public async Task<bool> UpdateCocktailAsync(CocktailDto cocktailDto)
        {
            return await _repository.UpdateAsync(MapToRecord(cocktailDto));
        }

        public async Task<bool> DeleteCocktailAsync(int id)
        {
            return await _repository.DeleteAsync(id);
        }

        private static CocktailDto MapToDto(CocktailRecord cocktail)
        {
            return new CocktailDto
            {
                Id = cocktail.Id,
                Name = cocktail.Name,
                Description = cocktail.Description,
                Method = cocktail.Method,
                GlassTypeId = cocktail.GlassTypeId,
                TimePeriodId = cocktail.TimePeriodId,
                IsPopular = cocktail.IsPopular,
                CocktailSourceId = cocktail.CocktailSourceId
            };
        }

        private static CocktailRecord MapToRecord(CocktailDto cocktail)
        {
            return new CocktailRecord
            {
                Id = cocktail.Id,
                Name = cocktail.Name,
                Description = cocktail.Description,
                Method = cocktail.Method,
                GlassTypeId = cocktail.GlassTypeId,
                TimePeriodId = cocktail.TimePeriodId,
                IsPopular = cocktail.IsPopular,
                CocktailSourceId = cocktail.CocktailSourceId
            };
        }
    }
}
