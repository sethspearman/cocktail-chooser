namespace CocktailChooser.Data.Repositories;

public interface IUserRepository
{
    Task<IEnumerable<UserRecord>> GetAllAsync();
    Task<UserRecord?> GetByIdAsync(int id);
    Task<UserRecord?> GetByEmailAsync(string email);
    Task<UserRecord> CreateAsync(UserRecord user);
    Task<bool> UpdateAsync(UserRecord user);
    Task<bool> DeleteAsync(int id);
}
