using CocktailChooser.API.Auth;
using CocktailChooser.API.DTOs;
using CocktailChooser.Data.Repositories;

namespace CocktailChooser.API.Services;

public class AuthService : IAuthService
{
    private readonly IUserRepository _userRepository;
    private readonly IPasswordHasher _passwordHasher;
    private readonly ITokenService _tokenService;

    public AuthService(IUserRepository userRepository, IPasswordHasher passwordHasher, ITokenService tokenService)
    {
        _userRepository = userRepository;
        _passwordHasher = passwordHasher;
        _tokenService = tokenService;
    }

    public async Task<AuthResponseDto> RegisterAsync(AuthRegisterRequestDto dto)
    {
        var displayName = dto.DisplayName.Trim();
        var email = dto.Email.Trim();

        if (string.IsNullOrWhiteSpace(displayName))
        {
            throw new ArgumentException("Display name is required.");
        }

        if (string.IsNullOrWhiteSpace(email))
        {
            throw new ArgumentException("Email is required.");
        }

        if (string.IsNullOrWhiteSpace(dto.Password) || dto.Password.Length < 8)
        {
            throw new ArgumentException("Password must be at least 8 characters.");
        }

        var existing = await _userRepository.GetByEmailAsync(email);
        if (existing != null)
        {
            if (HasPassword(existing))
            {
                throw new InvalidOperationException("An account with that email already exists.");
            }

            var claimedPassword = _passwordHasher.HashPassword(dto.Password);
            existing.DisplayName = displayName;
            existing.Email = email;
            existing.PasswordHash = claimedPassword.Hash;
            existing.PasswordSalt = claimedPassword.Salt;
            existing.PasswordIterations = claimedPassword.Iterations;
            existing.UpdatedUtc = DateTime.UtcNow.ToString("O");

            var updated = await _userRepository.UpdateAsync(existing);
            if (!updated)
            {
                throw new InvalidOperationException("Failed to update the existing account.");
            }

            var claimedUser = await _userRepository.GetByIdAsync(existing.Id) ?? existing;
            return new AuthResponseDto
            {
                Token = _tokenService.CreateToken(claimedUser.Id),
                User = MapToDto(claimedUser)
            };
        }

        var password = _passwordHasher.HashPassword(dto.Password);
        var nowUtc = DateTime.UtcNow.ToString("O");
        var created = await _userRepository.CreateAsync(new UserRecord
        {
            DisplayName = displayName,
            Email = email,
            PasswordHash = password.Hash,
            PasswordSalt = password.Salt,
            PasswordIterations = password.Iterations,
            CreatedUtc = nowUtc,
            UpdatedUtc = nowUtc
        });

        return new AuthResponseDto
        {
            Token = _tokenService.CreateToken(created.Id),
            User = MapToDto(created)
        };
    }

    public async Task<AuthResponseDto> LoginAsync(AuthLoginRequestDto dto)
    {
        var email = dto.Email.Trim();
        if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(dto.Password))
        {
            throw new UnauthorizedAccessException("Invalid email or password.");
        }

        var user = await _userRepository.GetByEmailAsync(email);
        if (user == null
            || string.IsNullOrWhiteSpace(user.PasswordHash)
            || string.IsNullOrWhiteSpace(user.PasswordSalt)
            || !user.PasswordIterations.HasValue
            || !_passwordHasher.VerifyPassword(dto.Password, user.PasswordHash, user.PasswordSalt, user.PasswordIterations.Value))
        {
            throw new UnauthorizedAccessException("Invalid email or password.");
        }

        return new AuthResponseDto
        {
            Token = _tokenService.CreateToken(user.Id),
            User = MapToDto(user)
        };
    }

    public async Task<UserDto?> GetUserAsync(int userId)
    {
        var user = await _userRepository.GetByIdAsync(userId);
        return user == null ? null : MapToDto(user);
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

    private static bool HasPassword(UserRecord user)
    {
        return !string.IsNullOrWhiteSpace(user.PasswordHash)
            && !string.IsNullOrWhiteSpace(user.PasswordSalt)
            && user.PasswordIterations.HasValue
            && user.PasswordIterations.Value > 0;
    }
}
