using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;
using Dapper;
using Microsoft.Data.Sqlite;

public class CocktailChooserRepository
{
    private readonly string _connectionString;

    public CocktailChooserRepository(string connectionString)
    {
        _connectionString = connectionString;
    }

    public async Task<IEnumerable<CocktailChooserRepository>> GetAllAsync()
    {
        using (IDbConnection db = new SqliteConnection(_connectionString))
        {
            return await db.QueryAsync<CocktailChooserRepository>("SELECT * FROM MyTable");
        }
    }
}
