namespace CocktailChooser.Data.Repositories;

public interface IUserRepository
{
    Task<IEnumerable<UserRecord>> GetAllAsync();
    Task<UserRecord?> GetByIdAsync(int id);
    Task<UserRecord> CreateAsync(UserRecord user);
    Task<bool> UpdateAsync(UserRecord user);
    Task<bool> DeleteAsync(int id);
}
