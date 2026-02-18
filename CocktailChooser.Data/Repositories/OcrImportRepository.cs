using Dapper;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.Data.Repositories;

public class OcrImportRepository : IOcrImportRepository
{
    private readonly string _connectionString;

    public OcrImportRepository(string connectionString)
    {
        _connectionString = connectionString;
    }

    public async Task<OcrImportRecord?> GetImportByIdAsync(int id)
    {
        const string sql = """
            SELECT
                Id,
                RecipeSourceId,
                ImportName,
                ImportType,
                FileName,
                Status,
                Notes,
                CreatedUtc,
                CompletedUtc
            FROM OcrImports
            WHERE Id = @Id;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QuerySingleOrDefaultAsync<OcrImportRecord>(sql, new { Id = id });
    }

    public async Task<IEnumerable<OcrImportItemRecord>> GetImportItemsAsync(int importId)
    {
        const string sql = """
            SELECT
                Id,
                OcrImportId,
                ItemKey,
                RawText,
                RawOcrJson,
                Confidence,
                Status,
                CreatedUtc
            FROM OcrImportItems
            WHERE OcrImportId = @OcrImportId
            ORDER BY Id;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<OcrImportItemRecord>(sql, new { OcrImportId = importId });
    }

    public async Task<OcrImportRecord> CreateImportAsync(OcrImportRecord importRecord)
    {
        const string sql = """
            INSERT INTO OcrImports
            (
                RecipeSourceId,
                ImportName,
                ImportType,
                FileName,
                Status,
                Notes
            )
            VALUES
            (
                @RecipeSourceId,
                @ImportName,
                @ImportType,
                @FileName,
                @Status,
                @Notes
            );
            SELECT last_insert_rowid();
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var id = await connection.ExecuteScalarAsync<long>(sql, importRecord);
        return (await GetImportByIdAsync((int)id))!;
    }

    public async Task<OcrImportItemRecord> CreateImportItemAsync(OcrImportItemRecord importItemRecord)
    {
        const string sql = """
            INSERT INTO OcrImportItems
            (
                OcrImportId,
                ItemKey,
                RawText,
                RawOcrJson,
                Confidence,
                Status
            )
            VALUES
            (
                @OcrImportId,
                @ItemKey,
                @RawText,
                @RawOcrJson,
                @Confidence,
                @Status
            );
            SELECT last_insert_rowid();
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var id = await connection.ExecuteScalarAsync<long>(sql, importItemRecord);
        return (await GetImportItemByIdAsync((int)id))!;
    }

    public async Task<OcrImportItemRecord?> GetImportItemByIdAsync(int itemId)
    {
        const string sql = """
            SELECT
                Id,
                OcrImportId,
                ItemKey,
                RawText,
                RawOcrJson,
                Confidence,
                Status,
                CreatedUtc
            FROM OcrImportItems
            WHERE Id = @Id;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QuerySingleOrDefaultAsync<OcrImportItemRecord>(sql, new { Id = itemId });
    }

    public async Task<bool> UpdateImportItemStatusAsync(int itemId, string status)
    {
        const string sql = """
            UPDATE OcrImportItems
            SET Status = @Status
            WHERE Id = @Id;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        var rows = await connection.ExecuteAsync(sql, new { Id = itemId, Status = status });
        return rows > 0;
    }

