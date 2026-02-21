using Dapper;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.Data.Repositories;

public class IngredientRepository : IIngredientRepository
{
    private readonly string _connectionString;

    public IngredientRepository(string connectionString)
    {
        _connectionString = connectionString;
    }

    public async Task<IEnumerable<IngredientRecord>> GetAllAsync()
    {
        const string sql = """
            SELECT
                Id,
                Name,
                IngredientTypeId,
                MixerSubtypeId,
                PrimarySpirit,
                LongDescription
            FROM Ingredients
            ORDER BY Name;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<IngredientRecord>(sql);
    }

    public async Task<IngredientRecord?> GetByIdAsync(int id)
    {
        const string sql = """
            SELECT
                Id,
                Name,
                IngredientTypeId,
                MixerSubtypeId,
                PrimarySpirit,
                LongDescription
            FROM Ingredients
            WHERE Id = @Id;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QuerySingleOrDefaultAsync<IngredientRecord>(sql, new { Id = id });
    }

    public async Task<IngredientRecord> CreateAsync(IngredientRecord ingredient)
    {
        const string sql = """
            INSERT INTO Ingredients
            (
                Name,
                IngredientTypeId,
                MixerSubtypeId,
                PrimarySpirit,
                LongDescription
            )
            VALUES
            (
                @Name,
                @IngredientTypeId,
                @MixerSubtypeId,
                @PrimarySpirit,
                @LongDescription
            );
            SELECT last_insert_rowid();
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var id = await connection.ExecuteScalarAsync<long>(sql, ingredient);
        return (await GetByIdAsync((int)id))!;
    }

    public async Task<bool> UpdateAsync(IngredientRecord ingredient)
    {
        const string sql = """
            UPDATE Ingredients
            SET
                Name = @Name,
                IngredientTypeId = @IngredientTypeId,
                MixerSubtypeId = @MixerSubtypeId,
                PrimarySpirit = @PrimarySpirit,
                LongDescription = @LongDescription
            WHERE Id = @Id;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.ExecuteAsync(sql, ingredient);
        return rows > 0;
    }

    public async Task<bool> DeleteAsync(int id)
    {
        const string sql = "DELETE FROM Ingredients WHERE Id = @Id;";
        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.ExecuteAsync(sql, new { Id = id });
        return rows > 0;
    }
}
