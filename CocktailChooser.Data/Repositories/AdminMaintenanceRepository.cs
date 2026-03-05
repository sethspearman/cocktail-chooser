using Dapper;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.Data.Repositories;

public class AdminMaintenanceRepository : IAdminMaintenanceRepository
{
    private readonly string _connectionString;

    public AdminMaintenanceRepository(string connectionString)
    {
        _connectionString = connectionString;
    }

    public async Task<IEnumerable<IngredientDuplicateCandidateRecord>> GetIngredientDuplicateCandidatesAsync()
    {
        const string sql = """
            WITH duplicate_names AS (
                SELECT NormalizedName
                FROM Ingredients
                WHERE COALESCE(TRIM(NormalizedName), '') <> ''
                GROUP BY NormalizedName
                HAVING COUNT(*) > 1
            )
            SELECT
                i.NormalizedName,
                i.Id AS IngredientId,
                i.Name,
                (
                    SELECT COUNT(*)
                    FROM CocktailIngredients ci
                    WHERE ci.IngredientId = i.Id
                ) AS CocktailUsageCount,
                (
                    SELECT COUNT(*)
                    FROM UserIngredients ui
                    WHERE ui.IngredientId = i.Id
                ) AS UserUsageCount
            FROM Ingredients i
            INNER JOIN duplicate_names dn ON dn.NormalizedName = i.NormalizedName
            ORDER BY i.NormalizedName, i.Id;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<IngredientDuplicateCandidateRecord>(sql);
    }

    public async Task<IEnumerable<CocktailDuplicateCandidateRecord>> GetCocktailDuplicateCandidatesAsync()
    {
        const string sql = """
            WITH cocktails_with_normalized_name AS (
                SELECT
                    c.Id,
                    c.Name,
                    c.CocktailSourceId,
                    c.CanonicalKey,
                    COALESCE(c.IsApproved, 0) AS IsApproved,
                    lower(
                        trim(
                            replace(
                                replace(
                                    replace(
                                        replace(
                                            replace(c.Name, char(9), ' '),
                                            char(10), ' '
                                        ),
                                        char(13), ' '
                                    ),
                                    '  ', ' '
                                ),
                                '  ', ' '
                            )
                        )
                    ) AS NormalizedName
                FROM Cocktails c
                WHERE COALESCE(trim(c.Name), '') <> ''
            ),
            duplicate_names AS (
                SELECT NormalizedName
                FROM cocktails_with_normalized_name
                GROUP BY NormalizedName
                HAVING COUNT(*) > 1
            )
            SELECT
                cwnn.NormalizedName,
                cwnn.Id AS CocktailId,
                cwnn.Name,
                cwnn.CocktailSourceId,
                cwnn.CanonicalKey,
                (
                    SELECT COUNT(*)
                    FROM CocktailIngredients ci
                    WHERE ci.CocktailId = cwnn.Id
                ) AS IngredientRowCount,
                (
                    SELECT COUNT(*)
                    FROM CocktailSteps cs
                    WHERE cs.CocktailId = cwnn.Id
                ) AS StepRowCount,
                cwnn.IsApproved
            FROM cocktails_with_normalized_name cwnn
            INNER JOIN duplicate_names dn ON dn.NormalizedName = cwnn.NormalizedName
            ORDER BY cwnn.NormalizedName, cwnn.Id;
            """;

        await using var connection = new SqliteConnection(_connectionString);
        return await connection.QueryAsync<CocktailDuplicateCandidateRecord>(sql);
    }

    public async Task<IngredientMergePreviewRecord> PreviewIngredientMergeAsync(int keepIngredientId, int removeIngredientId)
    {
        if (keepIngredientId <= 0 || removeIngredientId <= 0)
        {
            throw new ArgumentException("Ingredient ids must be positive.");
        }

        if (keepIngredientId == removeIngredientId)
        {
            throw new ArgumentException("Keep and remove ingredient ids must be different.");
        }

        await using var connection = new SqliteConnection(_connectionString);
        await connection.OpenAsync();

        var keepExists = await connection.ExecuteScalarAsync<long>(
            "SELECT COUNT(*) FROM Ingredients WHERE Id = @Id;",
            new { Id = keepIngredientId });
        var removeExists = await connection.ExecuteScalarAsync<long>(
            "SELECT COUNT(*) FROM Ingredients WHERE Id = @Id;",
            new { Id = removeIngredientId });

        if (keepExists == 0 || removeExists == 0)
        {
            throw new InvalidOperationException("One or both ingredient ids do not exist.");
        }

        var cocktailRowsWouldRepoint = await connection.ExecuteScalarAsync<long>(
            "SELECT COUNT(*) FROM CocktailIngredients WHERE IngredientId = @IngredientId;",
            new { IngredientId = removeIngredientId });

        var cocktailDuplicateRowsWouldDelete = await connection.ExecuteScalarAsync<long>(
            """
            SELECT COUNT(*)
            FROM CocktailIngredients src
            WHERE src.IngredientId = @RemoveIngredientId
              AND EXISTS (
                  SELECT 1
                  FROM CocktailIngredients dst
                  WHERE dst.CocktailId = src.CocktailId
                    AND dst.IngredientId = @KeepIngredientId
                    AND ifnull(dst.AmountId, -1) = ifnull(src.AmountId, -1)
                    AND ifnull(dst.AmountText, '') = ifnull(src.AmountText, '')
                    AND ifnull(dst.SortOrder, -1) = ifnull(src.SortOrder, -1)
              );
            """,
            new
            {
                KeepIngredientId = keepIngredientId,
                RemoveIngredientId = removeIngredientId
            });

        var userRowsWouldRemoveFromSource = await connection.ExecuteScalarAsync<long>(
            "SELECT COUNT(*) FROM UserIngredients WHERE IngredientId = @IngredientId;",
            new { IngredientId = removeIngredientId });

        return new IngredientMergePreviewRecord
        {
            KeepIngredientId = keepIngredientId,
            RemoveIngredientId = removeIngredientId,
            CocktailRowsWouldRepoint = (int)cocktailRowsWouldRepoint,
            CocktailDuplicateRowsWouldDelete = (int)cocktailDuplicateRowsWouldDelete,
            UserRowsWouldRemoveFromSource = (int)userRowsWouldRemoveFromSource
        };
    }

    public async Task<IngredientMergeResultRecord> MergeIngredientAsync(int keepIngredientId, int removeIngredientId, int performedByUserId, string? reason)
    {
        if (keepIngredientId <= 0 || removeIngredientId <= 0)
        {
            throw new ArgumentException("Ingredient ids must be positive.");
        }

        if (keepIngredientId == removeIngredientId)
        {
            throw new ArgumentException("Keep and remove ingredient ids must be different.");
        }

        await using var connection = new SqliteConnection(_connectionString);
        await connection.OpenAsync();
        await using var tx = await connection.BeginTransactionAsync();

        var keepExists = await connection.ExecuteScalarAsync<long>(
            "SELECT COUNT(*) FROM Ingredients WHERE Id = @Id;",
            new { Id = keepIngredientId },
            tx);
        var removeExists = await connection.ExecuteScalarAsync<long>(
            "SELECT COUNT(*) FROM Ingredients WHERE Id = @Id;",
            new { Id = removeIngredientId },
            tx);

        if (keepExists == 0 || removeExists == 0)
        {
            throw new InvalidOperationException("One or both ingredient ids do not exist.");
        }

        var cocktailRowsRepointed = await connection.ExecuteAsync(
            """
            UPDATE CocktailIngredients
            SET IngredientId = @KeepIngredientId
            WHERE IngredientId = @RemoveIngredientId;
            """,
            new
            {
                KeepIngredientId = keepIngredientId,
                RemoveIngredientId = removeIngredientId
            },
            tx);

        var cocktailDuplicateRowsDeleted = await connection.ExecuteAsync(
            """
            DELETE FROM CocktailIngredients
            WHERE Id IN (
                SELECT ci1.Id
                FROM CocktailIngredients ci1
                INNER JOIN CocktailIngredients ci2
                    ON ci1.CocktailId = ci2.CocktailId
                   AND ci1.IngredientId = ci2.IngredientId
                   AND ifnull(ci1.AmountId, -1) = ifnull(ci2.AmountId, -1)
                   AND ifnull(ci1.AmountText, '') = ifnull(ci2.AmountText, '')
                   AND ifnull(ci1.SortOrder, -1) = ifnull(ci2.SortOrder, -1)
                   AND ci1.Id > ci2.Id
            );
            """,
            transaction: tx);

        await connection.ExecuteAsync(
            """
            INSERT INTO UserIngredients (UserId, IngredientId, IsInStock, Notes, UpdatedUtc)
            SELECT
                ui.UserId,
                @KeepIngredientId,
                ui.IsInStock,
                ui.Notes,
                ui.UpdatedUtc
            FROM UserIngredients ui
            WHERE ui.IngredientId = @RemoveIngredientId
            ON CONFLICT(UserId, IngredientId) DO UPDATE SET
                IsInStock = CASE
                    WHEN excluded.IsInStock > UserIngredients.IsInStock THEN excluded.IsInStock
                    ELSE UserIngredients.IsInStock
                END,
                Notes = CASE
                    WHEN COALESCE(TRIM(UserIngredients.Notes), '') = '' THEN excluded.Notes
                    ELSE UserIngredients.Notes
                END,
                UpdatedUtc = CASE
                    WHEN excluded.UpdatedUtc > UserIngredients.UpdatedUtc THEN excluded.UpdatedUtc
                    ELSE UserIngredients.UpdatedUtc
                END;
            """,
            new
            {
                KeepIngredientId = keepIngredientId,
                RemoveIngredientId = removeIngredientId
            },
            tx);

        var userRowsRemovedFromSource = await connection.ExecuteAsync(
            """
            DELETE FROM UserIngredients
            WHERE IngredientId = @RemoveIngredientId;
            """,
            new { RemoveIngredientId = removeIngredientId },
            tx);

        var deletedIngredientRows = await connection.ExecuteAsync(
            """
            DELETE FROM Ingredients
            WHERE Id = @RemoveIngredientId;
            """,
            new { RemoveIngredientId = removeIngredientId },
            tx);

        if (deletedIngredientRows == 0)
        {
            throw new InvalidOperationException("Ingredient merge failed because source ingredient was not deleted.");
        }

        var detailJson =
            $"{{\"reason\":\"{EscapeForJson(reason)}\",\"cocktailRowsRepointed\":{cocktailRowsRepointed},\"cocktailDuplicateRowsDeleted\":{cocktailDuplicateRowsDeleted},\"userRowsRemovedFromSource\":{userRowsRemovedFromSource}}}";

        await connection.ExecuteAsync(
            """
            INSERT INTO AdminMaintenanceLogs
            (
                EntityType,
                OperationType,
                KeepEntityId,
                RemovedEntityId,
                DetailsJson,
                PerformedByUserId,
                PerformedUtc
            )
            VALUES
            (
                'Ingredient',
                'Merge',
                @KeepEntityId,
                @RemovedEntityId,
                @DetailsJson,
                @PerformedByUserId,
                @PerformedUtc
            );
            """,
            new
            {
                KeepEntityId = keepIngredientId,
                RemovedEntityId = removeIngredientId,
                DetailsJson = detailJson,
                PerformedByUserId = performedByUserId,
                PerformedUtc = DateTime.UtcNow.ToString("O")
            },
            tx);

        await tx.CommitAsync();

        return new IngredientMergeResultRecord
        {
            KeepIngredientId = keepIngredientId,
            RemoveIngredientId = removeIngredientId,
            CocktailRowsRepointed = cocktailRowsRepointed,
            CocktailDuplicateRowsDeleted = cocktailDuplicateRowsDeleted,
            UserRowsRemovedFromSource = userRowsRemovedFromSource
        };
    }

    public async Task<CocktailMergeResultRecord> MergeCocktailAsync(int keepCocktailId, int removeCocktailId, int performedByUserId, string? reason)
    {
        if (keepCocktailId <= 0 || removeCocktailId <= 0)
        {
            throw new ArgumentException("Cocktail ids must be positive.");
        }

        if (keepCocktailId == removeCocktailId)
        {
            throw new ArgumentException("Keep and remove cocktail ids must be different.");
        }

        await using var connection = new SqliteConnection(_connectionString);
        await connection.OpenAsync();
        await using var tx = await connection.BeginTransactionAsync();

        var keepExists = await connection.ExecuteScalarAsync<long>(
            "SELECT COUNT(*) FROM Cocktails WHERE Id = @Id;",
            new { Id = keepCocktailId },
            tx);
        var removeExists = await connection.ExecuteScalarAsync<long>(
            "SELECT COUNT(*) FROM Cocktails WHERE Id = @Id;",
            new { Id = removeCocktailId },
            tx);

        if (keepExists == 0 || removeExists == 0)
        {
            throw new InvalidOperationException("One or both cocktail ids do not exist.");
        }

        // Merge strategy: keep target cocktail recipe content unchanged.
        // Source recipe rows are deleted rather than appended/combined.
        const int ingredientRowsInsertedToKeep = 0;

        var ingredientRowsDeletedFromSource = await connection.ExecuteAsync(
            "DELETE FROM CocktailIngredients WHERE CocktailId = @RemoveCocktailId;",
            new { RemoveCocktailId = removeCocktailId },
            tx);

        const int stepsInsertedToKeep = 0;

        var stepsDeletedFromSource = await connection.ExecuteAsync(
            "DELETE FROM CocktailSteps WHERE CocktailId = @RemoveCocktailId;",
            new { RemoveCocktailId = removeCocktailId },
            tx);

        var tryLogRowsRepointed = await connection.ExecuteAsync(
            """
            UPDATE CocktailTryLogs
            SET CocktailId = @KeepCocktailId
            WHERE CocktailId = @RemoveCocktailId;
            """,
            new { KeepCocktailId = keepCocktailId, RemoveCocktailId = removeCocktailId },
            tx);

        var groupingRowsInsertedToKeep = await connection.ExecuteAsync(
            """
            INSERT OR IGNORE INTO CocktailGroupingLinks (CocktailId, CocktailSourceId, GroupingName)
            SELECT
                @KeepCocktailId,
                CocktailSourceId,
                GroupingName
            FROM CocktailGroupingLinks
            WHERE CocktailId = @RemoveCocktailId;
            """,
            new { KeepCocktailId = keepCocktailId, RemoveCocktailId = removeCocktailId },
            tx);

        var groupingRowsDeletedFromSource = await connection.ExecuteAsync(
            "DELETE FROM CocktailGroupingLinks WHERE CocktailId = @RemoveCocktailId;",
            new { RemoveCocktailId = removeCocktailId },
            tx);

        var deletedCocktailRows = await connection.ExecuteAsync(
            "DELETE FROM Cocktails WHERE Id = @RemoveCocktailId;",
            new { RemoveCocktailId = removeCocktailId },
            tx);

        if (deletedCocktailRows == 0)
        {
            throw new InvalidOperationException("Cocktail merge failed because source cocktail was not deleted.");
        }

        var detailJson =
            $"{{\"reason\":\"{EscapeForJson(reason)}\",\"ingredientRowsInsertedToKeep\":{ingredientRowsInsertedToKeep},\"ingredientRowsDeletedFromSource\":{ingredientRowsDeletedFromSource},\"stepsInsertedToKeep\":{stepsInsertedToKeep},\"stepsDeletedFromSource\":{stepsDeletedFromSource},\"tryLogRowsRepointed\":{tryLogRowsRepointed},\"groupingRowsInsertedToKeep\":{groupingRowsInsertedToKeep},\"groupingRowsDeletedFromSource\":{groupingRowsDeletedFromSource}}}";

        await connection.ExecuteAsync(
            """
            INSERT INTO AdminMaintenanceLogs
            (
                EntityType,
                OperationType,
                KeepEntityId,
                RemovedEntityId,
                DetailsJson,
                PerformedByUserId,
                PerformedUtc
            )
            VALUES
            (
                'Cocktail',
                'Merge',
                @KeepEntityId,
                @RemovedEntityId,
                @DetailsJson,
                @PerformedByUserId,
                @PerformedUtc
            );
            """,
            new
            {
                KeepEntityId = keepCocktailId,
                RemovedEntityId = removeCocktailId,
                DetailsJson = detailJson,
                PerformedByUserId = performedByUserId,
                PerformedUtc = DateTime.UtcNow.ToString("O")
            },
            tx);

        await tx.CommitAsync();

        return new CocktailMergeResultRecord
        {
            KeepCocktailId = keepCocktailId,
            RemoveCocktailId = removeCocktailId,
            IngredientRowsInsertedToKeep = ingredientRowsInsertedToKeep,
            IngredientRowsDeletedFromSource = ingredientRowsDeletedFromSource,
            StepsInsertedToKeep = stepsInsertedToKeep,
            StepsDeletedFromSource = stepsDeletedFromSource,
            TryLogRowsRepointed = tryLogRowsRepointed,
            GroupingRowsInsertedToKeep = groupingRowsInsertedToKeep,
            GroupingRowsDeletedFromSource = groupingRowsDeletedFromSource
        };
    }

    public async Task<CocktailMergePreviewRecord> PreviewCocktailMergeAsync(int keepCocktailId, int removeCocktailId)
    {
        if (keepCocktailId <= 0 || removeCocktailId <= 0)
        {
            throw new ArgumentException("Cocktail ids must be positive.");
        }

        if (keepCocktailId == removeCocktailId)
        {
            throw new ArgumentException("Keep and remove cocktail ids must be different.");
        }

        await using var connection = new SqliteConnection(_connectionString);
        await connection.OpenAsync();

        var keepExists = await connection.ExecuteScalarAsync<long>(
            "SELECT COUNT(*) FROM Cocktails WHERE Id = @Id;",
            new { Id = keepCocktailId });
        var removeExists = await connection.ExecuteScalarAsync<long>(
            "SELECT COUNT(*) FROM Cocktails WHERE Id = @Id;",
            new { Id = removeCocktailId });

        if (keepExists == 0 || removeExists == 0)
        {
            throw new InvalidOperationException("One or both cocktail ids do not exist.");
        }

        var ingredientRowsWouldInsertToKeep = await connection.ExecuteScalarAsync<long>(
            "SELECT 0;");

        var ingredientRowsWouldDeleteFromSource = await connection.ExecuteScalarAsync<long>(
            "SELECT COUNT(*) FROM CocktailIngredients WHERE CocktailId = @CocktailId;",
            new { CocktailId = removeCocktailId });

        var stepsWouldInsertToKeep = await connection.ExecuteScalarAsync<long>("SELECT 0;");

        var stepsWouldDeleteFromSource = stepsWouldInsertToKeep;

        var tryLogRowsWouldRepoint = await connection.ExecuteScalarAsync<long>(
            "SELECT COUNT(*) FROM CocktailTryLogs WHERE CocktailId = @CocktailId;",
            new { CocktailId = removeCocktailId });

        var groupingRowsWouldInsertToKeep = await connection.ExecuteScalarAsync<long>(
            """
            SELECT COUNT(*)
            FROM CocktailGroupingLinks src
            WHERE src.CocktailId = @RemoveCocktailId
              AND NOT EXISTS (
                  SELECT 1
                  FROM CocktailGroupingLinks dst
                  WHERE dst.CocktailId = @KeepCocktailId
                    AND dst.CocktailSourceId = src.CocktailSourceId
                    AND dst.GroupingName = src.GroupingName
              );
            """,
            new { KeepCocktailId = keepCocktailId, RemoveCocktailId = removeCocktailId });

        var groupingRowsWouldDeleteFromSource = await connection.ExecuteScalarAsync<long>(
            "SELECT COUNT(*) FROM CocktailGroupingLinks WHERE CocktailId = @CocktailId;",
            new { CocktailId = removeCocktailId });

        return new CocktailMergePreviewRecord
        {
            KeepCocktailId = keepCocktailId,
            RemoveCocktailId = removeCocktailId,
            IngredientRowsWouldInsertToKeep = (int)ingredientRowsWouldInsertToKeep,
            IngredientRowsWouldDeleteFromSource = (int)ingredientRowsWouldDeleteFromSource,
            StepsWouldInsertToKeep = (int)stepsWouldInsertToKeep,
            StepsWouldDeleteFromSource = (int)stepsWouldDeleteFromSource,
            TryLogRowsWouldRepoint = (int)tryLogRowsWouldRepoint,
            GroupingRowsWouldInsertToKeep = (int)groupingRowsWouldInsertToKeep,
            GroupingRowsWouldDeleteFromSource = (int)groupingRowsWouldDeleteFromSource
        };
    }

    private static string EscapeForJson(string? value)
    {
        if (string.IsNullOrWhiteSpace(value))
        {
            return string.Empty;
        }

        return value
            .Replace("\\", "\\\\", StringComparison.Ordinal)
            .Replace("\"", "\\\"", StringComparison.Ordinal);
    }
}
