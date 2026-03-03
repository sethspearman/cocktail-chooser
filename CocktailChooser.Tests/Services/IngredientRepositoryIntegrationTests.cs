using System;
using System.IO;
using System.Threading;
using CocktailChooser.Data.Repositories;
using Dapper;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.Tests.Services;

public sealed class IngredientRepositoryIntegrationTests : IDisposable
{
    private readonly string _databasePath;
    private readonly string _connectionString;
    private readonly IngredientRepository _repository;

    public IngredientRepositoryIntegrationTests()
    {
        _databasePath = Path.Combine(Path.GetTempPath(), $"cocktailchooser-ingredients-{Guid.NewGuid():N}.db");
        _connectionString = $"Data Source={_databasePath};Foreign Keys=True";
        _repository = new IngredientRepository(_connectionString);
        InitializeDatabase();
    }

    [Fact]
    public async Task CreateAsync_NormalizesName_AndPersistsNormalizedName()
    {
        var created = await _repository.CreateAsync(new IngredientRecord
        {
            Name = "  Club   Soda  "
        });

        Assert.Equal("Club Soda", created.Name);
        Assert.Equal("club soda", created.NormalizedName);
    }

    [Fact]
    public async Task CreateAsync_ReusesExistingIngredient_ByNormalizedName()
    {
        var first = await _repository.CreateAsync(new IngredientRecord { Name = "Dry Vermouth" });
        var second = await _repository.CreateAsync(new IngredientRecord { Name = "  dry   vermouth " });

        Assert.Equal(first.Id, second.Id);
    }

    private void InitializeDatabase()
    {
        using var connection = new SqliteConnection(_connectionString);
        connection.Execute("""
            CREATE TABLE IF NOT EXISTS Ingredients (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                Name TEXT NOT NULL,
                NormalizedName TEXT,
                IngredientTypeId INTEGER,
                MixerSubtypeId INTEGER,
                PrimarySpirit TEXT,
                LongDescription TEXT
            );
            CREATE INDEX IF NOT EXISTS IX_Ingredients_NormalizedName ON Ingredients (NormalizedName);
            CREATE TRIGGER IF NOT EXISTS trg_Ingredients_PreventDuplicateNormalizedName_Insert
            BEFORE INSERT ON Ingredients
            WHEN COALESCE(NEW.NormalizedName, '') <> ''
             AND EXISTS (
                SELECT 1
                FROM Ingredients i
                WHERE i.NormalizedName = NEW.NormalizedName
                LIMIT 1
            )
            BEGIN
                SELECT RAISE(ABORT, 'Duplicate normalized ingredient name');
            END;
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
