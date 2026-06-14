#!/usr/bin/env python3
"""Convert a Claude Code session JSONL into a readable Markdown transcript.

A deliberately simple, dependency-free linearizer: it walks the session in
order and emits each turn's meaningful content (user text, assistant text,
tool calls, and tool results) as Markdown. It does NOT impose any game/journal
structure - the output is raw material to hand-munge into a final transcript.

Usage:
    python3 scripts/jsonl-to-md.py SESSION.jsonl [-o OUT.md] [--thinking]
                                   [--max-tool-lines N]

With no -o, writes to stdout. Pass --thinking to include assistant reasoning
blocks (omitted by default as transcript noise). Pass --max-tool-lines to
truncate long tool outputs (e.g. whole-file Reads) while keeping short ones
like roll.sh log lines intact.
"""

import argparse
import json
import sys


def blocks(content):
    """Yield (type, block) for a message's content (string or list form)."""
    if isinstance(content, str):
        yield "text", {"text": content}
    elif isinstance(content, list):
        for block in content:
            if isinstance(block, dict):
                yield block.get("type", "unknown"), block


def result_text(block):
    """Flatten a tool_result's content (string or list of text blocks)."""
    content = block.get("content", "")
    if isinstance(content, str):
        return content
    if isinstance(content, list):
        parts = [b.get("text", "") for b in content if isinstance(b, dict)]
        return "\n".join(parts)
    return str(content)


def truncate(text, max_lines):
    """Clip text to max_lines, appending an elision note if clipped."""
    if max_lines is None:
        return text
    lines = text.splitlines()
    if len(lines) <= max_lines:
        return text
    kept = lines[:max_lines]
    return "\n".join(kept) + f"\n... ({len(lines) - max_lines} more lines truncated)"


def render(event, include_thinking, max_tool_lines):
    """Render one JSONL event to a list of Markdown chunks (may be empty)."""
    if event.get("isMeta"):
        return []
    etype = event.get("type")
    if etype not in ("user", "assistant"):
        return []

    out = []
    for btype, block in blocks(event.get("message", {}).get("content", "")):
        if btype == "text":
            text = block.get("text", "").strip()
            if not text:
                continue
            if etype == "user":
                out.append(f"**User:**\n\n{text}")
            else:
                out.append(text)
        elif btype == "thinking" and include_thinking:
            out.append(f"<details><summary>thinking</summary>\n\n{block.get('thinking', '').strip()}\n\n</details>")
        elif btype == "tool_use":
            name = block.get("name", "tool")
            inp = block.get("input", {})
            if name == "Bash" and "command" in inp:
                out.append(f"```sh\n{inp['command']}\n```")
            else:
                out.append(f"_({name})_ `{json.dumps(inp, ensure_ascii=False)}`")
        elif btype == "tool_result":
            text = truncate(result_text(block).rstrip(), max_tool_lines)
            if text:
                out.append(f"```\n{text}\n```")
    return out


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("jsonl", help="path to the Claude Code session .jsonl")
    parser.add_argument("-o", "--output", help="output file (default: stdout)")
    parser.add_argument("--thinking", action="store_true",
                        help="include assistant thinking blocks")
    parser.add_argument("--max-tool-lines", type=int, default=None,
                        help="truncate tool outputs longer than N lines")
    args = parser.parse_args(argv)

    chunks = []
    with open(args.jsonl, encoding="utf-8") as handle:
        for line in handle:
            line = line.strip()
            if not line:
                continue
            try:
                event = json.loads(line)
            except json.JSONDecodeError:
                continue
            chunks.extend(render(event, args.thinking, args.max_tool_lines))

    body = "\n\n".join(chunks) + "\n"

    if args.output:
        with open(args.output, "w", encoding="utf-8") as handle:
            handle.write(body)
        print(f"wrote {len(chunks)} blocks to {args.output}", file=sys.stderr)
    else:
        sys.stdout.write(body)


if __name__ == "__main__":
    main()
