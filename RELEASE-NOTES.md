# Release notes

**This file's job: say what changed for users in each shipped version, newest first, in plain language. Every version bump gets an entry in the same edit.**

## 0.1.0 — 2026-08-07

Initial release.

- Five skills: `new-project` (scaffold and interview an empty directory into a project), `adopt-project` (add the structure to an existing repo without touching anything), `handoff` (save state at session end, ending at a commit boundary), `file-cleanup` (rewrite one drifted document), and `project-cleanup` (audit which files should exist).
- A SessionStart hook that opens every session by printing the project's `STATE.md` — silent in repos that don't have one.
- Five document templates: `CLAUDE.md`, `BRIEF.md`, `STATE.md`, `LOG.md`, `DECISIONS.md`, each opening with a one-line statement of its job.
- Audience-aware writing, with no configuration: documents for people lead with the answer and stay scannable; working-context documents optimize for completeness and retrieval. Each directory declares its audience in its `CLAUDE.md`.
- Projects carry no machinery — no `.claude/` directory; everything ships with the plugin.
- The repo is its own marketplace: `/plugin marketplace add jefflanzi/project-helper`.
