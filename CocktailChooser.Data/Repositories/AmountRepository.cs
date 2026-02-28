using Dapper;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.Data.Repositories;

public class AmountRepository : IAmountRepository
{
    private readonly string _connectionString;

    public AmountRepository(string connectionString)
    {
        _connectionString = connectionString;
    }

    public async Task<IEnumerable<AmountRecord>> GetAllAsync()
    {
        const string sql = """
            SELECT
                Id,
                MeasurementName,
                CAST(
                    CASE
                        WHEN Ounces IS NULL THEN NULL
                        WHEN TRIM(CAST(Ounces AS TEXT)) = '' THEN NULL
                        WHEN UPPER(TRIM(CAST(Ounces AS TEXT))) IN ('NULL', 'N/A') THEN NULL
                        -- Preserve only simple numeric text formats for conversion.
                        WHEN REPLACE(REPLACE(TRIM(CAST(Ounces AS TEXT)), '.', ''), '-', '') GLOB '[0-9]*'
                            THEN CAST(TRIM(CAST(Ounces AS TEXT)) AS REAL)
                        ELSE NULL
                    END
                AS REAL) AS Ounces
            FROM Amounts
            ORDER BY MeasurementName;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<AmountRecord>(sql);
    }
}
