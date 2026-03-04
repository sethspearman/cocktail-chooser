using Dapper;
using Microsoft.Data.Sqlite;
using System.Data.Common;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;

namespace CocktailChooser.Data.Repositories;

public class CocktailRepository : ICocktailRepository
{
    private static readonly Regex CanonicalTokenRegex = new(@"[^a-z0-9]+", RegexOptions.Compiled);

    private const string SelectColumns = """
        Id,
        CanonicalKey,
        RecipeFingerprint,
        Name,
        Description,
        Method,
        GlassTypeId,
        TimePeriodId,
        IsPopular,
        IsApproved,
        ApprovedUtc,
        ApprovedByUserId,
        RejectedUtc,
        IsUserSubmitted,
        SubmittedByUserId,
        CocktailSourceId
        """;

    private readonly string _connectionString;

    public CocktailRepository(string connectionString)
    {
        _connectionString = connectionString;
    }

    public async Task<IEnumerable<CocktailRecord>> GetAllAsync()
    {
        const string sql = $"SELECT {SelectColumns} FROM Cocktails ORDER BY Name;";
        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<CocktailRecord>(sql);
    }

    public async Task<CocktailRecord?> GetByIdAsync(int id)
    {
        const string sql = $"SELECT {SelectColumns} FROM Cocktails WHERE Id = @Id;";
        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QuerySingleOrDefaultAsync<CocktailRecord>(sql, new { Id = id });
    }

    public async Task<CocktailRecord?> GetByCanonicalKeyAsync(string canonicalKey)
    {
        const string sql = $"SELECT {SelectColumns} FROM Cocktails WHERE CanonicalKey = @CanonicalKey;";
        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QuerySingleOrDefaultAsync<CocktailRecord>(sql, new { CanonicalKey = canonicalKey });
    }

    public async Task<bool> IsCanonicalKeyInUseAsync(string canonicalKey, int? excludeCocktailId = null)
    {
        const string sql = """
            SELECT EXISTS (
                SELECT 1
                FROM Cocktails
                WHERE CanonicalKey = @CanonicalKey
                  AND (@ExcludeCocktailId IS NULL OR Id <> @ExcludeCocktailId)
            );
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var inUse = await connection.ExecuteScalarAsync<long>(sql, new { CanonicalKey = canonicalKey, ExcludeCocktailId = excludeCocktailId });
        return inUse == 1;
    }

    public async Task<IEnumerable<LookupOptionRecord>> GetTimePeriodsAsync()
    {
        const string sql = """
            SELECT Id, Name
            FROM CocktailTimePeriods
            ORDER BY Name;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<LookupOptionRecord>(sql);
    }

    public async Task<CocktailRecord> CreateAsync(CocktailRecord cocktail)
    {
        const string sql = """
            INSERT INTO Cocktails
            (
                CanonicalKey,
                RecipeFingerprint,
                Name,
                Description,
                Method,
                GlassTypeId,
                TimePeriodId,
                IsPopular,
                IsApproved,
                ApprovedUtc,
                ApprovedByUserId,
                RejectedUtc,
                IsUserSubmitted,
                SubmittedByUserId,
                CocktailSourceId
            )
            VALUES
            (
                @CanonicalKey,
                @RecipeFingerprint,
                @Name,
                @Description,
                @Method,
                @GlassTypeId,
                @TimePeriodId,
                @IsPopular,
                COALESCE(@IsApproved, 0),
                @ApprovedUtc,
                @ApprovedByUserId,
                @RejectedUtc,
                COALESCE(@IsUserSubmitted, 0),
                @SubmittedByUserId,
                @CocktailSourceId
            );
            SELECT last_insert_rowid();
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var newId = await connection.ExecuteScalarAsync<long>(sql, cocktail);
        return (await GetByIdAsync((int)newId))!;
    }

    public async Task<bool> UpdateAsync(CocktailRecord cocktail)
    {
        const string sql = """
            UPDATE Cocktails
            SET
                CanonicalKey = @CanonicalKey,
                RecipeFingerprint = @RecipeFingerprint,
                Name = @Name,
                Description = @Description,
                Method = @Method,
                GlassTypeId = @GlassTypeId,
                TimePeriodId = @TimePeriodId,
                IsPopular = @IsPopular,
                IsApproved = COALESCE(@IsApproved, IsApproved),
                ApprovedUtc = @ApprovedUtc,
                ApprovedByUserId = @ApprovedByUserId,
                RejectedUtc = @RejectedUtc,
                IsUserSubmitted = COALESCE(@IsUserSubmitted, IsUserSubmitted),
                SubmittedByUserId = COALESCE(@SubmittedByUserId, SubmittedByUserId),
                CocktailSourceId = @CocktailSourceId
            WHERE Id = @Id;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.ExecuteAsync(sql, cocktail);
        return rows > 0;
    }

