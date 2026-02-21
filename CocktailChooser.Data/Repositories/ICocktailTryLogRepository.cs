namespace CocktailChooser.Data.Repositories;

public interface ICocktailTryLogRepository
{
    Task<CocktailTryLogRecord?> GetByIdAsync(int id);
    Task<IEnumerable<CocktailTryLogRecord>> GetByCocktailIdAsync(int cocktailId, int? userId = null);
    Task<IEnumerable<CocktailTryLogRecord>> GetByUserIdAsync(int userId);
    Task<CocktailTryLogRecord> CreateAsync(CocktailTryLogRecord log);
    Task<bool> UpdateAsync(CocktailTryLogRecord log);
    Task<bool> DeleteAsync(int id);
}
