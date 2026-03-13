using Dapper;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.Data.Repositories;

public class CocktailTagRepository : ICocktailTagRepository
{
    private readonly string _connectionString;

    public CocktailTagRepository(string connectionString)
    {
        _connectionString = connectionString;
    }

    public async Task<IEnumerable<TagTypeRecord>> GetTagTypesAsync()
    {
        const string sql = """
            SELECT Id, Name, Description, IsSeeded, CreatedUtc
            FROM TagTypes
            ORDER BY Name;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<TagTypeRecord>(sql);
    }

    public async Task<IEnumerable<TagRecord>> GetTagsByTypeAsync(int? tagTypeId = null, string? tagTypeName = null)
    {
        const string sql = """
            SELECT
                t.Id,
                t.TagTypeId,
                tt.Name AS TagTypeName,
                t.Name,
                t.NormalizedName,
                t.CreatedUtc
            FROM Tags t
            INNER JOIN TagTypes tt ON tt.Id = t.TagTypeId
            WHERE (@TagTypeId IS NULL OR t.TagTypeId = @TagTypeId)
              AND (@TagTypeName IS NULL OR tt.Name = @TagTypeName)
            ORDER BY tt.Name, t.Name;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<TagRecord>(sql, new { TagTypeId = tagTypeId, TagTypeName = tagTypeName });
    }

    public async Task<IEnumerable<CocktailTagRecord>> GetCocktailTagsAsync(int cocktailId)
    {
        const string sql = """
            SELECT
                ct.CocktailId,
                ct.TagId,
                t.TagTypeId,
                tt.Name AS TagTypeName,
                t.Name AS TagName,
                t.NormalizedName AS TagNormalizedName,
                ct.CreatedUtc
            FROM CocktailTags ct
            INNER JOIN Tags t ON t.Id = ct.TagId
            INNER JOIN TagTypes tt ON tt.Id = t.TagTypeId
            WHERE ct.CocktailId = @CocktailId
            ORDER BY tt.Name, t.Name;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<CocktailTagRecord>(sql, new { CocktailId = cocktailId });
    }

    public async Task<IDictionary<int, List<CocktailTagRecord>>> GetCocktailTagsByCocktailIdsAsync(IEnumerable<int> cocktailIds)
    {
        var ids = cocktailIds.Distinct().ToArray();
        if (ids.Length == 0)
        {
            return new Dictionary<int, List<CocktailTagRecord>>();
        }

        const string sql = """
            SELECT
                ct.CocktailId,
                ct.TagId,
                t.TagTypeId,
                tt.Name AS TagTypeName,
                t.Name AS TagName,
                t.NormalizedName AS TagNormalizedName,
                ct.CreatedUtc
            FROM CocktailTags ct
            INNER JOIN Tags t ON t.Id = ct.TagId
            INNER JOIN TagTypes tt ON tt.Id = t.TagTypeId
            WHERE ct.CocktailId IN @CocktailIds
            ORDER BY ct.CocktailId, tt.Name, t.Name;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.QueryAsync<CocktailTagRecord>(sql, new { CocktailIds = ids });
        return rows
            .GroupBy(x => x.CocktailId)
            .ToDictionary(g => g.Key, g => g.ToList());
    }

    public async Task<ISet<int>> GetCocktailIdsForTagsAsync(IEnumerable<string> normalizedTagNames, bool matchAll)
    {
        var names = normalizedTagNames
            .Select(TagSlugNormalizer.Normalize)
            .Where(x => x.Length > 0)
            .Distinct(StringComparer.Ordinal)
            .ToArray();

        if (names.Length == 0)
        {
            return new HashSet<int>();
        }

        const string sql = """
            SELECT
                ct.CocktailId,
                COUNT(DISTINCT t.NormalizedName) AS MatchCount
            FROM CocktailTags ct
            INNER JOIN Tags t ON t.Id = ct.TagId
            WHERE t.NormalizedName IN @NormalizedTagNames
            GROUP BY ct.CocktailId;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.QueryAsync<(int CocktailId, int MatchCount)>(
            sql,
            new { NormalizedTagNames = names });

        return rows
            .Where(x => !matchAll || x.MatchCount == names.Length)
            .Select(x => x.CocktailId)
            .ToHashSet();
    }

    public async Task AssignTagToCocktailAsync(int cocktailId, int tagId)
    {
        const string sql = """
            INSERT INTO CocktailTags (CocktailId, TagId, CreatedUtc)
            VALUES (@CocktailId, @TagId, strftime('%Y-%m-%dT%H:%M:%fZ', 'now'))
            ON CONFLICT(CocktailId, TagId) DO NOTHING;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        await connection.ExecuteAsync(sql, new { CocktailId = cocktailId, TagId = tagId });
    }

    public async Task<bool> RemoveTagFromCocktailAsync(int cocktailId, int tagId)
    {
        const string sql = """
            DELETE FROM CocktailTags
            WHERE CocktailId = @CocktailId
              AND TagId = @TagId;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.ExecuteAsync(sql, new { CocktailId = cocktailId, TagId = tagId });
        return rows > 0;
    }
}
