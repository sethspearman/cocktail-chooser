#!/usr/bin/env python3
"""Apply one or more DML SQL files to the CocktailChooser SQLite database."""

from __future__ import annotations

import argparse
import glob
import sqlite3
from pathlib import Path


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Apply DML scripts to the CocktailChooser SQLite database."
    )
    parser.add_argument(
        "--db",
        default="CocktailChooser.Data/Data/CocktailChooser.db",
        help="Path to SQLite database file.",
    )
    parser.add_argument(
        "--pattern",
        required=True,
        help="Glob pattern for SQL files (example: 'CocktailChooser.Data/Data/Scripts/DML/source_2/*.sql').",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    db_path = Path(args.db)
    sql_files = sorted(glob.glob(args.pattern))

    if not db_path.exists():
        raise FileNotFoundError(f"Database not found: {db_path}")
    if not sql_files:
        raise FileNotFoundError(f"No SQL files matched pattern: {args.pattern}")

    connection = sqlite3.connect(str(db_path))
    try:
        connection.execute("PRAGMA foreign_keys = ON;")
        for sql_file in sql_files:
            sql_path = Path(sql_file)
            script_text = sql_path.read_text(encoding="utf-8")
            print(f"Applying: {sql_path}")
            connection.executescript(script_text)
        connection.commit()
    finally:
        connection.close()

    print(f"Applied {len(sql_files)} script(s) successfully.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
