using System.IO;
using System.Threading;
using CocktailChooser.Data.Repositories;
using Dapper;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.Tests.Services;

public class CocktailTagRepositoryIntegrationTests : IDisposable
{
    private readonly string _databasePath;
    private readonly string _connectionString;
    private readonly CocktailTagRepository _repository;

    public CocktailTagRepositoryIntegrationTests()
    {
        _databasePath = Path.Combine(Path.GetTempPath(), $"cocktailchooser-tags-{Guid.NewGuid():N}.db");
        _connectionString = $"Data Source={_databasePath};Foreign Keys=True";
        _repository = new CocktailTagRepository(_connectionString);
        InitializeDatabase();
    }

    [Fact]
    public async Task AssignTagToCocktailAsync_IsIdempotent()
    {
        await _repository.AssignTagToCocktailAsync(1, 1);
        await _repository.AssignTagToCocktailAsync(1, 1);

        using var connection = new SqliteConnection(_connectionString);
        var count = connection.ExecuteScalar<int>(
            "SELECT COUNT(*) FROM CocktailTags WHERE CocktailId = 1 AND TagId = 1;");

        Assert.Equal(1, count);
    }

    [Fact]
    public async Task GetCocktailIdsForTagsAsync_MatchAll_RequiresAllRequestedTags()
    {
        await _repository.AssignTagToCocktailAsync(1, 1);
        await _repository.AssignTagToCocktailAsync(1, 2);
        await _repository.AssignTagToCocktailAsync(2, 1);

        var result = await _repository.GetCocktailIdsForTagsAsync(new[] { "bitter", "stirred" }, matchAll: true);

        Assert.Single(result);
        Assert.Contains(1, result);
    }

    private void InitializeDatabase()
    {
        using var connection = new SqliteConnection(_connectionString);
        connection.Execute("""
            CREATE TABLE IF NOT EXISTS Cocktails (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                CanonicalKey TEXT NOT NULL UNIQUE,
                Name TEXT NOT NULL
            );
            CREATE TABLE IF NOT EXISTS TagTypes (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                Name TEXT NOT NULL,
                Description TEXT,
                IsSeeded INTEGER NOT NULL DEFAULT 0,
                CreatedUtc TEXT NOT NULL
            );
            CREATE TABLE IF NOT EXISTS Tags (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                TagTypeId INTEGER NOT NULL,
                Name TEXT NOT NULL,
                NormalizedName TEXT NOT NULL,
                CreatedUtc TEXT NOT NULL
            );
            CREATE TABLE IF NOT EXISTS CocktailTags (
                CocktailId INTEGER NOT NULL,
                TagId INTEGER NOT NULL,
                CreatedUtc TEXT NOT NULL,
                PRIMARY KEY (CocktailId, TagId)
            );
            INSERT INTO Cocktails (Id, CanonicalKey, Name) VALUES (1, 'manual::negroni', 'Negroni');
            INSERT INTO Cocktails (Id, CanonicalKey, Name) VALUES (2, 'manual::daiquiri', 'Daiquiri');
            INSERT INTO TagTypes (Id, Name, Description, IsSeeded, CreatedUtc) VALUES (1, 'Flavor Profile', 'Flavor', 1, '2026-03-13T00:00:00Z');
            INSERT INTO TagTypes (Id, Name, Description, IsSeeded, CreatedUtc) VALUES (2, 'Build Method', 'Method', 1, '2026-03-13T00:00:00Z');
            INSERT INTO Tags (Id, TagTypeId, Name, NormalizedName, CreatedUtc) VALUES (1, 1, 'Bitter', 'bitter', '2026-03-13T00:00:00Z');
            INSERT INTO Tags (Id, TagTypeId, Name, NormalizedName, CreatedUtc) VALUES (2, 2, 'Stirred', 'stirred', '2026-03-13T00:00:00Z');
            """);
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