    public async Task ReplaceCandidatesForItemAsync(int itemId, IEnumerable<OcrParsedRecipeDraft> drafts)
    {
        await using var connection = new SqliteConnection(_connectionString);
        await connection.OpenAsync();
        await using var transaction = await connection.BeginTransactionAsync();

        const string deleteSql = """
            DELETE FROM OcrRecipeCandidates
            WHERE OcrImportItemId = @OcrImportItemId;
            """;
        await connection.ExecuteAsync(deleteSql, new { OcrImportItemId = itemId }, transaction);

        const string insertRecipeSql = """
            INSERT INTO OcrRecipeCandidates
            (
                OcrImportItemId,
                CocktailName,
                SourceRecipeName,
                MethodText,
                ParserVersion,
                Confidence,
                Status,
                ParseWarnings
            )
            VALUES
            (
                @OcrImportItemId,
                @CocktailName,
                @SourceRecipeName,
                @MethodText,
                @ParserVersion,
                @Confidence,
                'Pending',
                @ParseWarnings
            );
            SELECT last_insert_rowid();
            """;

        const string insertIngredientSql = """
            INSERT INTO OcrIngredientCandidates
            (
                OcrRecipeCandidateId,
                SortOrder,
                RawLine,
                RawAmount,
                RawIngredientName,
                Confidence,
                ParseWarnings
            )
            VALUES
            (
                @OcrRecipeCandidateId,
                @SortOrder,
                @RawLine,
                @RawAmount,
                @RawIngredientName,
                @Confidence,
                @ParseWarnings
            );
            """;

        const string insertStepSql = """
            INSERT INTO OcrStepCandidates
            (
                OcrRecipeCandidateId,
                StepNumber,
                Instruction,
                Confidence
            )
            VALUES
            (
                @OcrRecipeCandidateId,
                @StepNumber,
                @Instruction,
                @Confidence
            );
            """;

        foreach (var draft in drafts)
        {
            var recipeCandidateId = await connection.ExecuteScalarAsync<long>(
                insertRecipeSql,
                new
                {
                    OcrImportItemId = itemId,
                    draft.CocktailName,
                    draft.SourceRecipeName,
                    draft.MethodText,
                    draft.ParserVersion,
                    draft.Confidence,
                    draft.ParseWarnings
                },
                transaction);

            foreach (var ingredient in draft.Ingredients)
            {
                await connection.ExecuteAsync(
                    insertIngredientSql,
                    new
                    {
                        OcrRecipeCandidateId = (int)recipeCandidateId,
                        ingredient.SortOrder,
                        ingredient.RawLine,
                        ingredient.RawAmount,
                        ingredient.RawIngredientName,
                        ingredient.Confidence,
                        ingredient.ParseWarnings
                    },
                    transaction);
            }

            foreach (var step in draft.Steps)
            {
                await connection.ExecuteAsync(
                    insertStepSql,
                    new
                    {
                        OcrRecipeCandidateId = (int)recipeCandidateId,
                        step.StepNumber,
                        step.Instruction,
                        step.Confidence
                    },
                    transaction);
            }
        }

        await transaction.CommitAsync();
    }

    public async Task<IEnumerable<OcrRecipeCandidateRecord>> GetRecipeCandidatesByItemIdAsync(int itemId)
    {
        const string sql = """
            SELECT
                Id,
                OcrImportItemId,
                CocktailName,
                SourceRecipeName,
                MethodText,
                ParserVersion,
                Confidence,
                Status,
                ParseWarnings,
                CreatedUtc
            FROM OcrRecipeCandidates
            WHERE OcrImportItemId = @OcrImportItemId
            ORDER BY Id;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<OcrRecipeCandidateRecord>(sql, new { OcrImportItemId = itemId });
    }

    public async Task<IEnumerable<OcrIngredientCandidateRecord>> GetIngredientCandidatesByRecipeCandidateIdAsync(int recipeCandidateId)
    {
        const string sql = """
            SELECT
                Id,
                OcrRecipeCandidateId,
                SortOrder,
                RawLine,
                RawAmount,
                RawIngredientName,
                NormalizedAmountId,
                NormalizedIngredientId,
                Confidence,
                ParseWarnings,
                CreatedUtc
            FROM OcrIngredientCandidates
            WHERE OcrRecipeCandidateId = @OcrRecipeCandidateId
            ORDER BY SortOrder, Id;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<OcrIngredientCandidateRecord>(sql, new { OcrRecipeCandidateId = recipeCandidateId });
    }

    public async Task<IEnumerable<OcrStepCandidateRecord>> GetStepCandidatesByRecipeCandidateIdAsync(int recipeCandidateId)
    {
        const string sql = """
            SELECT
                Id,
                OcrRecipeCandidateId,
                StepNumber,
                Instruction,
                Confidence,
                CreatedUtc
            FROM OcrStepCandidates
            WHERE OcrRecipeCandidateId = @OcrRecipeCandidateId
            ORDER BY StepNumber;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<OcrStepCandidateRecord>(sql, new { OcrRecipeCandidateId = recipeCandidateId });
    }
}
