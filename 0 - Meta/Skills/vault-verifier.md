---
created: 2024-01-01T00:00:00
updated: 2024-01-01T00:00:00
type: skill
status: stable
---
Tags: [[productivity]]

# Vault Verifier

## Purpose

Check that the vault's folder structure and templates are internally consistent. Run this when something feels stale or after a significant structural change.

## Steps

### 1. Check folder structure matches CLAUDE.md

Read the Structure table in `CLAUDE.md`. For each folder listed, verify it exists on disk under the vault root:

```bash
ls "<VAULT_ROOT>"
```

Report any folder listed in the table but missing on disk, or any top-level folder on disk not listed in the table.

Folders to skip (expected to be unlisted): `.git`, `.obsidian`, `.trash`.

### 2. Check templates are present

Verify all five templates exist in `0 - Meta/Templates/`:

```bash
for f in note-template.md source-template.md guide-template.md skill-template.md session-log.md; do
  [ -f "<VAULT_ROOT>/0 - Meta/Templates/$f" ] && echo "EXISTS: $f" || echo "MISSING: $f"
done
```

Report any missing templates.

### 3. Check tag stubs exist for all wikilink tags in use

Scan all files in `4 - Notes/` and `5 - Skills/` for `[[wikilink]]` patterns in `Tags:` lines. For each unique tag found, verify a corresponding stub file exists in `3 - Tags/`.

Report any tag referenced in a note but missing its stub file.

### 4. Report

Output a summary:

```
VAULT VERIFICATION REPORT
==========================
[PASS/FAIL] Folder structure matches CLAUDE.md
[PASS/FAIL] All templates present
[PASS/FAIL] All tag stubs present

Issues:
- <list any mismatches found>
```

If all pass, confirm vault is in sync. If any fail, list the specific files or folders to fix.

## Notes / Gotchas

- Replace `<VAULT_ROOT>` with the absolute path to your vault root.
- Run this after any structural change (new folder, renamed folder, added template).
- The tag check only scans `Tags:` inline fields — it does not scan body wikilinks.

## Reference

- `CLAUDE.md` — vault guide and folder structure table
- `0 - Meta/Templates/` — template files
- `3 - Tags/` — tag stub files
