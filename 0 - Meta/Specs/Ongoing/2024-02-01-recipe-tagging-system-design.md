# Recipe Tagging System — Design

**Status:** Ongoing
**Created:** 2024-02-01

## Context

Notes about cooking are accumulating across multiple topics (techniques, ingredients, science, history). The current tag set (`[[cooking]]`, `[[food-science]]`) is too broad — notes are hard to find by subtopic. Need a tagging taxonomy that's granular enough to be useful but not so fine-grained it becomes overhead.

## Approach

Use a two-level tag strategy:
- **Broad tags** (existing): `[[cooking]]`, `[[food-science]]`, `[[productivity]]`
- **Specific tags** (new): `[[fermentation]]`, `[[bread]]`, `[[preservation]]`, `[[flavour]]`

Specific tags are only created when three or more notes share the subtopic. This prevents premature taxonomy.

## Tag Files

New tags to create in `3 - Tags/`:
- `fermentation.md` — triggered by sourdough note + future fermentation notes
- `bread.md` — once a second bread note exists

## Verification

- [ ] All notes in `4 - Notes/` have at least one tag
- [ ] All tag wikilinks resolve to a file in `3 - Tags/`
- [ ] No orphaned tag files (tags with no linked notes)
