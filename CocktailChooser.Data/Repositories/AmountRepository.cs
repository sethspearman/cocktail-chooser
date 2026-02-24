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
            SELECT Id, MeasurementName, Ounces
            FROM Amounts
            ORDER BY MeasurementName;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<AmountRecord>(sql);
    }
}
