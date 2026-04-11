using CocktailChooser.API.DTOs;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.API.Controllers;

[Route("api/site-message")]
[ApiController]
public class SiteMessageController : ControllerBase
{
    private readonly string _connectionString;

    public SiteMessageController(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection")
            ?? throw new InvalidOperationException("Missing connection string: DefaultConnection");
    }

    [HttpGet("current")]
    public async Task<ActionResult<SiteMessageDto>> GetCurrent()
    {
        const string sql = """
            SELECT
                Id,
                MessageText,
                IsActive,
                StartUtc,
                EndUtc,
                Audience
            FROM SiteMessages
            WHERE IsActive = 1
              AND (StartUtc IS NULL OR StartUtc <= datetime('now'))
              AND (EndUtc IS NULL OR EndUtc >= datetime('now'))
            ORDER BY
                CASE WHEN StartUtc IS NULL THEN 1 ELSE 0 END,
                StartUtc DESC,
                Id DESC
            LIMIT 1;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var message = await connection.QuerySingleOrDefaultAsync<SiteMessageDto>(sql);
        if (message == null)
        {
            return NotFound();
        }

        return Ok(message);
    }
}
