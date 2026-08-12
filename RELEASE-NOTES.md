# Release notes

**This file's job: say what changed for users in each shipped version, newest first, in plain language. Every version bump gets an entry in the same edit.**

## 0.2.1 — 2026-08-11

- **`adopt-project` renamed to `setup-project`.** Same skill, same behavior — the name reads more clearly for an existing repo that's getting the structure added. "Adopt this project" still works as a spoken trigger; the invoked name is `/project-helper:setup-project`.

## 0.2.0 — 2026-08-10

Four refinements from an autonomous test campaign (55 headless runs against synthetic and real repos).

- **Recurring series get a home on day one.** When you declare a report or deliverable recurring ("we'll do one weekly"), the template now says it gets its own directory — `CLAUDE.md` and all — at the first instance, and never lands in `LOG.md`. Previously each session improvised its own filing.
- **Homeless facts get a home, never `CLAUDE.md`.** The template now says what to do with a fact whose destination doesn't exist yet: create `reference/` or the owning document — instead of folding it into the instructions file.
- **`project-cleanup` proposes when nobody can approve.** In a headless or unattended run, every action — including small repairs — is now explicitly a proposal.
- **`handoff` never invents an owner.** An open question whose owner isn't stated in the project's documents or the conversation is marked unassigned instead of guessed.

## 0.1.0 — 2026-08-07

Initial release.

- Five skills: `new-project` (scaffold and interview an empty directory into a project), `adopt-project` (add the structure to an existing repo without touching anything), `handoff` (save state at session end, ending at a commit boundary), `file-cleanup` (rewrite one drifted document), and `project-cleanup` (audit which files should exist).
- A SessionStart hook that opens every session by printing the project's `STATE.md` — silent in repos that don't have one.
- Five document templates: `CLAUDE.md`, `BRIEF.md`, `STATE.md`, `LOG.md`, `DECISIONS.md`, each opening with a one-line statement of its job.
- Audience-aware writing, with no configuration: documents for people lead with the answer and stay scannable; working-context documents optimize for completeness and retrieval. Each directory declares its audience in its `CLAUDE.md`.
- Projects carry no machinery — no `.claude/` directory; everything ships with the plugin.
- The repo is its own marketplace: `/plugin marketplace add jefflanzi/project-helper`.
