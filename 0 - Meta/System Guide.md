# System Guide — Obsidian Zettelkasten Vault

Your personal reference for how the vault works. The same rules live in `CLAUDE.md` at the vault root — that version is optimised for Claude Code to read. This one is for you.

---

## Folder Structure

| Folder | Purpose |
|---|---|
| `0 - Meta/` | System docs, templates, hooks — the vault's own operating layer |
| `0 - Meta/Hooks/` | Canonical hook scripts (source of truth for new machine setup) |
| `0 - Meta/Specs/` | Design specs — `Ongoing/` while in progress, `Completed/` when done |
| `0 - Meta/Todo/` | Pre-specs — rough ideas needing investigation before a spec is drafted |
| `0 - Meta/Templates/` | Note templates used by Obsidian's Template plugin |
| `1 - Inbox/` | Quick capture zone; rough notes, ideas, and Claude draft notes |
| `1 - Inbox/Logs/` | Claude session logs — one file per conversation |
| `2 - Sources/` | Source material — books, videos, articles, docs (filed by topic/type) |
| `3 - Tags/` | Tag notes; grow into Indexes as more notes link to them |
| `4 - Notes/` | All atomic notes — **flat, no subfolders** |
| `5 - Skills/` | How-to guides and repeatable processes |
| `6 - Guides/` | Explanatory docs — how systems work, why they're designed that way |
| `_attachments/` | Images and PDFs |

**Key principle**: `4 - Notes/` is always flat. Connections come from wikilinks and tags, not folders.

---

## Writing a Note (Start to Finish)

### Step 1 — Capture in Source Material
When reading a book, watching a video, or reading an article:
- Create a source note in `2 - Sources/<topic>/<type>/` or `_active/` if still in progress
- Use `source-template.md`
- Write page numbers, quotes, and your own commentary in your own words

### Step 2 — Create Atomic Notes
From your source notes, extract the key ideas as individual atomic notes:
- Press `Ctrl+O` → type the note title → `Shift+Enter` to create
- Press `Ctrl+T` to insert the template
- One idea per note — review before splitting. Default is to keep it together unless splitting genuinely improves clarity.

### Step 3 — Tag and Link
- Add `Tags: [[tag1]] [[tag2]]` in the inline Tags field
- Add `[[wikilinks]]` to related notes in the Reference section
- Check `3 - Tags/` for existing tags before creating new ones

### Step 4 — File the Source
When finished with a source, move it from `_active/` to the appropriate typed folder (Books/, Videos/, etc.)

---

## Tags

Tags are **wikilink-notes**, not `#hashtags`. Each tag is an empty note in `3 - Tags/`.

- `Tags: [[cooking]]` links to `3 - Tags/cooking.md`
- Keep tags broad enough to reuse, specific enough to mean something
- Aim for 1–4 tags per note
- When a tag grows large (many linked notes), turn it into an **Index**: add subheadings and organise the linked notes beneath them

---

## Note Status

| Status | Applies to | Meaning |
|---|---|---|
| `baby` | notes | New, undeveloped |
| `child` | notes | Developed, some connections |
| `adult` | notes | Mature, well-connected |
| `draft` | skills | Being written / untested |
| `stable` | skills | Tested and reliable |
| `active` | sources | Currently being read/watched |
| `done` | sources | Finished; all atomic notes extracted |

---

## Plugins

### Required
- **Dataview** — query notes like a database
- **Obsidian Linter** — auto-updates `created:` and `updated:` fields on save
- **Templater** — smarter templates with dynamic dates

### Optional
- **Natural Language Dates** — type `@today` instead of manual dates
- **Smart Random Note** — resurfaces forgotten notes for review

### Linter Setup
Settings → Community Plugins → Linter → YAML Timestamps:
- Date Created: enable → key: `created`, format: `YYYY-MM-DD`
- Date Modified: enable → key: `updated`, format: `YYYY-MM-DD`
- Lint on save: enable

---

## Obsidian Settings (one-time)

1. **Files & Links** → Default location for new notes → `4 - Notes`
2. **Core Plugins** → Templates → enable; folder = `0 - Meta/Templates`
3. **Hotkeys** → Insert template → `Ctrl+T`

---

## Dataview Example Queries

Paste these into any note with a `dataview` code block:

```dataview
TABLE status, file.ctime AS created
FROM "4 - Notes"
SORT file.ctime DESC
```

```dataview
TABLE status
FROM "4 - Notes"
WHERE contains(file.outlinks, [[cooking]])
```

```dataview
TABLE topic, medium, status
FROM "2 - Sources"
SORT updated DESC
```

```dataview
TABLE file.ctime AS date
FROM "1 - Inbox/Logs"
SORT file.ctime DESC
```

---

## Claude Code Integration

Claude Code reads `CLAUDE.md` automatically when your working directory is this vault, and via the global `~/.claude/CLAUDE.md` pointer in any session. This means Claude knows the vault rules without being told each time.

### Session Logs
Claude creates a log at the start of every session in `1 - Inbox/Logs/`, named after the session topic (e.g. `2024-01-15-fermentation-guide-session.md`). Review these to see what was done in past sessions.

### Git
The vault is a git repo. Claude commits after major changes and updates `CHANGELOG.md` at the root. Run `bash "0 - Meta/Hooks/commit-vault.sh" "message"` to commit manually.

### New Machine Setup
See `0 - Meta/New Computer Setup.md`. Tell Claude "set up vault integration on this machine" and it will handle everything.
