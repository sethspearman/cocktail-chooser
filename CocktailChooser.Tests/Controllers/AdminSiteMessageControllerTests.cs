using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using CocktailChooser.API.Auth;
using CocktailChooser.API.Controllers;
using CocktailChooser.API.DTOs;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.Sqlite;
using Microsoft.Extensions.Configuration;
using Moq;
using Xunit;

namespace CocktailChooser.Tests.Controllers;

public class AdminSiteMessageControllerTests
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

    private static async Task<string> CreateDatabaseAsync()
    {
        var databasePath = Path.Combine(Path.GetTempPath(), $"admin-site-message-tests-{System.Guid.NewGuid():N}.db");
        var connectionString = $"Data Source={databasePath};Foreign Keys=True";

        await using var connection = new SqliteConnection(connectionString);
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

        return connectionString;
    }

    [Fact]
    public async Task GetCurrent_ReturnsForbid_WhenUserIsNotAdmin()
    {
        var connectionString = await CreateDatabaseAsync();
        var currentUser = new Mock<ICurrentUserContext>();
        currentUser.SetupProperty(x => x.UserId, 2);
        var controller = new AdminSiteMessageController(CreateConfiguration(connectionString), currentUser.Object);

        var result = await controller.GetCurrent();

        var forbid = Assert.IsType<ObjectResult>(result.Result);
        Assert.Equal(403, forbid.StatusCode);
    }

    [Fact]
    public async Task GetCurrent_ReturnsLatestMessage_WhenAdmin()
    {
        var connectionString = await CreateDatabaseAsync();
        await using (var connection = new SqliteConnection(connectionString))
        {
            await connection.OpenAsync();
            await connection.ExecuteAsync("""
                INSERT INTO SiteMessages (MessageText, IsActive, StartUtc, EndUtc, Audience)
                VALUES ('First', 0, NULL, NULL, NULL),
                       ('Second', 1, NULL, NULL, NULL);
                """);
        }

        var currentUser = new Mock<ICurrentUserContext>();
        currentUser.SetupProperty(x => x.UserId, 1);
        var controller = new AdminSiteMessageController(CreateConfiguration(connectionString), currentUser.Object);

        var result = await controller.GetCurrent();

        var ok = Assert.IsType<OkObjectResult>(result.Result);
        var payload = Assert.IsType<SiteMessageDto>(ok.Value);
        Assert.Equal("Second", payload.MessageText);
        Assert.True(payload.IsActive);
    }

    [Fact]
    public async Task SaveCurrent_UpdatesExistingMessage_WhenAdmin()
    {
        var connectionString = await CreateDatabaseAsync();
        int existingId;
        await using (var connection = new SqliteConnection(connectionString))
        {
            await connection.OpenAsync();
            existingId = (int)await connection.ExecuteScalarAsync<long>("""
                INSERT INTO SiteMessages (MessageText, IsActive, StartUtc, EndUtc, Audience)
                VALUES ('Old message', 1, NULL, NULL, NULL);
                SELECT last_insert_rowid();
                """);
        }

        var currentUser = new Mock<ICurrentUserContext>();
        currentUser.SetupProperty(x => x.UserId, 1);
        var controller = new AdminSiteMessageController(CreateConfiguration(connectionString), currentUser.Object);

        var result = await controller.SaveCurrent(new AdminSiteMessageUpsertDto
        {
            Id = existingId,
            MessageText = "Updated message",
            IsActive = false
        });

        var ok = Assert.IsType<OkObjectResult>(result.Result);
        var payload = Assert.IsType<SiteMessageDto>(ok.Value);
        Assert.Equal(existingId, payload.Id);
        Assert.Equal("Updated message", payload.MessageText);
        Assert.False(payload.IsActive);
    }
}
