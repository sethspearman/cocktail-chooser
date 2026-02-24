using CocktailChooser.API.DTOs;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.API.Controllers;

[Route("api/[controller]")]
[ApiController]
public class LookupsController : ControllerBase
{
    private readonly string _connectionString;

    public LookupsController(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection")
            ?? throw new InvalidOperationException("Missing connection string: DefaultConnection");
    }

    [HttpGet("amounts")]
    public async Task<ActionResult<IEnumerable<LookupOptionDto>>> GetAmounts()
    {
        const string sql = """
            SELECT Id, MeasurementName AS Name
            FROM Amounts
            ORDER BY MeasurementName;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.QueryAsync<LookupOptionDto>(sql);
        return Ok(rows);
    }

    [HttpGet("glass-types")]
    public async Task<ActionResult<IEnumerable<LookupOptionDto>>> GetGlassTypes()
    {
        const string sql = """
            SELECT Id, Name
            FROM GlassTypes
            ORDER BY Name;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.QueryAsync<LookupOptionDto>(sql);
        return Ok(rows);
    }

    [HttpGet("time-periods")]
    public async Task<ActionResult<IEnumerable<LookupOptionDto>>> GetTimePeriods()
    {
        const string sql = """
            SELECT Id, Name
            FROM CocktailTimePeriods
            ORDER BY Name;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.QueryAsync<LookupOptionDto>(sql);
        return Ok(rows);
    }
}
