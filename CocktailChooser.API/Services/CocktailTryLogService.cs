using CocktailChooser.API.DTOs;
using CocktailChooser.Data.Repositories;

namespace CocktailChooser.API.Services;

public class CocktailTryLogService : ICocktailTryLogService
{
    private readonly ICocktailTryLogRepository _repository;

    public CocktailTryLogService(ICocktailTryLogRepository repository)
    {
        _repository = repository;
    }

    public async Task<CocktailTryLogDto?> GetCocktailTryLogByIdAsync(int id)
    {
        var record = await _repository.GetByIdAsync(id);
        return record == null ? null : MapToDto(record);
    }

    public async Task<IEnumerable<CocktailTryLogDto>> GetCocktailTryLogsByCocktailIdAsync(int cocktailId, int? userId = null)
    {
        var rows = await _repository.GetByCocktailIdAsync(cocktailId, userId);
        return rows.Select(MapToDto);
    }

    public async Task<IEnumerable<CocktailTryLogDto>> GetCocktailTryLogsByUserIdAsync(int userId)
    {
        var rows = await _repository.GetByUserIdAsync(userId);
        return rows.Select(MapToDto);
    }

    public async Task<CocktailTryLogDto> CreateCocktailTryLogAsync(CocktailTryLogDto logDto)
    {
        var nowUtc = DateTime.UtcNow.ToString("O");
        var record = MapToRecord(logDto);
        record.TriedOnUtc ??= nowUtc;
        record.CreatedUtc = nowUtc;
        record.UpdatedUtc = nowUtc;

        var created = await _repository.CreateAsync(record);
        return MapToDto(created);
    }

    public async Task<bool> UpdateCocktailTryLogAsync(CocktailTryLogDto logDto)
    {
        var record = MapToRecord(logDto);
        record.UpdatedUtc = DateTime.UtcNow.ToString("O");
        record.TriedOnUtc ??= record.UpdatedUtc;
        return await _repository.UpdateAsync(record);
    }

    public async Task<bool> DeleteCocktailTryLogAsync(int id)
    {
        return await _repository.DeleteAsync(id);
    }

    private static CocktailTryLogDto MapToDto(CocktailTryLogRecord record)
    {
        return new CocktailTryLogDto
        {
            Id = record.Id,
            UserId = record.UserId,
            CocktailId = record.CocktailId,
            Rating = record.Rating,
            Comment = record.Comment,
            TriedOnUtc = record.TriedOnUtc,
            CreatedUtc = record.CreatedUtc,
            UpdatedUtc = record.UpdatedUtc
        };
    }

    private static CocktailTryLogRecord MapToRecord(CocktailTryLogDto dto)
    {
        return new CocktailTryLogRecord
        {
            Id = dto.Id,
            UserId = dto.UserId,
            CocktailId = dto.CocktailId,
            Rating = dto.Rating,
            Comment = dto.Comment,
            TriedOnUtc = dto.TriedOnUtc,
            CreatedUtc = dto.CreatedUtc,
            UpdatedUtc = dto.UpdatedUtc
        };
    }
}
