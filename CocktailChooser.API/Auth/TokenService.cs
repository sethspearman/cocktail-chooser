using System.Security.Cryptography;
using System.Text;
using Microsoft.Extensions.Options;

namespace CocktailChooser.API.Auth;

public class TokenService : ITokenService
{
    private readonly byte[] _secret;
    private readonly AuthOptions _options;

    public TokenService(IOptions<AuthOptions> options)
    {
        _options = options.Value;
        _secret = Encoding.UTF8.GetBytes(_options.SecretKey);
    }

    public string CreateToken(int userId)
    {
        var expiresUnix = DateTimeOffset.UtcNow.AddHours(_options.TokenLifetimeHours).ToUnixTimeSeconds();
        const string version = "v1";
        var payload = $"{version}|{userId}|{expiresUnix}";
        var signature = ComputeSignature(payload);
        return $"{version}.{userId}.{expiresUnix}.{signature}";
    }

    public bool TryGetUserId(string token, out int userId)
    {
        userId = 0;

        if (string.IsNullOrWhiteSpace(token))
        {
            return false;
        }

        var parts = token.Split('.', StringSplitOptions.RemoveEmptyEntries);
        if (parts.Length != 4 || !string.Equals(parts[0], "v1", StringComparison.Ordinal))
        {
            return false;
        }

        if (!int.TryParse(parts[1], out var parsedUserId) || parsedUserId <= 0)
        {
            return false;
        }

        if (!long.TryParse(parts[2], out var expiresUnix))
        {
            return false;
        }

        if (DateTimeOffset.UtcNow.ToUnixTimeSeconds() > expiresUnix)
        {
            return false;
        }

        var payload = $"v1|{parsedUserId}|{expiresUnix}";
        var expectedSignature = ComputeSignature(payload);
        if (!CryptographicOperations.FixedTimeEquals(
                Encoding.UTF8.GetBytes(expectedSignature),
                Encoding.UTF8.GetBytes(parts[3])))
        {
            return false;
        }

        userId = parsedUserId;
        return true;
    }

    private string ComputeSignature(string payload)
    {
        using var hmac = new HMACSHA256(_secret);
        var hash = hmac.ComputeHash(Encoding.UTF8.GetBytes(payload));
        return ToBase64Url(hash);
    }

    private static string ToBase64Url(byte[] bytes)
    {
        return Convert.ToBase64String(bytes).TrimEnd('=').Replace('+', '-').Replace('/', '_');
    }
}