    public async Task<CocktailRecord> UpsertAdminImportAsync(AdminCocktailImportRecord importRecord)
    {
        if (string.IsNullOrWhiteSpace(importRecord.Name))
        {
            throw new ArgumentException("Name is required.", nameof(importRecord));
        }

        await using var connection = new SqliteConnection(_connectionString);
        await connection.OpenAsync();
        await using var tx = await connection.BeginTransactionAsync();

        var existingId = await ResolveExistingCocktailIdAsync(connection, tx, importRecord.CanonicalKey);
        var canonicalKey = await ResolveUniqueCanonicalKeyAsync(connection, tx, importRecord, existingId);
        var recipeFingerprint = BuildRecipeFingerprint(importRecord);

        int cocktailId;
        if (existingId.HasValue)
        {
            cocktailId = existingId.Value;
            await connection.ExecuteAsync(
                """
                UPDATE Cocktails
                SET
                    RecipeFingerprint = @RecipeFingerprint,
                    Name = @Name,
                    Description = @Description,
                    Method = @Method,
                    GlassTypeId = @GlassTypeId,
                    TimePeriodId = @TimePeriodId,
                    IsPopular = @IsPopular,
                    IsApproved = COALESCE(@IsApproved, IsApproved),
                    ApprovedUtc = @ApprovedUtc,
                    ApprovedByUserId = @ApprovedByUserId,
                    RejectedUtc = @RejectedUtc,
                    IsUserSubmitted = COALESCE(@IsUserSubmitted, IsUserSubmitted),
                    SubmittedByUserId = @SubmittedByUserId,
                    CocktailSourceId = @CocktailSourceId
                WHERE Id = @Id;
                """,
                new
                {
                    Id = cocktailId,
                    RecipeFingerprint = recipeFingerprint,
                    Name = importRecord.Name.Trim(),
                    importRecord.Description,
                    importRecord.Method,
                    importRecord.GlassTypeId,
                    importRecord.TimePeriodId,
                    importRecord.IsPopular,
                    importRecord.IsApproved,
                    importRecord.ApprovedUtc,
                    importRecord.ApprovedByUserId,
                    importRecord.RejectedUtc,
                    importRecord.IsUserSubmitted,
                    importRecord.SubmittedByUserId,
                    importRecord.CocktailSourceId
                },
                tx);
        }
        else
        {
            cocktailId = (int)(await connection.ExecuteScalarAsync<long>(
                """
                INSERT INTO Cocktails
                (
                    CanonicalKey,
                    RecipeFingerprint,
                    Name,
                    Description,
                    Method,
                    GlassTypeId,
                    TimePeriodId,
                    IsPopular,
                    IsApproved,
                    ApprovedUtc,
                    ApprovedByUserId,
                    RejectedUtc,
                    IsUserSubmitted,
                    SubmittedByUserId,
                    CocktailSourceId
                )
                VALUES
                (
                    @CanonicalKey,
                    @RecipeFingerprint,
                    @Name,
                    @Description,
                    @Method,
                    @GlassTypeId,
                    @TimePeriodId,
                    @IsPopular,
                    COALESCE(@IsApproved, 1),
                    @ApprovedUtc,
                    @ApprovedByUserId,
                    @RejectedUtc,
                    COALESCE(@IsUserSubmitted, 0),
                    @SubmittedByUserId,
                    @CocktailSourceId
                );
                SELECT last_insert_rowid();
                """,
                new
                {
                    CanonicalKey = canonicalKey,
                    RecipeFingerprint = recipeFingerprint,
                    Name = importRecord.Name.Trim(),
                    importRecord.Description,
                    importRecord.Method,
                    importRecord.GlassTypeId,
                    importRecord.TimePeriodId,
                    importRecord.IsPopular,
                    importRecord.IsApproved,
                    importRecord.ApprovedUtc,
                    importRecord.ApprovedByUserId,
                    importRecord.RejectedUtc,
                    importRecord.IsUserSubmitted,
                    importRecord.SubmittedByUserId,
                    importRecord.CocktailSourceId
                },
                tx))!;
        }

        await connection.ExecuteAsync("DELETE FROM CocktailIngredients WHERE CocktailId = @CocktailId;", new { CocktailId = cocktailId }, tx);
        await connection.ExecuteAsync("DELETE FROM CocktailSteps WHERE CocktailId = @CocktailId;", new { CocktailId = cocktailId }, tx);

        var normalizedIngredients = (importRecord.Ingredients ?? new List<AdminCocktailImportIngredientRecord>())
            .Where(x => !string.IsNullOrWhiteSpace(x.IngredientName))
            .Select(x => new AdminCocktailImportIngredientRecord
            {
                IngredientName = x.IngredientName.Trim(),
                AmountId = x.AmountId,
                AmountText = string.IsNullOrWhiteSpace(x.AmountText) ? null : x.AmountText.Trim()
            })
            .ToList();

        for (var i = 0; i < normalizedIngredients.Count; i++)
        {
            var row = normalizedIngredients[i];
            var ingredientId = await ResolveOrCreateIngredientIdAsync(connection, tx, row.IngredientName);
            var amountId = await ResolveAmountIdAsync(connection, tx, row.AmountId, row.AmountText);
            var amountText = amountId.HasValue ? null : row.AmountText;

            await connection.ExecuteAsync(
                """
                INSERT INTO CocktailIngredients
                (
                    CocktailId,
                    IngredientId,
                    AmountId,
                    AmountText,
                    SortOrder
                )
                VALUES
                (
                    @CocktailId,
                    @IngredientId,
                    @AmountId,
                    @AmountText,
                    @SortOrder
                );
                """,
                new
                {
                    CocktailId = cocktailId,
                    IngredientId = ingredientId,
                    AmountId = amountId,
                    AmountText = amountText,
                    SortOrder = i + 1
                },
                tx);
        }

        var normalizedSteps = (importRecord.Steps ?? new List<AdminCocktailImportStepRecord>())
            .Where(x => !string.IsNullOrWhiteSpace(x.Instruction))
            .Select(x => x.Instruction.Trim())
            .ToList();

        for (var i = 0; i < normalizedSteps.Count; i++)
        {
            await connection.ExecuteAsync(
                """
                INSERT INTO CocktailSteps
                (
                    CocktailId,
                    StepNumber,
                    Instruction
                )
                VALUES
                (
                    @CocktailId,
                    @StepNumber,
                    @Instruction
                );
                """,
                new
                {
                    CocktailId = cocktailId,
                    StepNumber = i + 1,
                    Instruction = normalizedSteps[i]
                },
                tx);
        }

        await tx.CommitAsync();
        return (await GetByIdAsync(cocktailId))!;
    }

