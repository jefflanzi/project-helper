# Release notes

**This file's job: say what changed for users in each shipped version, newest first, in plain language. Every version bump gets an entry in the same edit.**

## 0.3.0 — 2026-08-31

- **You get told when the conventions move.** In Claude Code, the session-start hook mentions — once per release, per project, never on first contact — that the plugin updated and `update-project` can port the changes. On every surface, `handoff` now ends by checking the plugin's release notes against the project and adds one line to its summary when the conventions have moved. Neither runs anything for you.
- **Setting up around existing files got safer.** Three eval-caught regressions hardened the setup skills: existing files now explicitly stay where they are during setup (the routing tables govern *new* content — filing existing files is `project-cleanup`'s job), `setup-project`'s merges stay proposals in headless runs since nobody can approve them, and `new-project` now checks the directory first and scopes its trim step strictly to files it scaffolded itself.
- **New skill: `update-project`.** Plugin updates move the skills and hooks, but the conventions written into a project's `CLAUDE.md` at scaffold time stay frozen. This pass compares them to the current template rule by rule — by meaning, not diff — and ports what is missing in the template's words, preserving your project-specific conventions, respecting sections you deliberately trimmed, and flagging genuine conflicts for you to decide. Run it in each project after a plugin update.
- **Hook behaviors get prose twins in the template, so Cowork keeps up.** Cowork injects a project's `CLAUDE.md` but never runs plugin hooks, so the template now carries both behaviors as instructions: treat `STATE.md` as claims to spot-check against the project (the SessionStart hook's output says the same), and record durable changes as you go instead of saving them for a handoff (the checkpoint nudge in prose). Model-followed rather than guaranteed, but every surface that loads `CLAUDE.md` gets them.
- **Checkpoint nudges for long sessions.** A new Stop hook keeps `STATE.md` and `LOG.md` from going stale when a session never reaches a handoff. In long sessions it periodically (default: at most once per 10 turns *and* 15 minutes, per session) asks Claude one question: did this stretch settle a decision, change direction, rule something out, or complete a milestone that the documents don't reflect? If yes, Claude records it in a few lines; if no, nothing happens. Like the SessionStart hook, it is silent in projects without a `STATE.md`. Tune with `PROJECT_HELPER_CHECKPOINT_TURNS` / `PROJECT_HELPER_CHECKPOINT_MINUTES`, or disable with `PROJECT_HELPER_CHECKPOINT=off`. Note: Claude Code only — Cowork does not currently run plugin hooks.
- **Marketplace entry has a description.** `marketplace.json` previously shipped without one, so the marketplace listing rendered nameless.
- **Corrected update instructions.** The README now says to refresh the marketplace before updating the plugin — without that, `/plugin update` can quietly reinstall the version you already have.

## 0.2.2 — 2026-08-27

- **Shared output links only to what the audience can open.** The writing-for-people profile (template `CLAUDE.md`, mirrored in the README) now says: anything shared beyond the machine — an artifact, a Slack or Notion post, an email — never links to or cites local working files. Link to Notion, Linear, GitHub, or a published artifact instead, pushing the content to one of those homes first when it lives nowhere else. `file-cleanup` now also replaces local-file references when tightening a shared document.

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
