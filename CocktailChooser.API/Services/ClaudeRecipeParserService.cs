using System.Text;
using System.Text.Json;
using System.Text.Json.Nodes;
using Microsoft.Extensions.Configuration;

namespace CocktailChooser.API.Services;

public interface IClaudeRecipeParserService
{
    bool IsConfigured { get; }
    Task<ClaudeParseResult?> ParseAsync(string rawText);
}

public sealed class ClaudeParseResult
{
    public string? Name { get; set; }
    public string? Description { get; set; }
    public string? FlavorProfile { get; set; }
    public string? TimePeriod { get; set; }
    public List<ClaudeIngredient> Ingredients { get; set; } = new();
    public List<string> Steps { get; set; } = new();
}

public sealed class ClaudeIngredient
{
    public string Amount { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
}

public sealed class ClaudeRecipeParserService : IClaudeRecipeParserService
{
    private readonly IHttpClientFactory _httpClientFactory;
    private readonly ILogger<ClaudeRecipeParserService> _logger;
    private readonly string? _apiKey;

    private const string ApiUrl = "https://api.anthropic.com/v1/messages";
    private const string Model = "claude-sonnet-4-6";

    private const string SystemPrompt =
        "You are a cocktail recipe parser. Extract structured information from the recipe text provided by the user.\n\n" +
        "Return ONLY a valid JSON object with these fields:\n" +
        "{\n" +
        "  \"name\": \"cocktail name\",\n" +
        "  \"description\": \"brief description (1-2 sentences) or null\",\n" +
        "  \"flavorProfile\": \"flavor notes (e.g. citrus, bitter, sweet) or null\",\n" +
        "  \"timePeriod\": \"era or category (e.g. Pre-Prohibition, Classic, Modern, Tiki) or null\",\n" +
        "  \"ingredients\": [\n" +
        "    {\"amount\": \"2 oz\", \"name\": \"Gin\"},\n" +
        "    {\"amount\": \"3/4 oz\", \"name\": \"Lemon Juice\"}\n" +
        "  ],\n" +
        "  \"steps\": [\n" +
        "    \"Step 1 instruction.\",\n" +
        "    \"Step 2 instruction.\"\n" +
        "  ]\n" +
        "}\n\n" +
        "Rules:\n" +
        "- Preserve ingredient amounts exactly as written (½, ¾, ⅓, etc.)\n" +
        "- Split method/instructions into individual sentences as separate steps\n" +
        "- Each ingredient must have both an amount and a name; if no amount is stated use empty string\n" +
        "- Ingredient names should be title-cased (e.g. Angostura Bitters, Simple Syrup)\n" +
        "- Do not include serving size, yield, or prep time as steps\n" +
        "- Return only the raw JSON object, no other text\n" +
        "- Do NOT wrap the JSON in markdown code fences (no ```json or ``` markers)";

    public ClaudeRecipeParserService(
        IHttpClientFactory httpClientFactory,
        IConfiguration configuration,
        ILogger<ClaudeRecipeParserService> logger)
    {
        _httpClientFactory = httpClientFactory;
        _logger = logger;
        _apiKey = configuration["Anthropic:ApiKey"];
    }

    public bool IsConfigured => !string.IsNullOrWhiteSpace(_apiKey);

    public async Task<ClaudeParseResult?> ParseAsync(string rawText)
    {
        if (!IsConfigured)
        {
            _logger.LogWarning(
                "Claude recipe parser is not configured: 'Anthropic:ApiKey' is missing or blank. Falling back to basic parser.");
            return null;
        }

        var client = _httpClientFactory.CreateClient("claude");
        client.DefaultRequestHeaders.TryAddWithoutValidation("x-api-key", _apiKey);
        client.DefaultRequestHeaders.TryAddWithoutValidation("anthropic-version", "2023-06-01");

        var requestBody = new
        {
            model = Model,
            max_tokens = 1024,
            system = SystemPrompt,
            messages = new[]
            {
                new { role = "user", content = rawText }
            }
        };

        var json = JsonSerializer.Serialize(requestBody);
        using var content = new StringContent(json, Encoding.UTF8, "application/json");

        HttpResponseMessage response;
        try
        {
            response = await client.PostAsync(ApiUrl, content);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Claude API request failed before a response was received. Falling back to basic parser.");
            return null;
        }

        var responseJson = await response.Content.ReadAsStringAsync();

        if (!response.IsSuccessStatusCode)
        {
            _logger.LogError(
                "Claude API returned {StatusCode} ({StatusCodeName}). Response body: {Body}. Falling back to basic parser.",
                (int)response.StatusCode,
                response.StatusCode,
                responseJson);
            return null;
        }

        var doc = JsonNode.Parse(responseJson);
        var text = doc?["content"]?[0]?["text"]?.GetValue<string>();
        if (string.IsNullOrWhiteSpace(text))
        {
            _logger.LogError(
                "Claude API response did not contain parseable content text. Response body: {Body}. Falling back to basic parser.",
                responseJson);
            return null;
        }

        var jsonText = ExtractJsonObject(text);

        try
        {
            return JsonSerializer.Deserialize<ClaudeParseResult>(jsonText, new JsonSerializerOptions
            {
                PropertyNameCaseInsensitive = true
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to deserialize Claude response into a recipe. Model returned: {Text}. Falling back to basic parser.", text);
            return null;
        }
    }

    // The model sometimes wraps the JSON in a markdown code fence (```json ... ```)
    // or adds stray prose despite the system prompt. Pull out the JSON object itself.
    private static string ExtractJsonObject(string text)
    {
        var start = text.IndexOf('{');
        var end = text.LastIndexOf('}');
        if (start >= 0 && end > start)
        {
            return text.Substring(start, end - start + 1);
        }

        return text.Trim();
    }
}
