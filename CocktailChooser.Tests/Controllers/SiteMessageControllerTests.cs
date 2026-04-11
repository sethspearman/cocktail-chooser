using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using CocktailChooser.API.Controllers;
using CocktailChooser.API.DTOs;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.Sqlite;
using Microsoft.Extensions.Configuration;
using Xunit;

namespace CocktailChooser.Tests.Controllers;

public class SiteMessageControllerTests
{
    private static IConfiguration CreateConfiguration(string connectionString)
    {
        return new ConfigurationBuilder()
            .AddInMemoryCollection(new Dictionary<string, string?>
            {
                ["ConnectionStrings:DefaultConnection"] = connectionString
            })
            .Build();
    }

    [Fact]
    public async Task GetCurrent_ReturnsNotFound_WhenNoActiveMessageExists()
    {
        var databasePath = Path.Combine(Path.GetTempPath(), $"site-message-tests-{System.Guid.NewGuid():N}.db");
        var connectionString = $"Data Source={databasePath};Foreign Keys=True";

        await using (var connection = new SqliteConnection(connectionString))
        {
            await connection.OpenAsync();
            await connection.ExecuteAsync("""
                CREATE TABLE SiteMessages (
                    Id INTEGER PRIMARY KEY AUTOINCREMENT,
                    MessageText TEXT NOT NULL,
                    IsActive INTEGER NOT NULL DEFAULT 0,
                    StartUtc TEXT NULL,
                    EndUtc TEXT NULL,
                    Audience TEXT NULL
                );
                """);
        }

        var controller = new SiteMessageController(CreateConfiguration(connectionString));

        var result = await controller.GetCurrent();

        Assert.IsType<NotFoundResult>(result.Result);
    }

    [Fact]
    public async Task GetCurrent_ReturnsActiveMessage_WhenOneIsAvailable()
    {
        var databasePath = Path.Combine(Path.GetTempPath(), $"site-message-tests-{System.Guid.NewGuid():N}.db");
        var connectionString = $"Data Source={databasePath};Foreign Keys=True";

        await using (var connection = new SqliteConnection(connectionString))
        {
            await connection.OpenAsync();
            await connection.ExecuteAsync("""
                CREATE TABLE SiteMessages (
                    Id INTEGER PRIMARY KEY AUTOINCREMENT,
                    MessageText TEXT NOT NULL,
                    IsActive INTEGER NOT NULL DEFAULT 0,
                    StartUtc TEXT NULL,
                    EndUtc TEXT NULL,
                    Audience TEXT NULL
                );
                """);

            await connection.ExecuteAsync("""
                INSERT INTO SiteMessages (MessageText, IsActive, StartUtc, EndUtc, Audience)
                VALUES
                    ('Expired message', 1, '2020-01-01 00:00:00', '2020-01-02 00:00:00', NULL),
                    ('Current message', 1, NULL, NULL, NULL);
                """);
        }

        var controller = new SiteMessageController(CreateConfiguration(connectionString));

        var result = await controller.GetCurrent();

        var ok = Assert.IsType<OkObjectResult>(result.Result);
        var payload = Assert.IsType<SiteMessageDto>(ok.Value);
        Assert.Equal("Current message", payload.MessageText);
        Assert.True(payload.IsActive);
    }
}
