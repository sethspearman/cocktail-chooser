using System.IO;
using System.Threading;
using CocktailChooser.Data.Migrations;
using Dapper;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.Tests.Services;

public class SqlMigrationRunnerIntegrationTests : IDisposable
{
    private readonly string _databasePath;
    private readonly string _connectionString;

    public SqlMigrationRunnerIntegrationTests()
    {
        _databasePath = Path.Combine(Path.GetTempPath(), $"cocktailchooser-migrations-{Guid.NewGuid():N}.db");
        _connectionString = $"Data Source={_databasePath};Foreign Keys=True";
    }

    [Fact]
    public void Run_Twice_DoesNotDuplicateSeededCocktailTags()
    {
        SqlMigrationRunner.Run(_connectionString);

        int firstTagCount;
        int firstMigrationCount;
        using (var connection = new SqliteConnection(_connectionString))
        {
            connection.Open();
            firstTagCount = connection.ExecuteScalar<int>("SELECT COUNT(*) FROM CocktailTags;");
            firstMigrationCount = connection.ExecuteScalar<int>("SELECT COUNT(*) FROM SchemaMigrations;");
        }

        SqlMigrationRunner.Run(_connectionString);

        using var rerunConnection = new SqliteConnection(_connectionString);
        rerunConnection.Open();
        var secondTagCount = rerunConnection.ExecuteScalar<int>("SELECT COUNT(*) FROM CocktailTags;");
        var secondMigrationCount = rerunConnection.ExecuteScalar<int>("SELECT COUNT(*) FROM SchemaMigrations;");

        Assert.True(firstTagCount > 0);
        Assert.Equal(firstTagCount, secondTagCount);
        Assert.Equal(firstMigrationCount, secondMigrationCount);
    }

    public void Dispose()
    {
        SqliteConnection.ClearAllPools();

        if (File.Exists(_databasePath))
        {
            for (var attempt = 0; attempt < 5; attempt++)
            {
                try
                {
                    File.Delete(_databasePath);
                    break;
                }
                catch (IOException) when (attempt < 4)
                {
                    Thread.Sleep(50);
                }
            }
        }
    }
}