    public async Task<bool> DeleteAsync(int id)
    {
        const string sql = "DELETE FROM Cocktails WHERE Id = @Id;";
        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.ExecuteAsync(sql, new { Id = id });
        return rows > 0;
    }

    private static async Task<int?> ResolveExistingCocktailIdAsync(
        SqliteConnection connection,
        DbTransaction tx,
        string? canonicalKey)
    {
        if (string.IsNullOrWhiteSpace(canonicalKey))
        {
            return null;
        }

        var normalized = NormalizeCanonicalKey(canonicalKey);
        var idByCanonical = await connection.ExecuteScalarAsync<long?>(
            "SELECT Id FROM Cocktails WHERE CanonicalKey = @CanonicalKey;",
            new { CanonicalKey = normalized },
            tx);
        return idByCanonical.HasValue ? (int)idByCanonical.Value : null;
    }

    private static async Task<string> ResolveUniqueCanonicalKeyAsync(
        SqliteConnection connection,
        DbTransaction tx,
        AdminCocktailImportRecord importRecord,
        int? existingCocktailId)
    {
        var baseKey = string.IsNullOrWhiteSpace(importRecord.CanonicalKey)
            ? await BuildCanonicalKeyFromRecordAsync(connection, tx, importRecord)
            : NormalizeCanonicalKey(importRecord.CanonicalKey);
        if (!await IsCanonicalKeyInUseAsync(connection, tx, baseKey, existingCocktailId))
        {
            return baseKey;
        }

        var suffix = 2;
        while (true)
        {
            var candidate = $"{baseKey}__v{suffix}";
            if (!await IsCanonicalKeyInUseAsync(connection, tx, candidate, existingCocktailId))
            {
                return candidate;
            }

            suffix++;
        }
    }

    private static async Task<bool> IsCanonicalKeyInUseAsync(
        SqliteConnection connection,
        DbTransaction tx,
        string canonicalKey,
        int? excludeCocktailId)
    {
        var found = await connection.ExecuteScalarAsync<long?>(
            """
            SELECT Id
            FROM Cocktails
            WHERE CanonicalKey = @CanonicalKey
              AND (@ExcludeCocktailId IS NULL OR Id <> @ExcludeCocktailId)
            LIMIT 1;
            """,
            new { CanonicalKey = canonicalKey, ExcludeCocktailId = excludeCocktailId },
            tx);
        return found.HasValue;
    }

    private static async Task<string> BuildCanonicalKeyFromRecordAsync(
        SqliteConnection connection,
        DbTransaction tx,
        AdminCocktailImportRecord importRecord)
    {
        var sourceName = "manual";
        if (importRecord.CocktailSourceId.HasValue)
        {
            var dbSourceName = await connection.ExecuteScalarAsync<string?>(
                "SELECT Name FROM CocktailSource WHERE Id = @Id;",
                new { Id = importRecord.CocktailSourceId.Value },
                tx);
            if (!string.IsNullOrWhiteSpace(dbSourceName))
            {
                sourceName = dbSourceName.Trim();
            }
        }

        return $"{NormalizeCanonicalToken(sourceName)}::{NormalizeCanonicalToken(importRecord.Name)}";
    }

