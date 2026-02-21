using CocktailChooser.API.DTOs;
using CocktailChooser.Data.Repositories;

namespace CocktailChooser.API.Services;

public class UserService : IUserService
{
    private readonly IUserRepository _repository;

    public UserService(IUserRepository repository)
    {
        _repository = repository;
    }

    public async Task<IEnumerable<UserDto>> GetAllUsersAsync()
    {
        var users = await _repository.GetAllAsync();
        return users.Select(MapToDto);
    }

    public async Task<UserDto?> GetUserByIdAsync(int id)
    {
        var user = await _repository.GetByIdAsync(id);
        return user == null ? null : MapToDto(user);
    }

    public async Task<UserDto> CreateUserAsync(UserDto userDto)
    {
        var nowUtc = DateTime.UtcNow.ToString("O");
        var record = MapToRecord(userDto);
        record.CreatedUtc = nowUtc;
        record.UpdatedUtc = nowUtc;

        var created = await _repository.CreateAsync(record);
        return MapToDto(created);
    }

    public async Task<bool> UpdateUserAsync(UserDto userDto)
    {
        var record = MapToRecord(userDto);
        record.UpdatedUtc = DateTime.UtcNow.ToString("O");
        return await _repository.UpdateAsync(record);
    }

    public async Task<bool> DeleteUserAsync(int id)
    {
        return await _repository.DeleteAsync(id);
    }

    private static UserDto MapToDto(UserRecord record)
    {
        return new UserDto
        {
            Id = record.Id,
            DisplayName = record.DisplayName,
            Email = record.Email,
            CreatedUtc = record.CreatedUtc,
            UpdatedUtc = record.UpdatedUtc
        };
    }

    private static UserRecord MapToRecord(UserDto dto)
    {
        return new UserRecord
        {
            Id = dto.Id,
            DisplayName = dto.DisplayName,
            Email = dto.Email,
            CreatedUtc = dto.CreatedUtc,
            UpdatedUtc = dto.UpdatedUtc
        };
    }
}
