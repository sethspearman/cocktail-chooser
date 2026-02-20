using Dapper;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.Data.Repositories;

public class CocktailRecipeRepository : ICocktailRecipeRepository
{
    private readonly string _connectionString;

    public CocktailRecipeRepository(string connectionString)
    {
        _connectionString = connectionString;
    }

    public async Task<IEnumerable<CocktailRecipeRecord>> GetAllAsync()
    {
        const string sql = """
            SELECT CocktailId, StepNumber, Instruction
            FROM CocktailSteps
            ORDER BY CocktailId, StepNumber;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<CocktailRecipeRecord>(sql);
    }

    public async Task<IEnumerable<CocktailRecipeRecord>> GetByCocktailIdAsync(int cocktailId)
    {
        const string sql = """
            SELECT CocktailId, StepNumber, Instruction
            FROM CocktailSteps
            WHERE CocktailId = @CocktailId
            ORDER BY StepNumber;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<CocktailRecipeRecord>(sql, new { CocktailId = cocktailId });
    }

    public async Task<CocktailRecipeRecord?> GetByIdAsync(int cocktailId, int stepNumber)
    {
        const string sql = """
            SELECT CocktailId, StepNumber, Instruction
            FROM CocktailSteps
            WHERE CocktailId = @CocktailId AND StepNumber = @StepNumber;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QuerySingleOrDefaultAsync<CocktailRecipeRecord>(sql, new
        {
            CocktailId = cocktailId,
            StepNumber = stepNumber
        });
    }

    public async Task<CocktailRecipeRecord> CreateAsync(CocktailRecipeRecord recipe)
    {
        const string sql = """
            INSERT INTO CocktailSteps (CocktailId, StepNumber, Instruction)
            VALUES (@CocktailId, @StepNumber, @Instruction);
            """;

        await using var connection = new SqliteConnection(_connectionString);
        await connection.ExecuteAsync(sql, recipe);
        return (await GetByIdAsync(recipe.CocktailId, recipe.StepNumber))!;
    }

    public async Task<bool> UpdateAsync(CocktailRecipeRecord recipe)
    {
        const string sql = """
            UPDATE CocktailSteps
            SET Instruction = @Instruction
            WHERE CocktailId = @CocktailId AND StepNumber = @StepNumber;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.ExecuteAsync(sql, recipe);
        return rows > 0;
    }

    public async Task<bool> DeleteAsync(int cocktailId, int stepNumber)
    {
        const string sql = """
            DELETE FROM CocktailSteps
            WHERE CocktailId = @CocktailId AND StepNumber = @StepNumber;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.ExecuteAsync(sql, new { CocktailId = cocktailId, StepNumber = stepNumber });
        return rows > 0;
    }
}
