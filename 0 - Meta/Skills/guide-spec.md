---
created: 2026-04-08
updated: 2026-04-08
type: skill
status: stable
---
Tags: [[guides]] [[planning]]

# Creating a Guide Spec

## Purpose

Create a design spec + implementation plan for a new content guide. Adapts the superpowers `writing-plans` pattern for content generation rather than code. Produces high-quality, phased plans with per-file source mappings, review gates, and a stub tracker for gaps.

## Prerequisites

- Superpowers plugin installed (`superpowers:brainstorming`, `superpowers:writing-plans`)
- Source material scraped into `2 - Sources/<topic>/`
- `0 - Meta/Templates/guide-template.md` available

## Steps

### Step 1: Brainstorm → Design Spec

Invoke `superpowers:brainstorming` with this prompt:

> "I want to create a comprehensive guide for [Software Name]. Source material is scraped in `2 - Sources/[topic]/`. Read vault CLAUDE.md for file conventions. The guide should serve as both a tutorial (linear read) and a reference (jump to any section). I need a design spec first."

The design spec goes in `0 - Meta/Specs/Ongoing/YYYY-MM-DD-[topic]-guide-design.md` and must include:

- **Goal** — what the guide covers and who it is for
- **Design decisions table** — structure choice, scope, content approach, gap-tracking strategy
- **File structure** — complete list of guide files with folder organisation under `6 - Guides/[Topic]/`
- **Content outline per file** — bullet points of what each file must cover (this anchors the source mapping)

### Step 2: Implementation Plan

Invoke `superpowers:writing-plans` with the design spec in context. Explicitly tell it this is a content-generation plan, not a code plan, and paste the Standard Per-File Workflow below into the prompt.

**Standard Per-File Workflow** (paste verbatim into the writing-plans prompt):

```
Every guide file follows this workflow:
- Read the spec content outline for this file in the design spec
- Read the listed primary source page(s) from 2 - Sources/<topic>/
- If a primary source is a stub or disambiguation page, search the folder for related slugs and read those too
- Synthesize into clean guide prose — rewrite in tutorial/reference voice, do not transcribe verbatim; preserve useful tables
- Write the file using guide-template.md frontmatter
- Insert <!-- TODO: [[<topic>-guide-stubs]] --> inline at any content gap
- Append each gap to 0 - Meta/Todo/Ongoing/<topic>-guide-stubs.md
```

**Implementation plan structure the agent should produce:**

- **Task 0 — Setup:** create `0 - Meta/Todo/Ongoing/<topic>-guide-stubs.md`
- **Tasks 1–N:** one task per guide file; each task lists primary + secondary source slugs explicitly
- **Commit tasks:** after each logical section (not after every file), using:
  ```bash
  bash "<vault-root>/0 - Meta/Hooks/commit-vault.sh" "Add <topic> guide: <section name>"
  ```
- **REVIEW GATE tasks:** after each section — pause for user review before proceeding

**Plan header must include:**

```
> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task.
```

### Step 3: Execute

Use `superpowers:subagent-driven-development` (recommended) or `superpowers:executing-plans` to run the plan.

## Notes / Gotchas

- `writing-plans` is code-focused by default — you must explicitly provide the Standard Per-File Workflow and say "this is content generation, not code"
- Source slug mapping (which docs feed which guide files) is the hardest part of the design spec — invest time here; a weak mapping produces a weak plan
- REVIEW GATE tasks go between sections, not between individual files — too many gates stalls execution
- Never leave content gaps as prose TODOs — use the `<!-- TODO: [[stub-tracker]] -->` comment pattern so guide files stay clean
- One file per task — not one section, not one folder

## Reference

- `0 - Meta/Templates/guide-template.md` — frontmatter for guide files
- `0 - Meta/Templates/skill-template.md` — frontmatter for skill files
- Superpowers: `superpowers:brainstorming`, `superpowers:writing-plans`, `superpowers:subagent-driven-development`
