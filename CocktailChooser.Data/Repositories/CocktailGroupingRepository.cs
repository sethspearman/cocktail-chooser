using Dapper;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.Data.Repositories;

public class CocktailGroupingRepository : ICocktailGroupingRepository
{
    private readonly string _connectionString;

    public CocktailGroupingRepository(string connectionString)
    {
        _connectionString = connectionString;
    }

    public async Task<IEnumerable<CocktailGroupingLinkRecord>> GetByGroupingNameAsync(string groupingName)
    {
        const string sql = """
            SELECT CocktailId, CocktailSourceId, GroupingName
            FROM CocktailGroupingLinks
            WHERE GroupingName = @GroupingName
            ORDER BY CocktailId, CocktailSourceId;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<CocktailGroupingLinkRecord>(sql, new { GroupingName = groupingName });
    }

    public async Task<IEnumerable<CocktailGroupingLinkRecord>> GetByCocktailIdAsync(int cocktailId)
    {
        const string sql = """
            SELECT CocktailId, CocktailSourceId, GroupingName
            FROM CocktailGroupingLinks
            WHERE CocktailId = @CocktailId
            ORDER BY GroupingName, CocktailSourceId;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<CocktailGroupingLinkRecord>(sql, new { CocktailId = cocktailId });
    }

    public async Task<IEnumerable<CocktailGroupingCocktailRecord>> GetCocktailsByGroupingNameAsync(string groupingName)
    {
        const string sql = """
            SELECT
                cgl.GroupingName,
                c.Id AS CocktailId,
                c.Name AS CocktailName,
                cgl.CocktailSourceId,
                cs.Name AS CocktailSourceName
            FROM CocktailGroupingLinks cgl
            INNER JOIN Cocktails c ON c.Id = cgl.CocktailId
            INNER JOIN CocktailSource cs ON cs.Id = cgl.CocktailSourceId
            WHERE cgl.GroupingName = @GroupingName
            ORDER BY c.Name, cs.Name;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<CocktailGroupingCocktailRecord>(sql, new { GroupingName = groupingName });
    }

    public async Task<CocktailGroupingLinkRecord> UpsertAsync(CocktailGroupingLinkRecord link)
    {
        const string sql = """
            INSERT INTO CocktailGroupingLinks (CocktailId, CocktailSourceId, GroupingName)
            VALUES (@CocktailId, @CocktailSourceId, @GroupingName)
            ON CONFLICT(CocktailId, CocktailSourceId, GroupingName) DO NOTHING;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        await connection.ExecuteAsync(sql, link);
        return link;
    }

    public async Task<bool> RenameAsync(int cocktailId, int cocktailSourceId, string groupingName, string newGroupingName)
    {
        const string sql = """
            UPDATE CocktailGroupingLinks
            SET GroupingName = @NewGroupingName
            WHERE CocktailId = @CocktailId
              AND CocktailSourceId = @CocktailSourceId
              AND GroupingName = @GroupingName;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.ExecuteAsync(sql, new
        {
            CocktailId = cocktailId,
            CocktailSourceId = cocktailSourceId,
            GroupingName = groupingName,
            NewGroupingName = newGroupingName
        });

        return rows > 0;
    }
}
