using Dapper;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.Data.Repositories;

public class UserRepository : IUserRepository
{
    private readonly string _connectionString;

    public UserRepository(string connectionString)
    {
        _connectionString = connectionString;
    }

    public async Task<IEnumerable<UserRecord>> GetAllAsync()
    {
        const string sql = """
            SELECT Id, DisplayName, Email, PasswordHash, PasswordSalt, PasswordIterations, CreatedUtc, UpdatedUtc
            FROM Users
            ORDER BY DisplayName;
            """;
        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<UserRecord>(sql);
    }

    public async Task<UserRecord?> GetByIdAsync(int id)
    {
        const string sql = """
            SELECT Id, DisplayName, Email, PasswordHash, PasswordSalt, PasswordIterations, CreatedUtc, UpdatedUtc
            FROM Users
            WHERE Id = @Id;
            """;
        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QuerySingleOrDefaultAsync<UserRecord>(sql, new { Id = id });
    }

    public async Task<UserRecord?> GetByEmailAsync(string email)
    {
        const string sql = """
            SELECT Id, DisplayName, Email, PasswordHash, PasswordSalt, PasswordIterations, CreatedUtc, UpdatedUtc
            FROM Users
            WHERE Email IS NOT NULL
              AND lower(Email) = lower(@Email)
            LIMIT 1;
            """;
        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QuerySingleOrDefaultAsync<UserRecord>(sql, new { Email = email });
    }

    public async Task<UserRecord> CreateAsync(UserRecord user)
    {
        const string sql = """
            INSERT INTO Users (DisplayName, Email, PasswordHash, PasswordSalt, PasswordIterations, CreatedUtc, UpdatedUtc)
            VALUES (@DisplayName, @Email, @PasswordHash, @PasswordSalt, @PasswordIterations, @CreatedUtc, @UpdatedUtc);
            SELECT last_insert_rowid();
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var id = await connection.ExecuteScalarAsync<long>(sql, user);
        return (await GetByIdAsync((int)id))!;
    }

    public async Task<bool> UpdateAsync(UserRecord user)
    {
        const string sql = """
            UPDATE Users
            SET
                DisplayName = @DisplayName,
                Email = @Email,
                PasswordHash = @PasswordHash,
                PasswordSalt = @PasswordSalt,
                PasswordIterations = @PasswordIterations,
                UpdatedUtc = @UpdatedUtc
            WHERE Id = @Id;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.ExecuteAsync(sql, user);
        return rows > 0;
    }

    public async Task<bool> DeleteAsync(int id)
    {
        const string sql = "DELETE FROM Users WHERE Id = @Id;";
        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.ExecuteAsync(sql, new { Id = id });
        return rows > 0;
    }
}
