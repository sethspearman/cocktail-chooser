using Dapper;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.Data.Repositories;

public class RecipeSourceRepository : IRecipeSourceRepository
{
    private const string SelectColumns = """
        Id,
        Name,
        SourceType,
        Publisher,
        PublishDate,
        Author,
        Isbn10,
        Isbn13,
        PurchaseUrl,
        Edition,
        Language,
        CopyrightCredit,
        Url,
        Notes,
        IsBuiltIn,
        CreatedUtc
        """;

    private readonly string _connectionString;

    public RecipeSourceRepository(string connectionString)
    {
        _connectionString = connectionString;
    }

    public async Task<IEnumerable<RecipeSourceRecord>> GetAllAsync()
    {
        const string sql = $"SELECT {SelectColumns} FROM RecipeSources ORDER BY Name;";
        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<RecipeSourceRecord>(sql);
    }

    public async Task<RecipeSourceRecord?> GetByIdAsync(int id)
    {
        const string sql = $"SELECT {SelectColumns} FROM RecipeSources WHERE Id = @Id;";
        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QuerySingleOrDefaultAsync<RecipeSourceRecord>(sql, new { Id = id });
    }

    public async Task<bool> IsInUseAsync(int id)
    {
        const string sql = """
            SELECT EXISTS (
                SELECT 1
                FROM Recipes
                WHERE RecipeSourceId = @Id
            );
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.ExecuteScalarAsync<long>(sql, new { Id = id }) == 1;
    }

    public async Task<RecipeSourceRecord> CreateAsync(RecipeSourceRecord source)
    {
        const string sql = """
            INSERT INTO RecipeSources
            (
                Name,
                SourceType,
                Publisher,
                PublishDate,
                Author,
                Isbn10,
                Isbn13,
                PurchaseUrl,
                Edition,
                Language,
                CopyrightCredit,
                Url,
                Notes,
                IsBuiltIn
            )
            VALUES
            (
                @Name,
                @SourceType,
                @Publisher,
                @PublishDate,
                @Author,
                @Isbn10,
                @Isbn13,
                @PurchaseUrl,
                @Edition,
                @Language,
                @CopyrightCredit,
                @Url,
                @Notes,
                @IsBuiltIn
            );
            SELECT last_insert_rowid();
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var id = await connection.ExecuteScalarAsync<long>(sql, source);
        return (await GetByIdAsync((int)id))!;
    }

    public async Task<bool> UpdateAsync(RecipeSourceRecord source)
    {
        const string sql = """
            UPDATE RecipeSources
            SET
                Name = @Name,
                SourceType = @SourceType,
                Publisher = @Publisher,
                PublishDate = @PublishDate,
                Author = @Author,
                Isbn10 = @Isbn10,
                Isbn13 = @Isbn13,
                PurchaseUrl = @PurchaseUrl,
                Edition = @Edition,
                Language = @Language,
                CopyrightCredit = @CopyrightCredit,
                Url = @Url,
                Notes = @Notes,
                IsBuiltIn = @IsBuiltIn
            WHERE Id = @Id;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.ExecuteAsync(sql, source);
        return rows > 0;
    }

    public async Task<bool> DeleteAsync(int id)
    {
        const string sql = "DELETE FROM RecipeSources WHERE Id = @Id;";
        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.ExecuteAsync(sql, new { Id = id });
        return rows > 0;
    }
}