    private static string NormalizeCanonicalKey(string canonicalKey)
    {
        var separator = canonicalKey.IndexOf("::", StringComparison.Ordinal);
        if (separator < 0)
        {
            return $"manual::{NormalizeCanonicalToken(canonicalKey)}";
        }

        var source = canonicalKey[..separator];
        var name = canonicalKey[(separator + 2)..];
        return $"{NormalizeCanonicalToken(source)}::{NormalizeCanonicalToken(name)}";
    }

    private static string NormalizeCanonicalToken(string input)
    {
        if (string.IsNullOrWhiteSpace(input))
        {
            return "unknown";
        }

        var value = input.ToLowerInvariant().Trim();
        value = CanonicalTokenRegex.Replace(value, "_");
        value = Regex.Replace(value, "_+", "_").Trim('_');
        return value.Length == 0 ? "unknown" : value;
    }

    private static string BuildRecipeFingerprint(AdminCocktailImportRecord importRecord)
    {
        var normalizedName = NormalizeFingerprintText(importRecord.Name);
        var normalizedIngredients = (importRecord.Ingredients ?? new List<AdminCocktailImportIngredientRecord>())
            .Where(x => !string.IsNullOrWhiteSpace(x.IngredientName))
            .Select(x => NormalizeCanonicalToken(x.IngredientName))
            .OrderBy(x => x, StringComparer.Ordinal)
            .ToList();
        var normalizedSteps = (importRecord.Steps ?? new List<AdminCocktailImportStepRecord>())
            .Where(x => !string.IsNullOrWhiteSpace(x.Instruction))
            .Select(x => NormalizeFingerprintText(x.Instruction))
            .ToList();

        var input = $"{normalizedName}|{string.Join(",", normalizedIngredients)}|{string.Join(",", normalizedSteps)}";
        var bytes = SHA256.HashData(Encoding.UTF8.GetBytes(input));
        return Convert.ToHexString(bytes);
    }

    private static string NormalizeFingerprintText(string? value)
    {
        if (string.IsNullOrWhiteSpace(value))
        {
            return string.Empty;
        }

        var normalized = value.ToLowerInvariant().Trim();
        normalized = Regex.Replace(normalized, @"[^\p{L}\p{N}\s]", " ");
        normalized = Regex.Replace(normalized, @"\s+", " ").Trim();
        return normalized;
    }

    private static async Task<int> ResolveOrCreateIngredientIdAsync(
        SqliteConnection connection,
        DbTransaction tx,
        string ingredientName)
    {
        var cleanedName = IngredientNameNormalizer.CleanupDisplayName(ingredientName);
        var normalizedName = IngredientNameNormalizer.Normalize(cleanedName);
        if (normalizedName.Length == 0)
        {
            throw new InvalidOperationException("Ingredient name is required.");
        }

        var ingredientId = await connection.ExecuteScalarAsync<long?>(
            """
            SELECT Id
            FROM Ingredients
            WHERE NormalizedName = @NormalizedName
            LIMIT 1;
            """,
            new { NormalizedName = normalizedName },
            tx);
        if (ingredientId.HasValue)
        {
            return (int)ingredientId.Value;
        }

        var insertedId = await connection.ExecuteScalarAsync<long>(
            """
            INSERT INTO Ingredients (Name, NormalizedName)
            VALUES (@Name, @NormalizedName);
            SELECT last_insert_rowid();
            """,
            new { Name = cleanedName, NormalizedName = normalizedName },
            tx);
        return (int)insertedId;
    }

    private static async Task<int?> ResolveAmountIdAsync(
        SqliteConnection connection,
        DbTransaction tx,
        int? amountId,
        string? amountText)
    {
        if (amountId.HasValue)
        {
            var existingAmountId = await connection.ExecuteScalarAsync<long?>(
                "SELECT Id FROM Amounts WHERE Id = @Id;",
                new { Id = amountId.Value },
                tx);
            if (existingAmountId.HasValue)
            {
                return (int)existingAmountId.Value;
            }
        }

        if (string.IsNullOrWhiteSpace(amountText))
        {
            return null;
        }

        var matchedAmountId = await connection.ExecuteScalarAsync<long?>(
            """
            SELECT Id
            FROM Amounts
            WHERE lower(trim(MeasurementName)) = lower(trim(@AmountText))
            LIMIT 1;
            """,
            new { AmountText = amountText.Trim() },
            tx);

        return matchedAmountId.HasValue ? (int)matchedAmountId.Value : null;
    }
}
