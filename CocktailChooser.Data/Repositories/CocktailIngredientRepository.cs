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
                a.MeasurementName AS AmountName,
                ci.AmountText,
                ci.SortOrder
            FROM CocktailIngredients ci
            INNER JOIN Ingredients i ON i.Id = ci.IngredientId
            LEFT JOIN Amounts a ON a.Id = ci.AmountId
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
                a.MeasurementName AS AmountName,
                ci.AmountText,
                ci.SortOrder
            FROM CocktailIngredients ci
            INNER JOIN Ingredients i ON i.Id = ci.IngredientId
            LEFT JOIN Amounts a ON a.Id = ci.AmountId
            WHERE ci.CocktailId = @CocktailId
            ORDER BY ifnull(ci.SortOrder, 9999), i.Name;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<CocktailIngredientRecord>(sql, new { CocktailId = cocktailId });
    }

    public async Task<CocktailIngredientRecord> CreateAsync(CocktailIngredientRecord row)
    {
        const string insertSql = """
            INSERT INTO CocktailIngredients
            (
                CocktailId,
                IngredientId,
                AmountId,
                AmountText,
                SortOrder
            )
            VALUES
            (
                @CocktailId,
                @IngredientId,
                @AmountId,
                @AmountText,
                @SortOrder
            );
            SELECT last_insert_rowid();
            """;

        const string selectSql = """
            SELECT
                ci.Id,
                ci.CocktailId,
                ci.IngredientId,
                i.Name AS IngredientName,
                i.PrimarySpirit,
                ci.AmountId,
                a.MeasurementName AS AmountName,
                ci.AmountText,
                ci.SortOrder
            FROM CocktailIngredients ci
            INNER JOIN Ingredients i ON i.Id = ci.IngredientId
            LEFT JOIN Amounts a ON a.Id = ci.AmountId
            WHERE ci.Id = @Id;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var id = await connection.ExecuteScalarAsync<long>(insertSql, row);
        return (await connection.QuerySingleAsync<CocktailIngredientRecord>(selectSql, new { Id = (int)id }))!;
    }

    public async Task<int> DeleteByCocktailIdAsync(int cocktailId)
    {
        const string sql = """
            DELETE FROM CocktailIngredients
            WHERE CocktailId = @CocktailId;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.ExecuteAsync(sql, new { CocktailId = cocktailId });
    }
}
