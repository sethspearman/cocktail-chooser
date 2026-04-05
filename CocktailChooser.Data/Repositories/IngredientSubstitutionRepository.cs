using Dapper;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.Data.Repositories;

public class IngredientSubstitutionRepository : IIngredientSubstitutionRepository
{
    private readonly string _connectionString;

    public IngredientSubstitutionRepository(string connectionString)
    {
        _connectionString = connectionString;
    }

    public async Task<IEnumerable<IngredientSubstitutionRecord>> GetByIngredientIdsAsync(IEnumerable<int> ingredientIds)
    {
        var ids = ingredientIds
            .Distinct()
            .ToArray();

        if (ids.Length == 0)
        {
            return Array.Empty<IngredientSubstitutionRecord>();
        }

        const string sql = """
            SELECT
                s.Id,
                s.IngredientId,
                source.Name AS IngredientName,
                s.SubstituteIngredientId,
                substitute.Name AS SubstituteIngredientName,
                s.ConfidenceScore,
                s.Notes,
                s.CreatedUtc
            FROM IngredientSubstitutions s
            INNER JOIN Ingredients source ON source.Id = s.IngredientId
            INNER JOIN Ingredients substitute ON substitute.Id = s.SubstituteIngredientId
            WHERE s.IngredientId IN @IngredientIds
            ORDER BY source.Name, substitute.Name;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<IngredientSubstitutionRecord>(sql, new { IngredientIds = ids });
    }
}
