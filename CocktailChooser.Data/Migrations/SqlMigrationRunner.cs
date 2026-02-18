using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using Dapper;
using Microsoft.Data.Sqlite;

namespace CocktailChooser.Data.Migrations;

public static class SqlMigrationRunner
{
    private static readonly Regex VersionedFilePattern = new(@"^(?<version>\d+)_.*\.sql$", RegexOptions.Compiled);

    public static void Run(string connectionString)
    {
        using var connection = new SqliteConnection(connectionString);
        connection.Open();
        connection.Execute("PRAGMA foreign_keys = ON;");
        connection.Execute("PRAGMA busy_timeout = 5000;");

        EnsureSchemaMigrationsTable(connection);

        if (IsBootstrapNeeded(connection))
        {
            ExecuteScript(connection, ReadResourceText("Data.Migrations.initial_schema.sql"));
            ExecuteScript(connection, ReadResourceText("Data.Migrations.initial_data.sql"));
        }

        ApplyVersionedMigrations(connection);
    }

    private static void EnsureSchemaMigrationsTable(SqliteConnection connection)
    {
        connection.Execute(
            """
            CREATE TABLE IF NOT EXISTS SchemaMigrations (
                Version TEXT PRIMARY KEY,
                Name TEXT NOT NULL,
                Checksum TEXT NOT NULL,
                AppliedUtc TEXT NOT NULL
            );
            """);
    }

    private static bool IsBootstrapNeeded(SqliteConnection connection)
    {
        const string sql =
            """
            SELECT COUNT(*)
            FROM sqlite_master
            WHERE type = 'table'
              AND name NOT LIKE 'sqlite_%'
              AND name <> 'SchemaMigrations';
            """;

        return connection.ExecuteScalar<long>(sql) == 0;
    }

    private static void ApplyVersionedMigrations(SqliteConnection connection)
    {
        var applied = connection.Query<(string Version, string Checksum)>(
            "SELECT Version, Checksum FROM SchemaMigrations;").ToDictionary(x => x.Version, x => x.Checksum);

        foreach (var migration in LoadVersionedMigrations())
        {
            if (applied.TryGetValue(migration.Version, out var appliedChecksum))
            {
                if (!string.Equals(appliedChecksum, migration.Checksum, StringComparison.Ordinal))
                {
                    throw new InvalidOperationException(
                        $"Migration checksum mismatch for version {migration.Version} ({migration.Name}).");
                }

                continue;
            }

            ExecuteScript(connection, migration.Sql);
            connection.Execute(
                """
                INSERT INTO SchemaMigrations (Version, Name, Checksum, AppliedUtc)
                VALUES (@Version, @Name, @Checksum, @AppliedUtc);
                """,
                new
                {
                    migration.Version,
                    migration.Name,
                    migration.Checksum,
                    AppliedUtc = DateTime.UtcNow.ToString("O")
                });
        }
    }

    private static IReadOnlyList<MigrationScript> LoadVersionedMigrations()
    {
        var assembly = typeof(SqlMigrationRunner).Assembly;
        const string marker = ".Data.Migrations.Versions.";

        return assembly.GetManifestResourceNames()
            .Where(name => name.Contains(marker, StringComparison.Ordinal) && name.EndsWith(".sql", StringComparison.OrdinalIgnoreCase))
            .Select(name =>
            {
                var markerIndex = name.IndexOf(marker, StringComparison.Ordinal);
                var fileName = name[(markerIndex + marker.Length)..];
                var match = VersionedFilePattern.Match(fileName);

                if (!match.Success)
                {
                    throw new InvalidOperationException(
                        $"Invalid migration file name '{fileName}'. Expected '<number>_name.sql'.");
                }

                var version = int.Parse(match.Groups["version"].Value).ToString("D6");
                var sql = ReadResourceTextByName(name);

                return new MigrationScript(version, fileName, sql, ComputeSha256(sql));
            })
            .OrderBy(migration => migration.Version, StringComparer.Ordinal)
            .ToList();
    }

    private static string ReadResourceText(string suffix)
    {
        var assembly = typeof(SqlMigrationRunner).Assembly;
        var resourceName = assembly.GetManifestResourceNames()
            .SingleOrDefault(name => name.EndsWith(suffix, StringComparison.Ordinal));

        if (resourceName is null)
        {
            throw new InvalidOperationException($"Embedded SQL resource not found: {suffix}");
        }

        return ReadResourceTextByName(resourceName);
    }

    private static string ReadResourceTextByName(string resourceName)
    {
        var assembly = typeof(SqlMigrationRunner).Assembly;
        using var stream = assembly.GetManifestResourceStream(resourceName)
                           ?? throw new InvalidOperationException($"Embedded SQL resource stream not found: {resourceName}");
        using var reader = new StreamReader(stream, Encoding.UTF8);
        return reader.ReadToEnd();
    }

    private static string ComputeSha256(string input)
    {
        var bytes = Encoding.UTF8.GetBytes(input);
        var hash = SHA256.HashData(bytes);
        return Convert.ToHexString(hash);
    }

    private static void ExecuteScript(SqliteConnection connection, string sql)
    {
        connection.Execute(sql);
    }

    private sealed record MigrationScript(string Version, string Name, string Sql, string Checksum);
}
