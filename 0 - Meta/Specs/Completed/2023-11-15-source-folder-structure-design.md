# Source Folder Structure — Design

**Status:** Completed — implemented 2023-11-20
**Created:** 2023-11-15

## Context

Needed a consistent way to file source notes (books, articles, videos, docs) so they're easy to find and don't pile up unsorted.

## Decision

Structure: `2 - Sources/<topic>/<type>/`

- Topic folders created on demand (e.g. `Cooking/`, `History/`)
- Type subfolders: `Books/`, `Articles/`, `Videos/`, `Docs/`
- `_active/` subfolder per topic for sources currently being read

This avoids a flat pile while keeping the hierarchy shallow.

## Outcome

Implemented as documented in `CLAUDE.md`. Working well — no issues after two months of use.
