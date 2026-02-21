using Dapper;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.Data.Repositories;

public class CocktailIngredientRepository : ICocktailIngredientRepository
{
    private readonly string _connectionString;

    public CocktailIngredientRepository(string connectionString)
    {
        _connectionString = connectionString;
    }

    public async Task<IEnumerable<CocktailIngredientRecord>> GetAllAsync()
    {
        const string sql = """
            SELECT
                ci.Id,
                ci.CocktailId,
                ci.IngredientId,
                i.Name AS IngredientName,
                i.PrimarySpirit,
                ci.AmountId,
                ci.AmountText,
                ci.SortOrder
            FROM CocktailIngredients ci
            INNER JOIN Ingredients i ON i.Id = ci.IngredientId
            ORDER BY ci.CocktailId, ifnull(ci.SortOrder, 9999), i.Name;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<CocktailIngredientRecord>(sql);
    }

    public async Task<IEnumerable<CocktailIngredientRecord>> GetByCocktailIdAsync(int cocktailId)
    {
        const string sql = """
            SELECT
                ci.Id,
                ci.CocktailId,
                ci.IngredientId,
                i.Name AS IngredientName,
                i.PrimarySpirit,
                ci.AmountId,
                ci.AmountText,
                ci.SortOrder
            FROM CocktailIngredients ci
            INNER JOIN Ingredients i ON i.Id = ci.IngredientId
            WHERE ci.CocktailId = @CocktailId
            ORDER BY ifnull(ci.SortOrder, 9999), i.Name;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<CocktailIngredientRecord>(sql, new { CocktailId = cocktailId });
    }
}
