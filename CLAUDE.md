# Claude — Vault Guide

## Structure
| Folder | Purpose |
|---|---|
| `0 - Meta/` | System docs and templates — read before doing anything |
| `0 - Meta/Specs/Ongoing/` | Active design specs — move to Completed/ once implemented |
| `0 - Meta/Specs/Completed/` | Implemented specs — historical reference |
| `0 - Meta/Todo/Ongoing/` | Pre-specs needing investigation before a spec can be drafted |
| `0 - Meta/Todo/Completed/` | Investigated todos — promoted to spec or closed |
| `0 - Meta/Skills/` | Claude-executable runbook procedures — followed when instructed in chat |
| `1 - Inbox/` | Rough ideas, capture zone |
| `1 - Inbox/Logs/` | Session logs — one file per Claude conversation |
| `2 - Sources/` | Source material, filed by topic then type |
| `2 - Sources/<topic>/_active/` | In-progress sources — per-topic folder, move to typed subfolder when finished |
| `3 - Tags/` | Tag stub notes; grow into Indexes when large |
| `4 - Notes/` | All atomic notes — **flat, no subfolders** |
| `5 - Skills/` | Human how-to notes and repeatable processes |
| `6 - Guides/` | Explanatory documentation — how systems work, why things are designed as they are |
| `_attachments/` | Images and PDFs |

## Creating Atomic Notes
- File goes in `4 - Notes/` — never in a subfolder
- Filename: slugified title, e.g. `sourdough-fermentation-basics.md`
- If filename already exists, append a disambiguator: `sourdough-fermentation-basics-2.md`
- Use `note-template.md`
- One idea per note — review before splitting. Default is to keep the note together unless splitting genuinely improves clarity. Never split just to hit a word count.
- Tags via `[[wikilinks]]` in the `Tags:` inline field — example: `Tags: [[cooking]] [[food-science]]`
- **Never** put tags in YAML frontmatter `tags:` list — always use inline `Tags:` field with wikilinks

## Creating Source Notes
- File goes in `2 - Sources/<topic>/<type>/` — create the topic folder if it doesn't exist
- **Never use an `_unsorted/` folder**
- Use `source-template.md`
- Move from `_active/` to typed subfolder when the source is finished
- `_active/` = currently being read/watched; check here first when continuing work on a source

## Creating Skill Notes
- File goes in `5 - Skills/`
- Use `skill-template.md`
- Use `type: skill` and `status: draft` or `status: stable` — no baby/child/adult arc
- Skills are reference/procedural — they don't need the same connection-building as atomic notes

## Creating Guide Notes
- File goes in `6 - Guides/` — single file for simple topics, named subfolder with sub-pages for complex ones
- Use `guide-template.md`
- Use `type: guide` in frontmatter — no status arc, no word limit
- Write for scanning: clear headings, short paragraphs, plain language
- No assumed context — guides should be understandable without reading anything else first
- Update guides when the system they describe changes

## Proactive Note Drafting
Draft a note whenever you detect content worth preserving — especially:
- Something looked up, investigated, or explained that has come up before or will likely recur
- A non-obvious process or configuration that required research
- A concept from an external source (book, video, article, docs)
- A decision made with reasoning worth preserving

**Draft workflow:**
1. Write the draft to `1 - Inbox/` using note-template
2. At the end of your response, mention it: *"I've drafted a note on X — it's in 1 - Inbox/ as `filename.md`. Let me know if you want to keep it, adjust it, or discard it."*
3. If user explicitly approves ("keep it", "yes", "move it") → move to `4 - Notes/`, create tag stub in `3 - Tags/` if needed
4. If user says nothing → leave in Inbox (being in 1 - Inbox/ is the draft signal)
5. At natural session wrap-up → mention any pending Inbox drafts from this session

Never use frontmatter status or filename prefixes to mark drafts. Folder location is the only signal.

## Tags
- Tags are wikilink-notes pointing to files in `3 - Tags/`
- Example: `Tags: [[cooking]] [[food-science]]` links to `3 - Tags/cooking.md` and `3 - Tags/food-science.md`
- When creating a new `[[tag]]`, also create `3 - Tags/<tag>.md` with frontmatter:
  ```
  ---
  type: tag
  ---
  <!-- description of what belongs here -->
  ```
- Suggest existing tags from `3 - Tags/` before creating new ones
- Keep to 1–4 tags per note
- When a tag accumulates many linked notes, promote it to an Index by adding
  subheadings and organising the linked notes beneath them

## Todos
- Save new todos to `0 - Meta/Todo/Ongoing/<topic>.md` — descriptive slug, no date prefix needed; append `-2` if a slug is already taken
- Content: rough idea + open questions, no solution yet
- When investigated and ready: promote to `0 - Meta/Specs/Ongoing/` as a full spec, or move to `0 - Meta/Todo/Completed/` if closed without a spec

## Design Specs
- Save new specs to `0 - Meta/Specs/Ongoing/YYYY-MM-DD-<topic>-design.md`
- Move to `0 - Meta/Specs/Completed/` once the spec has been fully implemented
- For content-generation guide specs (e.g. software or game guides), use the skill at `0 - Meta/Skills/guide-spec.md`.

## Session Logs

Session logs live in `1 - Inbox/Logs/`. Create one per Claude conversation using the `session-log.md` template.

Filename convention: `YYYY-MM-DD-<slug>-session.md`

Logs older than 24 hours can be archived to `1 - Inbox/Logs/Old/`.

## Git Commits
After any of these, update `CHANGELOG.md` with what changed, then run:
```
bash "0 - Meta/Hooks/commit-vault.sh" "<short description>"
```
**Triggers:**
- A note is promoted from `1 - Inbox/` to `4 - Notes/`
- A new guide or skill is created or significantly updated
- Hook scripts, templates, or setup docs are changed
- Session wrapping up with significant changes (new notes, structural changes)

## Keeping Meta Files in Sync
Whenever the vault structure, setup process, or Claude integration changes, review and update anything relevant in:
- `CLAUDE.md` (vault root)
- `0 - Meta/`
- `6 - Guides/`
- `CHANGELOG.md`

## Note Status
| Status | Applies to | Meaning |
|---|---|---|
| `baby` | notes | New, undeveloped, few or no connections |
| `child` | notes | Developed, some connections |
| `adult` | notes | Mature, well-connected, reference-quality |
| `draft` | skills | Being written / untested |
| `stable` | skills | Tested and reliable |
| `active` | sources | Currently being read/watched |
| `done` | sources | Finished; all atomic notes extracted |
