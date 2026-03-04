using System;
using System.Collections.Generic;
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
            CanonicalKey = "manual::old_fashioned",
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
            CanonicalKey = "manual::missing",
            Name = "Missing"
        });

        Assert.False(updated);
    }

    [Fact]
    public async Task DeleteAsync_RemovesCocktail()
    {
        var created = await _repository.CreateAsync(new CocktailRecord
        {
            CanonicalKey = "manual::daiquiri",
            Name = "Daiquiri"
        });

        var deleted = await _repository.DeleteAsync(created.Id);
        var afterDelete = await _repository.GetByIdAsync(created.Id);

        Assert.True(deleted);
        Assert.Null(afterDelete);
    }

    [Fact]
    public async Task UpsertAdminImportAsync_UpdatesByCanonicalKey_AndReplacesChildren()
    {
        var created = await _repository.UpsertAdminImportAsync(new AdminCocktailImportRecord
        {
            CanonicalKey = "book::negroni",
            Name = "Negroni",
            Ingredients = new List<AdminCocktailImportIngredientRecord>
            {
                new() { IngredientName = "Gin", AmountText = "1 oz" },
                new() { IngredientName = "Campari", AmountText = "1 oz" }
            },
            Steps = new List<AdminCocktailImportStepRecord>
            {
                new() { Instruction = "Stir with ice." },
                new() { Instruction = "Strain over fresh ice." }
            }
        });

        var updated = await _repository.UpsertAdminImportAsync(new AdminCocktailImportRecord
        {
            CanonicalKey = "book::negroni",
            Name = "Negroni (Revised)",
            Ingredients = new List<AdminCocktailImportIngredientRecord>
            {
                new() { IngredientName = "Gin", AmountText = "1.5 oz" }
            },
            Steps = new List<AdminCocktailImportStepRecord>
            {
                new() { Instruction = "Build in mixing glass and stir." }
            }
        });

        Assert.Equal(created.Id, updated.Id);
        Assert.Equal("Negroni (Revised)", updated.Name);

        using var connection = new SqliteConnection(_connectionString);
        var ingredientCount = connection.ExecuteScalar<int>("SELECT COUNT(*) FROM CocktailIngredients WHERE CocktailId = @Id;", new { Id = updated.Id });
        var stepCount = connection.ExecuteScalar<int>("SELECT COUNT(*) FROM CocktailSteps WHERE CocktailId = @Id;", new { Id = updated.Id });

        Assert.Equal(1, ingredientCount);
        Assert.Equal(1, stepCount);
    }

    [Fact]
    public async Task UpsertAdminImportAsync_RollsBack_AllChanges_WhenChildInsertFails()
    {
        using (var connection = new SqliteConnection(_connectionString))
        {
            connection.Execute("""
                CREATE TRIGGER IF NOT EXISTS trg_fail_on_bad_ingredient
                BEFORE INSERT ON CocktailIngredients
                WHEN NEW.IngredientId = 9999
                BEGIN
                    SELECT RAISE(ABORT, 'forced ingredient failure');
                END;
                """);
        }

        using (var connection = new SqliteConnection(_connectionString))
        {
            connection.Execute("INSERT INTO Ingredients (Id, Name, NormalizedName) VALUES (9999, 'Bad Ingredient', 'bad ingredient');");
        }

        await Assert.ThrowsAnyAsync<Exception>(async () =>
            await _repository.UpsertAdminImportAsync(new AdminCocktailImportRecord
            {
                CanonicalKey = "manual::rollback_test",
                Name = "Rollback Test",
                Ingredients = new List<AdminCocktailImportIngredientRecord>
                {
                    new() { IngredientName = "Bad Ingredient" }
                }
            }));

        using (var connection = new SqliteConnection(_connectionString))
        {
            var cocktailExists = connection.ExecuteScalar<int>("SELECT COUNT(*) FROM Cocktails WHERE CanonicalKey = 'manual::rollback_test';");
            Assert.Equal(0, cocktailExists);
        }
    }

    [Fact]
    public async Task UpsertAdminImportAsync_ReusesIngredient_ByNormalizedName()
    {
        await _repository.UpsertAdminImportAsync(new AdminCocktailImportRecord
        {
            CanonicalKey = "manual::normalize_a",
            Name = "Normalize A",
            Ingredients = new List<AdminCocktailImportIngredientRecord>
            {
                new() { IngredientName = "Club Soda" }
            }
        });

        await _repository.UpsertAdminImportAsync(new AdminCocktailImportRecord
        {
            CanonicalKey = "manual::normalize_b",
            Name = "Normalize B",
            Ingredients = new List<AdminCocktailImportIngredientRecord>
            {
                new() { IngredientName = "  club   soda  " }
            }
        });

        using var connection = new SqliteConnection(_connectionString);
        var ingredientCount = connection.ExecuteScalar<int>(
            "SELECT COUNT(*) FROM Ingredients WHERE NormalizedName = 'club soda';");

        Assert.Equal(1, ingredientCount);
    }

    private void InitializeDatabase()
    {
        using var connection = new SqliteConnection(_connectionString);
        connection.Execute("""
            CREATE TABLE IF NOT EXISTS Cocktails (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                CanonicalKey TEXT NOT NULL UNIQUE,
                RecipeFingerprint TEXT,
                Name TEXT NOT NULL,
                Description TEXT,
                Method TEXT,
                GlassTypeId INTEGER,
                TimePeriodId INTEGER,
                IsPopular INTEGER DEFAULT 0,
                IsApproved INTEGER NOT NULL DEFAULT 0,
                ApprovedUtc TEXT,
                ApprovedByUserId INTEGER,
                RejectedUtc TEXT,
                IsUserSubmitted INTEGER NOT NULL DEFAULT 0,
                SubmittedByUserId INTEGER,
                CocktailSourceId INTEGER
            );
            CREATE TABLE IF NOT EXISTS CocktailSource (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                Name TEXT NOT NULL
            );
            CREATE TABLE IF NOT EXISTS Ingredients (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                Name TEXT NOT NULL,
                NormalizedName TEXT
            );
            CREATE TABLE IF NOT EXISTS Amounts (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                MeasurementName TEXT NOT NULL
            );
            CREATE TABLE IF NOT EXISTS CocktailIngredients (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                CocktailId INTEGER NOT NULL,
                IngredientId INTEGER NOT NULL,
                AmountId INTEGER,
                AmountText TEXT,
                SortOrder INTEGER
            );
            CREATE TABLE IF NOT EXISTS CocktailSteps (
                CocktailId INTEGER NOT NULL,
                StepNumber INTEGER NOT NULL,
                Instruction TEXT,
                PRIMARY KEY (CocktailId, StepNumber)
            );
            CREATE TABLE IF NOT EXISTS CocktailTimePeriods (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                Name TEXT NOT NULL
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
