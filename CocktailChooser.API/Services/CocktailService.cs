using AutoMapper;
using CocktailChooser.API.DTOs;
using CocktailChooser.API.Models;
using Microsoft.EntityFrameworkCore;

namespace CocktailChooser.API.Services
{
    public class CocktailService : ICocktailService
    {
        private readonly CocktailChooserContext _context;
        private readonly IMapper _mapper;

        public CocktailService(CocktailChooserContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<IEnumerable<CocktailDto>> GetAllCocktailsAsync()
        {
            var cocktails = await _context.Cocktails.ToListAsync();
            return _mapper.Map<List<CocktailDto>>(cocktails);
        }

        public async Task<CocktailDto> GetCocktailByIdAsync(int id)
        {
            var cocktail = await _context.Cocktails.FindAsync(id);
            if (cocktail == null)
            {
                return null;
            }
            return _mapper.Map<CocktailDto>(cocktail);
        }

        public async Task<CocktailDto> CreateCocktailAsync(CocktailDto cocktailDto)
        {
            var cocktail = _mapper.Map<Cocktail>(cocktailDto);
            _context.Cocktails.Add(cocktail);
            await _context.SaveChangesAsync();
            return _mapper.Map<CocktailDto>(cocktail);
        }

        public async Task<bool> UpdateCocktailAsync(CocktailDto cocktailDto)
        {
            var cocktail = _mapper.Map<Cocktail>(cocktailDto);
            _context.Entry(cocktail).State = EntityState.Modified;
            try
            {
                await _context.SaveChangesAsync();
                return true;
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CocktailExists(cocktailDto.Id))
                {
                    return false;
                }
                throw;
            }
        }

        public async Task<bool> DeleteCocktailAsync(int id)
        {
            var cocktail = await _context.Cocktails.FindAsync(id);
            if (cocktail == null)
            {
                return false;
            }
            _context.Cocktails.Remove(cocktail);
            await _context.SaveChangesAsync();
            return true;
        }

        private bool CocktailExists(int id)
        {
            return _context.Cocktails.Any(e => e.Id == id);
        }
    }
}
