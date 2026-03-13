using System.IO;
using System.Threading;
using CocktailChooser.Data.Repositories;
using Dapper;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.Tests.Services;

public class CollectionRepositoryIntegrationTests : IDisposable
{
    private readonly string _databasePath;
    private readonly string _connectionString;
    private readonly CollectionRepository _repository;

    public CollectionRepositoryIntegrationTests()
    {
        _databasePath = Path.Combine(Path.GetTempPath(), $"cocktailchooser-collections-{Guid.NewGuid():N}.db");
        _connectionString = $"Data Source={_databasePath};Foreign Keys=True";
        _repository = new CollectionRepository(_connectionString);
        InitializeDatabase();
    }

    [Fact]
    public async Task CreateAsync_AndGetCocktails_RoundTrip()
    {
        var collection = await _repository.CreateAsync(new CollectionRecord
        {
            Name = "Favorites",
            Description = "Personal picks",
            OwnerUserId = 42,
            IsSystemCollection = 0
        });

        await _repository.AddCocktailAsync(collection.Id, 1);
        await _repository.AddCocktailAsync(collection.Id, 1);

        var cocktails = (await _repository.GetCocktailsAsync(collection.Id)).ToList();

        Assert.Single(cocktails);
        Assert.Equal("Negroni", cocktails[0].CocktailName);
    }

    [Fact]
    public async Task RemoveCocktailAsync_RemovesExistingLink()
    {
        var collection = await _repository.CreateAsync(new CollectionRecord
        {
            Name = "Patio",
            OwnerUserId = 42
        });
        await _repository.AddCocktailAsync(collection.Id, 2);

        var removed = await _repository.RemoveCocktailAsync(collection.Id, 2);

        Assert.True(removed);
        Assert.Empty(await _repository.GetCocktailsAsync(collection.Id));
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
            CREATE TABLE IF NOT EXISTS Collections (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                Name TEXT NOT NULL,
                Description TEXT,
                OwnerUserId INTEGER,
                IsSystemCollection INTEGER NOT NULL DEFAULT 0,
                CreatedUtc TEXT NOT NULL
            );
            CREATE TABLE IF NOT EXISTS CollectionCocktails (
                CollectionId INTEGER NOT NULL,
                CocktailId INTEGER NOT NULL,
                CreatedUtc TEXT NOT NULL,
                PRIMARY KEY (CollectionId, CocktailId)
            );
            INSERT INTO Cocktails (Id, CanonicalKey, Name) VALUES (1, 'manual::negroni', 'Negroni');
            INSERT INTO Cocktails (Id, CanonicalKey, Name) VALUES (2, 'manual::aperol_spritz', 'Aperol Spritz');
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
