using Dapper;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.Data.Repositories;

public class UserIngredientRepository : IUserIngredientRepository
{
    private readonly string _connectionString;

    public UserIngredientRepository(string connectionString)
    {
        _connectionString = connectionString;
    }

    public async Task<IEnumerable<UserIngredientRecord>> GetByUserIdAsync(int userId)
    {
        const string sql = """
            SELECT
                ui.UserId,
                ui.IngredientId,
                i.Name AS IngredientName,
                ui.IsInStock,
                ui.Notes,
                ui.UpdatedUtc
            FROM UserIngredients ui
            INNER JOIN Ingredients i ON i.Id = ui.IngredientId
            WHERE ui.UserId = @UserId
            ORDER BY i.Name;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<UserIngredientRecord>(sql, new { UserId = userId });
    }

    public async Task<UserIngredientRecord> UpsertAsync(int userId, int ingredientId, int isInStock, string? notes, string updatedUtc)
    {
        const string sql = """
            INSERT INTO UserIngredients (UserId, IngredientId, IsInStock, Notes, UpdatedUtc)
            VALUES (@UserId, @IngredientId, @IsInStock, @Notes, @UpdatedUtc)
            ON CONFLICT(UserId, IngredientId)
            DO UPDATE SET
                IsInStock = excluded.IsInStock,
                Notes = excluded.Notes,
                UpdatedUtc = excluded.UpdatedUtc;
            """;

        const string selectSql = """
            SELECT
                ui.UserId,
                ui.IngredientId,
                i.Name AS IngredientName,
                ui.IsInStock,
                ui.Notes,
                ui.UpdatedUtc
            FROM UserIngredients ui
            INNER JOIN Ingredients i ON i.Id = ui.IngredientId
            WHERE ui.UserId = @UserId AND ui.IngredientId = @IngredientId;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        await connection.ExecuteAsync(sql, new
        {
            UserId = userId,
            IngredientId = ingredientId,
            IsInStock = isInStock,
            Notes = notes,
            UpdatedUtc = updatedUtc
        });

        return (await connection.QuerySingleAsync<UserIngredientRecord>(selectSql, new
        {
            UserId = userId,
            IngredientId = ingredientId
        }))!;
    }

    public async Task<bool> DeleteAsync(int userId, int ingredientId)
    {
        const string sql = "DELETE FROM UserIngredients WHERE UserId = @UserId AND IngredientId = @IngredientId;";
        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.ExecuteAsync(sql, new { UserId = userId, IngredientId = ingredientId });
        return rows > 0;
    }
}
