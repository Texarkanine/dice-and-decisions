#!/usr/bin/env python3
"""
Remove hard line wraps from markdown prose while preserving structure.

Tables, headers, list markers, metadata lines (**Label:**), and standalone
code/template lines stay on their own lines. Continuation lines (indented,
lowercase starters, or mid-sentence wraps) join the preceding paragraph with
a single space.

Verifies that stripping all whitespace yields identical content before writing.
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

NEW_BLOCK_PATTERNS: tuple[re.Pattern[str], ...] = (
    re.compile(r"^#{1,6}\s"),
    re.compile(r"^\|"),
    re.compile(r"^[-*]\s"),
    re.compile(r"^\d+\.\s"),
    re.compile(r"^\*\*[^:]+:\*\*"),
    re.compile(r"^Examples:\s*$"),
)

STANDALONE_CODE_LINE = re.compile(r"^`[^`]+`$")


def is_table_row(line: str) -> bool:
    return line.lstrip().startswith("|")


def is_new_block(line: str) -> bool:
    stripped = line.lstrip()
    if STANDALONE_CODE_LINE.match(stripped):
        return True
    return any(pattern.match(stripped) for pattern in NEW_BLOCK_PATTERNS)


def is_continuation(line: str, previous_line: str) -> bool:
    if is_new_block(line):
        return False

    stripped = line.lstrip()
    if line != stripped:
        return True

    if stripped and stripped[0].islower():
        return True

    previous = previous_line.rstrip()
    if previous and previous[-1] not in ".!?:`":
        return True

    return False


def collapse_spaces(text: str) -> str:
    return re.sub(r"  +", " ", text)


def normalize_for_compare(text: str) -> str:
    return re.sub(r"\s+", "", text)


def unwrap_text(text: str) -> str:
    lines = text.splitlines()
    output: list[str] = []
    paragraph_lines: list[str] = []

    def flush_paragraph() -> None:
        nonlocal paragraph_lines
        if not paragraph_lines:
            return
        joined = collapse_spaces(" ".join(part.strip() for part in paragraph_lines))
        output.append(joined)
        paragraph_lines = []

    previous_line = ""

    for line in lines:
        if line.strip() == "":
            flush_paragraph()
            output.append("")
            previous_line = ""
            continue

        if is_table_row(line):
            flush_paragraph()
            output.append(line)
            previous_line = line
            continue

        if not paragraph_lines:
            paragraph_lines = [line]
            previous_line = line
            continue

        if is_continuation(line, previous_line):
            paragraph_lines.append(line)
            previous_line = line
            continue

        flush_paragraph()
        paragraph_lines = [line]
        previous_line = line

    flush_paragraph()

    result = "\n".join(output)
    if text.endswith("\n"):
        result += "\n"
    return result


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description="Remove hard line wraps from markdown prose."
    )
    parser.add_argument("path", type=Path, help="Markdown file to unwrap")
    parser.add_argument(
        "--check",
        action="store_true",
        help="Exit 1 if the file would change; do not write",
    )
    parser.add_argument(
        "--in-place",
        action="store_true",
        help="Write changes back to the input file",
    )
    args = parser.parse_args(argv)

    original = args.path.read_text(encoding="utf-8")
    unwrapped = unwrap_text(original)

    if normalize_for_compare(original) != normalize_for_compare(unwrapped):
        print(
            "error: unwrap would alter non-whitespace content",
            file=sys.stderr,
        )
        return 1

    if original == unwrapped:
        print(f"ok: {args.path} already unwrapped")
        return 0

    if args.check:
        print(f"change: {args.path} has hard wraps to remove")
        return 1

    if not args.in_place:
        sys.stdout.write(unwrapped)
        return 0

    args.path.write_text(unwrapped, encoding="utf-8")
    print(f"updated: {args.path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
