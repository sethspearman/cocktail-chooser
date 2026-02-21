using Dapper;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.Data.Repositories;

public class CocktailTryLogRepository : ICocktailTryLogRepository
{
    private readonly string _connectionString;

    public CocktailTryLogRepository(string connectionString)
    {
        _connectionString = connectionString;
    }

    public async Task<CocktailTryLogRecord?> GetByIdAsync(int id)
    {
        const string sql = """
            SELECT Id, UserId, CocktailId, Rating, Comment, TriedOnUtc, CreatedUtc, UpdatedUtc
            FROM CocktailTryLogs
            WHERE Id = @Id;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QuerySingleOrDefaultAsync<CocktailTryLogRecord>(sql, new { Id = id });
    }

    public async Task<IEnumerable<CocktailTryLogRecord>> GetByCocktailIdAsync(int cocktailId, int? userId = null)
    {
        const string sql = """
            SELECT Id, UserId, CocktailId, Rating, Comment, TriedOnUtc, CreatedUtc, UpdatedUtc
            FROM CocktailTryLogs
            WHERE CocktailId = @CocktailId
              AND (@UserId IS NULL OR UserId = @UserId)
            ORDER BY TriedOnUtc DESC, Id DESC;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<CocktailTryLogRecord>(sql, new { CocktailId = cocktailId, UserId = userId });
    }

    public async Task<IEnumerable<CocktailTryLogRecord>> GetByUserIdAsync(int userId)
    {
        const string sql = """
            SELECT Id, UserId, CocktailId, Rating, Comment, TriedOnUtc, CreatedUtc, UpdatedUtc
            FROM CocktailTryLogs
            WHERE UserId = @UserId
            ORDER BY TriedOnUtc DESC, Id DESC;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<CocktailTryLogRecord>(sql, new { UserId = userId });
    }

    public async Task<CocktailTryLogRecord> CreateAsync(CocktailTryLogRecord log)
    {
        const string sql = """
            INSERT INTO CocktailTryLogs
            (
                UserId,
                CocktailId,
                Rating,
                Comment,
                TriedOnUtc,
                CreatedUtc,
                UpdatedUtc
            )
            VALUES
            (
                @UserId,
                @CocktailId,
                @Rating,
                @Comment,
                @TriedOnUtc,
                @CreatedUtc,
                @UpdatedUtc
            );
            SELECT last_insert_rowid();
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var id = await connection.ExecuteScalarAsync<long>(sql, log);
        return (await GetByIdAsync((int)id))!;
    }

    public async Task<bool> UpdateAsync(CocktailTryLogRecord log)
    {
        const string sql = """
            UPDATE CocktailTryLogs
            SET
                UserId = @UserId,
                CocktailId = @CocktailId,
                Rating = @Rating,
                Comment = @Comment,
                TriedOnUtc = @TriedOnUtc,
                UpdatedUtc = @UpdatedUtc
            WHERE Id = @Id;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.ExecuteAsync(sql, log);
        return rows > 0;
    }

    public async Task<bool> DeleteAsync(int id)
    {
        const string sql = "DELETE FROM CocktailTryLogs WHERE Id = @Id;";
        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.ExecuteAsync(sql, new { Id = id });
        return rows > 0;
    }
}
