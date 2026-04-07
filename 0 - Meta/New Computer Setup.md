# New Computer Setup — Claude Code Integration

Instructions for Claude. When asked to set up vault integration on a new machine, execute these steps in order.

---

## Before You Start

Ask: "What is the vault path on this machine?" Default is `~/obsidian-vault-template`. Use the answer as `<VAULT>` throughout.

If the vault is not yet on this machine, clone it first (Step 0). Otherwise skip to Step 1.

---

## Step 0 — Clone vault from GitHub (if not already present)

```bash
git clone https://github.com/<YOUR_GITHUB_USER>/obsidian-vault-template <VAULT>
cd <VAULT>
git checkout main
```

---

## Step 1 — Configure git

Check if these are already set:
```bash
git config --global init.defaultBranch
git config --global push.autoSetupRemote
git config --global pull.rebase
```

If any are missing, set them:
```bash
git config --global init.defaultBranch main
git config --global push.autoSetupRemote true
git config --global pull.rebase true
```

---

## Step 2 — Update ~/.claude/settings.json

Open `~/.claude/settings.json` (create if it doesn't exist). Add or merge, replacing `<NOTES_DIR>` with the parent directory of the vault (e.g. if vault is `~/notes/obsidian-vault-template`, notes dir is `~/notes`):

```json
{
  "permissions": {
    "additionalDirectories": ["<NOTES_DIR>"],
    "allow": [
      "Read(<NOTES_DIR>/**)",
      "Bash(bash <NOTES_DIR>/**)"
    ]
  }
}
```

If `settings.json` already has other entries, merge carefully — do not overwrite existing keys.

---

## Step 3 — Register vault plugin (optional)

If you want to use the `/obsidian-notes:session-log` and `/obsidian-notes:vault-verifier` slash commands in Claude Code, register the local marketplace by adding to `~/.claude/settings.json` under `extraKnownMarketplaces`, replacing `<VAULT>` with the vault path:

```json
"extraKnownMarketplaces": {
  "obsidian-notes": {
    "source": {
      "source": "directory",
      "path": "<VAULT>/0 - Meta/Plugin"
    }
  }
}
```

Then open Claude Code and run:
```
/plugin
/reload-plugins
```

`/plugin` will detect and install the `obsidian-notes` plugin from the local marketplace. `/reload-plugins` activates it in the current session.

Verify by running `/obsidian-notes:vault-verifier`.

---

## Step 4 — Update ~/.claude/CLAUDE.md

Open `~/.claude/CLAUDE.md` (create if it doesn't exist). Add or update the Notes Vault section:

```markdown
## Notes Vault

Personal Zettelkasten vault. When working with notes, read the vault guide:

@<VAULT>/CLAUDE.md
```

---

## Step 5 — Update vault path in skills (if different from default)

If your vault path differs from the default, open each file in `0 - Meta/Skills/` and `0 - Meta/Plugin/` and replace `<VAULT_PATH>` with your actual vault path.

---

## Step 6 — Verify Claude integration

Start a new Claude Code session and ask: "What folder do atomic notes go in?"

Expected answer: `4 - Notes/`. If correct, the `@import` is working.

---

## Step 7 — Install Obsidian (if not already installed)

1. Download from obsidian.md
2. File → Open Vault → select `<VAULT>`
3. Settings → Files & Links → Default location for new notes → `4 - Notes`
4. Settings → Core Plugins → Templates → on; folder = `0 - Meta/Templates`
5. Settings → Hotkeys → Insert template → `Ctrl+T`
6. Community Plugins → install: **Dataview**, **Obsidian Linter**, **Templater**
7. Linter → YAML Timestamps:
   - Date Created: enable → key: `created`, format: `YYYY-MM-DD`
   - Date Modified: enable → key: `updated`, format: `YYYY-MM-DD`
   - Enable "Lint on save"
