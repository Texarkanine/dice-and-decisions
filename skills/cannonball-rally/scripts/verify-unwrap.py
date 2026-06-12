#!/usr/bin/env python3
"""Verify an unwrap diff changed only whitespace in prose blocks."""

from __future__ import annotations

import argparse
import re
import subprocess
import sys
from pathlib import Path


def normalize(text: str) -> str:
    return re.sub(r"\s+", "", text)


def table_rows(text: str) -> list[str]:
    return [line for line in text.splitlines() if line.lstrip().startswith("|")]


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("path", type=Path)
    parser.add_argument(
        "--before",
        type=Path,
        help="Original file snapshot; defaults to git HEAD version",
    )
    args = parser.parse_args()

    after = args.path.read_text(encoding="utf-8")

    if args.before:
        before = args.before.read_text(encoding="utf-8")
    else:
        result = subprocess.run(
            ["git", "--no-pager", "show", f"HEAD:{args.path.as_posix()}"],
            capture_output=True,
            text=True,
            check=False,
        )
        if result.returncode != 0:
            print("error: could not read HEAD version; pass --before", file=sys.stderr)
            return 1
        before = result.stdout

    if normalize(before) != normalize(after):
        print("FAIL: non-whitespace content changed", file=sys.stderr)
        return 1

    if table_rows(before) != table_rows(after):
        print("FAIL: table rows changed", file=sys.stderr)
        return 1

    before_lines = len(before.splitlines())
    after_lines = len(after.splitlines())
    print(f"ok: whitespace-only change ({before_lines} -> {after_lines} lines)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
