# Obsidian Vault Template

A personal knowledge management vault template for [Obsidian](https://obsidian.md), built around a numbered folder system, atomic notes, and a Zettelkasten-inspired workflow.

Clone it, open it in Obsidian, and start capturing.

---

## Structure

| Folder | Purpose |
|---|---|
| `0 - Meta/` | System docs and templates — read before doing anything |
| `0 - Meta/Specs/` | Design decisions: `Ongoing/` and `Completed/` |
| `0 - Meta/Todo/` | Pre-spec investigations: `Ongoing/` and `Completed/` |
| `0 - Meta/Templates/` | Note, source, guide, skill, and session log templates |
| `0 - Meta/Hooks/` | Git commit script |
| `1 - Inbox/` | Rough ideas and capture zone |
| `1 - Inbox/Logs/` | One session log per working session |
| `2 - Sources/` | Source material filed by `<topic>/<type>/` |
| `3 - Tags/` | Tag stub notes — one file per tag |
| `4 - Notes/` | All atomic notes — flat, no subfolders |
| `5 - Skills/` | Repeatable how-to procedures |
| `6 - Guides/` | Explanatory docs — how systems work |
| `_attachments/` | Images and PDFs |

---

## How to Use

1. Clone this repo
2. Open the folder as a vault in Obsidian (`File → Open folder as vault`)
3. Read `CLAUDE.md` — it explains all conventions in detail
4. Start capturing rough ideas in `1 - Inbox/`
5. Promote developed ideas to `4 - Notes/` using `note-template.md`

---

## Key Conventions

**Atomic notes** — one idea per file, stored flat in `4 - Notes/`. Filename is a slugified title.

**Tags as wikilinks** — tags use `[[wikilinks]]` in an inline `Tags:` field, not YAML frontmatter. Each tag links to a stub file in `3 - Tags/`.

**Numbered folders** — the number prefix creates a consistent visual hierarchy and sort order across all Obsidian views.

**Inbox as staging** — everything starts in `1 - Inbox/`. Folder location (not filename or frontmatter) is the only draft signal.

**Sources → Notes** — source notes in `2 - Sources/` link to the atomic notes they generated in `4 - Notes/`.

---

## Claude Integration

The vault includes `CLAUDE.md` — a guide file that Claude reads at the start of each session. It explains the folder structure, naming conventions, and workflows so Claude can help you capture, develop, and connect notes without needing re-explaining each time.

This is optional. The vault works fine without it.

---

## Templates

Five templates live in `0 - Meta/Templates/`:

| Template | Use for |
|---|---|
| `note-template.md` | Atomic notes in `4 - Notes/` |
| `source-template.md` | Source notes in `2 - Sources/` |
| `guide-template.md` | Guide pages in `6 - Guides/` |
| `skill-template.md` | Skill notes in `5 - Skills/` |
| `session-log.md` | Session logs in `1 - Inbox/Logs/` |
