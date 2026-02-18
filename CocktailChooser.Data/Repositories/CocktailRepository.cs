using Dapper;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.Data.Repositories;

public class CocktailRepository : ICocktailRepository
{
    private const string SelectColumns = """
        Id,
        Name,
        Description,
        Method,
        GlassTypeId,
        TimePeriodId,
        IsPopular,
        CocktailSourceID AS CocktailSourceId
        """;

    private readonly string _connectionString;

    public CocktailRepository(string connectionString)
    {
        _connectionString = connectionString;
    }

    public async Task<IEnumerable<CocktailRecord>> GetAllAsync()
    {
        const string sql = $"SELECT {SelectColumns} FROM Cocktails ORDER BY Name;";
        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<CocktailRecord>(sql);
    }

    public async Task<CocktailRecord?> GetByIdAsync(int id)
    {
        const string sql = $"SELECT {SelectColumns} FROM Cocktails WHERE Id = @Id;";
        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QuerySingleOrDefaultAsync<CocktailRecord>(sql, new { Id = id });
    }

    public async Task<CocktailRecord> CreateAsync(CocktailRecord cocktail)
    {
        const string sql = """
            INSERT INTO Cocktails
            (
                Name,
                Description,
                Method,
                GlassTypeId,
                TimePeriodId,
                IsPopular,
                CocktailSourceID
            )
            VALUES
            (
                @Name,
                @Description,
                @Method,
                @GlassTypeId,
                @TimePeriodId,
                @IsPopular,
                @CocktailSourceId
            );
            SELECT last_insert_rowid();
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var newId = await connection.ExecuteScalarAsync<long>(sql, cocktail);
        return (await GetByIdAsync((int)newId))!;
    }

    public async Task<bool> UpdateAsync(CocktailRecord cocktail)
    {
        const string sql = """
            UPDATE Cocktails
            SET
                Name = @Name,
                Description = @Description,
                Method = @Method,
                GlassTypeId = @GlassTypeId,
                TimePeriodId = @TimePeriodId,
                IsPopular = @IsPopular,
                CocktailSourceID = @CocktailSourceId
            WHERE Id = @Id;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.ExecuteAsync(sql, cocktail);
        return rows > 0;
    }

    public async Task<bool> DeleteAsync(int id)
    {
        const string sql = "DELETE FROM Cocktails WHERE Id = @Id;";
        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.ExecuteAsync(sql, new { Id = id });
        return rows > 0;
    }
}
