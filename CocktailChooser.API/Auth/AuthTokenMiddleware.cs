namespace CocktailChooser.API.Auth;

public class AuthTokenMiddleware
{
    private readonly RequestDelegate _next;

    public AuthTokenMiddleware(RequestDelegate next)
    {
        _next = next;
    }

    public async Task InvokeAsync(HttpContext context, ITokenService tokenService, ICurrentUserContext currentUserContext)
    {
        var authHeader = context.Request.Headers["Authorization"].ToString();
        if (authHeader.StartsWith("Bearer ", StringComparison.OrdinalIgnoreCase))
        {
            var token = authHeader["Bearer ".Length..].Trim();
            if (tokenService.TryGetUserId(token, out var userId))
            {
                currentUserContext.UserId = userId;
            }
        }

        await _next(context);
    }
}
