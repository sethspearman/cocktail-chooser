using System;
using System.IO;
using System.Threading;
using CocktailChooser.Data.Repositories;
using Dapper;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.Tests.Services;

public class CocktailRepositoryIntegrationTests : IDisposable
{
    private readonly string _databasePath;
    private readonly string _connectionString;
    private readonly CocktailRepository _repository;

    public CocktailRepositoryIntegrationTests()
    {
        _databasePath = Path.Combine(Path.GetTempPath(), $"cocktailchooser-{Guid.NewGuid():N}.db");
        _connectionString = $"Data Source={_databasePath};Foreign Keys=True";
        _repository = new CocktailRepository(_connectionString);
        InitializeDatabase();
    }

    [Fact]
    public async Task CreateAndGetByIdAsync_RoundTripsCocktail()
    {
        var created = await _repository.CreateAsync(new CocktailRecord
        {
            Name = "Old Fashioned",
            Method = "Stir with ice"
        });

        var loaded = await _repository.GetByIdAsync(created.Id);

        Assert.NotNull(loaded);
        Assert.Equal("Old Fashioned", loaded.Name);
        Assert.Equal("Stir with ice", loaded.Method);
    }

    [Fact]
    public async Task UpdateAsync_ReturnsFalse_WhenCocktailMissing()
    {
        var updated = await _repository.UpdateAsync(new CocktailRecord
        {
            Id = 404,
            Name = "Missing"
        });

        Assert.False(updated);
    }

    [Fact]
    public async Task DeleteAsync_RemovesCocktail()
    {
        var created = await _repository.CreateAsync(new CocktailRecord
        {
            Name = "Daiquiri"
        });

        var deleted = await _repository.DeleteAsync(created.Id);
        var afterDelete = await _repository.GetByIdAsync(created.Id);

        Assert.True(deleted);
        Assert.Null(afterDelete);
    }

    private void InitializeDatabase()
    {
        using var connection = new SqliteConnection(_connectionString);
        connection.Execute("""
            CREATE TABLE IF NOT EXISTS Cocktails (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                Name TEXT NOT NULL,
                Description TEXT,
                Method TEXT,
                GlassTypeId INTEGER,
                TimePeriodId INTEGER,
                IsPopular INTEGER DEFAULT 0,
                CocktailSourceId INTEGER
            );
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
