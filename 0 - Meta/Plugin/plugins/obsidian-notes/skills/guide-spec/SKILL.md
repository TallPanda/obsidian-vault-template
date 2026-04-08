---
name: guide-spec
description: Use when the user wants to create a new content guide for software, games, or other complex systems. Orchestrates the full pipeline: brainstorm → design spec → implementation plan → execution. Triggers on "create a guide for", "guide spec for", "make a guide".
version: 1.0.0
---

# Guide Spec — Create a Content Guide

Orchestrates the full pipeline for creating a comprehensive content guide with per-file source mappings, review gates, and a stub tracker for gaps.

## On invocation — gather context

Ask the user:
1. What software or system is the guide for?
2. Where is the source material? (default: `2 - Sources/<topic>/`)
3. Is the source material already scraped, or does it need to be gathered first?

If source material is not yet present, stop and ask the user to scrape it first before proceeding.

## Step 1: Design Spec

Invoke `superpowers:brainstorming` with this prompt (fill in the blanks):

> "I want to create a comprehensive guide for [Software]. Source material is scraped in `2 - Sources/[topic]/`. Read vault CLAUDE.md for file conventions. The guide should serve as both a tutorial (linear read) and a reference (jump to any section). I need a design spec first."

The design spec saves to `0 - Meta/Specs/Ongoing/YYYY-MM-DD-[topic]-guide-design.md` and must include:
- **Goal** — what the guide covers and who it is for
- **Design decisions table** — structure, scope, content approach, gap-tracking strategy
- **File structure** — complete file list under `6 - Guides/[Topic]/`
- **Content outline per file** — bullets covering what each file must contain, with source slug mapping

**PAUSE after Step 1.** Present the design spec to the user and wait for approval before continuing.

## Step 2: Implementation Plan

With the approved design spec in context, invoke `superpowers:writing-plans`.

Tell writing-plans explicitly:
> "This is a content-generation plan, not a code plan. Use the Standard Per-File Workflow below in place of TDD steps."

Provide this Standard Per-File Workflow verbatim to writing-plans:

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

The implementation plan must produce:
- Plan header with `superpowers:subagent-driven-development` instruction
- Task 0: create `0 - Meta/Todo/Ongoing/<topic>-guide-stubs.md`
- One task per guide file, each listing primary + secondary source slugs explicitly
- Commit tasks after each section using `0 - Meta/Hooks/commit-vault.sh`
- REVIEW GATE tasks after each section — pause for user review before proceeding

**PAUSE after Step 2.** Present the implementation plan to the user and wait for approval before continuing.

## Step 3: Execute

With the approved implementation plan, invoke `superpowers:subagent-driven-development`.

After all tasks complete:
- Move the design spec to `0 - Meta/Specs/Completed/`
- Move the implementation plan to `0 - Meta/Specs/Completed/`
