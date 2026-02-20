using Dapper;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.Data.Repositories;

public class RecipeRepository : IRecipeRepository
{
    private readonly string _connectionString;

    public RecipeRepository(string connectionString)
    {
        _connectionString = connectionString;
    }

    public async Task<IEnumerable<RecipeRecord>> GetAllAsync()
    {
        const string sql = """
            SELECT
                Id,
                Id AS CocktailId,
                CocktailSourceId AS RecipeSourceId,
                SourceRecipeName,
                AttributionText,
                SourceUrl,
                Method,
                FlavorProfile,
                Notes,
                IsUserSubmitted,
                CreatedUtc,
                UpdatedUtc
            FROM Cocktails
            ORDER BY Id;
            """;
        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<RecipeRecord>(sql);
    }

    public async Task<RecipeRecord?> GetByIdAsync(int id)
    {
        const string sql = """
            SELECT
                Id,
                Id AS CocktailId,
                CocktailSourceId AS RecipeSourceId,
                SourceRecipeName,
                AttributionText,
                SourceUrl,
                Method,
                FlavorProfile,
                Notes,
                IsUserSubmitted,
                CreatedUtc,
                UpdatedUtc
            FROM Cocktails
            WHERE Id = @Id;
            """;
        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QuerySingleOrDefaultAsync<RecipeRecord>(sql, new { Id = id });
    }

    public async Task<IEnumerable<RecipeRecord>> GetByCocktailIdAsync(int cocktailId)
    {
        const string sql = """
            SELECT
                Id,
                Id AS CocktailId,
                CocktailSourceId AS RecipeSourceId,
                SourceRecipeName,
                AttributionText,
                SourceUrl,
                Method,
                FlavorProfile,
                Notes,
                IsUserSubmitted,
                CreatedUtc,
                UpdatedUtc
            FROM Cocktails
            WHERE Id = @CocktailId
            ORDER BY Id;
            """;
        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<RecipeRecord>(sql, new { CocktailId = cocktailId });
    }

    public async Task<IEnumerable<RecipeRecord>> GetBySourceIdAsync(int recipeSourceId)
    {
        const string sql = """
            SELECT
                Id,
                Id AS CocktailId,
                CocktailSourceId AS RecipeSourceId,
                SourceRecipeName,
                AttributionText,
                SourceUrl,
                Method,
                FlavorProfile,
                Notes,
                IsUserSubmitted,
                CreatedUtc,
                UpdatedUtc
            FROM Cocktails
            WHERE CocktailSourceId = @RecipeSourceId
            ORDER BY Id;
            """;
        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<RecipeRecord>(sql, new { RecipeSourceId = recipeSourceId });
    }

    public async Task<IEnumerable<RecipeRecord>> SearchAsync(int? cocktailId, int? recipeSourceId)
    {
        const string sql = """
            SELECT
                Id,
                Id AS CocktailId,
                CocktailSourceId AS RecipeSourceId,
                SourceRecipeName,
                AttributionText,
                SourceUrl,
                Method,
                FlavorProfile,
                Notes,
                IsUserSubmitted,
                CreatedUtc,
                UpdatedUtc
            FROM Cocktails
            WHERE (@CocktailId IS NULL OR Id = @CocktailId)
              AND (@RecipeSourceId IS NULL OR CocktailSourceId = @RecipeSourceId)
            ORDER BY Id;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<RecipeRecord>(sql, new
        {
            CocktailId = cocktailId,
            RecipeSourceId = recipeSourceId
        });
    }

    public async Task<RecipeRecord> CreateAsync(RecipeRecord recipe)
    {
        const string sql = """
            INSERT INTO Cocktails
            (
                Name,
                Description,
                GlassTypeId,
                TimePeriodId,
                IsPopular,
                CocktailSourceId,
                SourceRecipeName,
                AttributionText,
                SourceUrl,
                Method,
                FlavorProfile,
                Notes,
                IsUserSubmitted,
                CreatedUtc,
                UpdatedUtc
            )
            VALUES
            (
                COALESCE(@SourceRecipeName, 'Unnamed Cocktail'),
                NULL,
                NULL,
                NULL,
                0,
                @RecipeSourceId,
                @SourceRecipeName,
                @AttributionText,
                @SourceUrl,
                @Method,
                @FlavorProfile,
                @Notes,
                @IsUserSubmitted,
                COALESCE(@CreatedUtc, @UpdatedUtc),
                @UpdatedUtc
            );
            SELECT last_insert_rowid();
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var id = await connection.ExecuteScalarAsync<long>(sql, recipe);
        return (await GetByIdAsync((int)id))!;
    }

    public async Task<bool> UpdateAsync(RecipeRecord recipe)
    {
        const string sql = """
            UPDATE Cocktails
            SET
                CocktailSourceId = @RecipeSourceId,
                SourceRecipeName = @SourceRecipeName,
                AttributionText = @AttributionText,
                SourceUrl = @SourceUrl,
                Method = @Method,
                FlavorProfile = @FlavorProfile,
                Notes = @Notes,
                IsUserSubmitted = @IsUserSubmitted,
                UpdatedUtc = @UpdatedUtc
            WHERE Id = @CocktailId;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.ExecuteAsync(sql, recipe);
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
