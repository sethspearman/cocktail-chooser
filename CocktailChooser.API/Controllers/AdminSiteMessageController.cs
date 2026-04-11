using CocktailChooser.API.Auth;
using CocktailChooser.API.DTOs;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.API.Controllers;

[Route("api/admin/site-message")]
[ApiController]
public class AdminSiteMessageController : ControllerBase
{
    private readonly string _connectionString;
    private readonly ICurrentUserContext _currentUserContext;

    public AdminSiteMessageController(IConfiguration configuration, ICurrentUserContext currentUserContext)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection")
            ?? throw new InvalidOperationException("Missing connection string: DefaultConnection");
        _currentUserContext = currentUserContext;
    }

    [HttpGet("current")]
    public async Task<ActionResult<SiteMessageDto>> GetCurrent()
    {
        if (!IsAdminUser())
        {
            return StatusCode(StatusCodes.Status403Forbidden);
        }

        const string sql = """
            SELECT
                Id,
                MessageText,
                IsActive,
                StartUtc,
                EndUtc,
                Audience
            FROM SiteMessages
            ORDER BY Id DESC
            LIMIT 1;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var message = await connection.QuerySingleOrDefaultAsync<SiteMessageDto>(sql);
        if (message != null)
        {
            return Ok(message);
        }

        return Ok(new SiteMessageDto
        {
            Id = 0,
            MessageText = string.Empty,
            IsActive = false
        });
    }

    [HttpPut("current")]
    public async Task<ActionResult<SiteMessageDto>> SaveCurrent([FromBody] AdminSiteMessageUpsertDto request)
    {
        if (!IsAdminUser())
        {
            return StatusCode(StatusCodes.Status403Forbidden);
        }

        var messageText = (request.MessageText ?? string.Empty).Trim();
        if (messageText.Length == 0)
        {
            return BadRequest("Message text is required.");
        }

        await using var connection = new SqliteConnection(_connectionString);
        await connection.OpenAsync();

        if ((request.Id ?? 0) > 0)
        {
            const string updateSql = """
                UPDATE SiteMessages
                SET
                    MessageText = @MessageText,
                    IsActive = @IsActive,
                    StartUtc = @StartUtc,
                    EndUtc = @EndUtc,
                    Audience = @Audience
                WHERE Id = @Id;
                """;

            await connection.ExecuteAsync(updateSql, new
            {
                Id = request.Id!.Value,
                MessageText = messageText,
                IsActive = request.IsActive ? 1 : 0,
                request.StartUtc,
                request.EndUtc,
                request.Audience
            });
        }
        else
        {
            const string insertSql = """
                INSERT INTO SiteMessages (MessageText, IsActive, StartUtc, EndUtc, Audience)
                VALUES (@MessageText, @IsActive, @StartUtc, @EndUtc, @Audience);
                SELECT last_insert_rowid();
                """;

            var newId = await connection.ExecuteScalarAsync<long>(insertSql, new
            {
                MessageText = messageText,
                IsActive = request.IsActive ? 1 : 0,
                request.StartUtc,
                request.EndUtc,
                request.Audience
            });

            request.Id = (int)newId;
        }

        const string selectSql = """
            SELECT
                Id,
                MessageText,
                IsActive,
                StartUtc,
                EndUtc,
                Audience
            FROM SiteMessages
            WHERE Id = @Id;
            """;

        var saved = await connection.QuerySingleAsync<SiteMessageDto>(selectSql, new { Id = request.Id!.Value });
        return Ok(saved);
    }

    private bool IsAdminUser()
    {
        return _currentUserContext.UserId.HasValue && _currentUserContext.UserId.Value == 1;
    }
}
