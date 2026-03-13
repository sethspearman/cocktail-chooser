using Dapper;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.Data.Repositories;

public class CollectionRepository : ICollectionRepository
{
    private readonly string _connectionString;

    public CollectionRepository(string connectionString)
    {
        _connectionString = connectionString;
    }

    public async Task<IEnumerable<CollectionRecord>> GetAllAsync(bool includeSystemCollections = true, int? ownerUserId = null)
    {
        const string sql = """
            SELECT
                Id,
                Name,
                Description,
                OwnerUserId,
                IsSystemCollection,
                CreatedUtc
            FROM Collections
            WHERE (@IncludeSystemCollections = 1 OR IsSystemCollection = 0)
              AND (@OwnerUserId IS NULL OR OwnerUserId = @OwnerUserId OR (IsSystemCollection = 1 AND @IncludeSystemCollections = 1))
            ORDER BY IsSystemCollection DESC, Name;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<CollectionRecord>(sql, new
        {
            IncludeSystemCollections = includeSystemCollections ? 1 : 0,
            OwnerUserId = ownerUserId
        });
    }

    public async Task<CollectionRecord?> GetByIdAsync(int id)
    {
        const string sql = """
            SELECT
                Id,
                Name,
                Description,
                OwnerUserId,
                IsSystemCollection,
                CreatedUtc
            FROM Collections
            WHERE Id = @Id;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QuerySingleOrDefaultAsync<CollectionRecord>(sql, new { Id = id });
    }

    public async Task<IEnumerable<CollectionCocktailRecord>> GetCocktailsAsync(int collectionId)
    {
        const string sql = """
            SELECT
                cc.CollectionId,
                cc.CocktailId,
                cc.CreatedUtc,
                c.Name AS CocktailName,
                c.CanonicalKey AS CocktailCanonicalKey
            FROM CollectionCocktails cc
            INNER JOIN Cocktails c ON c.Id = cc.CocktailId
            WHERE cc.CollectionId = @CollectionId
            ORDER BY c.Name;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<CollectionCocktailRecord>(sql, new { CollectionId = collectionId });
    }

    public async Task<CollectionRecord> CreateAsync(CollectionRecord collection)
    {
        const string sql = """
            INSERT INTO Collections (Name, Description, OwnerUserId, IsSystemCollection, CreatedUtc)
            VALUES (@Name, @Description, @OwnerUserId, @IsSystemCollection, COALESCE(@CreatedUtc, strftime('%Y-%m-%dT%H:%M:%fZ', 'now')));
            SELECT last_insert_rowid();
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var id = await connection.ExecuteScalarAsync<long>(sql, collection);
        return (await GetByIdAsync((int)id))!;
    }

    public async Task<bool> UpdateAsync(CollectionRecord collection)
    {
        const string sql = """
            UPDATE Collections
            SET
                Name = @Name,
                Description = @Description,
                OwnerUserId = @OwnerUserId,
                IsSystemCollection = @IsSystemCollection
            WHERE Id = @Id;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.ExecuteAsync(sql, collection);
        return rows > 0;
    }

    public async Task<bool> DeleteAsync(int id)
    {
        const string sql = "DELETE FROM Collections WHERE Id = @Id;";

        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.ExecuteAsync(sql, new { Id = id });
        return rows > 0;
    }

    public async Task AddCocktailAsync(int collectionId, int cocktailId)
    {
        const string sql = """
            INSERT INTO CollectionCocktails (CollectionId, CocktailId, CreatedUtc)
            VALUES (@CollectionId, @CocktailId, strftime('%Y-%m-%dT%H:%M:%fZ', 'now'))
            ON CONFLICT(CollectionId, CocktailId) DO NOTHING;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        await connection.ExecuteAsync(sql, new { CollectionId = collectionId, CocktailId = cocktailId });
    }

    public async Task<bool> RemoveCocktailAsync(int collectionId, int cocktailId)
    {
        const string sql = """
            DELETE FROM CollectionCocktails
            WHERE CollectionId = @CollectionId
              AND CocktailId = @CocktailId;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.ExecuteAsync(sql, new { CollectionId = collectionId, CocktailId = cocktailId });
        return rows > 0;
    }
}
