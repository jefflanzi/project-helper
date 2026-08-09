---
name: adopt-project
description: Bring the project-helper structure into an existing repo without touching what is already there — create the missing core documents (CLAUDE.md, BRIEF.md, STATE.md, LOG.md, DECISIONS.md) from the plugin's templates and orient them to the project. Strictly additive; ends by offering an optional project-cleanup with an explicit warning. Use when the user says adopt this project, set up the project doc structure here, retrofit this repo, add STATE and LOG to this repo, bring this project under project-helper, or asks for the project structure in a repo that already has content.
---

# Adopt project

An existing repo, with its own files and history, gets the project-helper structure added around what is already there. (For an empty directory, **new-project** is the right skill.)

**The adopt pass is strictly additive.** It creates files that are missing and changes nothing that exists. Reshaping the existing content into the structure is a separate, explicitly-approved step at the end.

## Ground rules

- **Create only what is missing.** Never overwrite, move, rename, or delete an existing file — not even one that looks abandoned.
- **Collisions are reported, not resolved.** If a file the structure wants already exists, leave it alone, note it in the report, and propose the smallest merge. Apply a merge only with the user's explicit OK on that specific edit.
- **Every action is named in the report.** The user should be able to undo the whole adopt by deleting the listed files.

## The pass

**1. Survey the target repo.**

From the repo root, list which core documents already exist: `CLAUDE.md`, `AGENTS.md`, `BRIEF.md`, `STATE.md`, `LOG.md`, `DECISIONS.md`. Also note existing files that already play one of these roles under another name — a `TODO.md`, `NOTES.md`, `docs/decisions/`, a status section in the README. These are candidates for the later cleanup, not for this pass; they get mentioned in the report only. If the repo carries stale copies of this plugin's skills under `.claude/skills/` (from a pre-plugin install), point them out as cleanup candidates — the plugin's versions are the live ones.

**2. Create the missing pieces.**

Copy whatever the survey found absent from `${CLAUDE_PLUGIN_ROOT}/templates/`. The skills and the session-start hook come with the plugin, so nothing is installed into the repo — no `.claude/` directory is needed. Handle the common collisions:

- **`CLAUDE.md` already exists:** do not overwrite. Propose appending the template's "Where things go" tables, directory conventions, and editing rules as a new section, with permission; otherwise leave it and report.
- **`AGENTS.md` exists (another tool's convention):** leave it untouched. Create `CLAUDE.md` as a one-line `@AGENTS.md` import so their cross-tool setup keeps working, and propose adding the structure section to their `AGENTS.md`, with permission.
- **`README.md`:** never created and never edited — the target repo's README is its own.

**3. Orient the scaffolds.**

- **`BRIEF.md`:** draft it from what the repo already says about itself — README, docs, recent git history — then confirm the draft with the user and fill in what only they know (who decides, what done looks like, what is out of scope).
- **`CLAUDE.md` working conventions:** ask, as `new-project` does — tools, data sources, what needs human sign-off, and the git convention (auto-commit at checkpoints, or ask before committing). Check `git --version` first; if git is missing, recommend installing it and record "No version control" instead. Existing repos usually have their own git habits — default the question toward ask-before-committing.
- **`STATE.md`:** fill from what the user says is currently in flight; if nothing is offered, leave the placeholders for the first real handoff.
- **`LOG.md`:** date the first entry today: "Adopted the project-helper structure into an existing repo."
- **Routing table rows:** where the survey found an existing file already doing a job (their `docs/decisions/` for `DECISIONS.md`, say), point the row at the existing home rather than creating a competing one — the tables should describe this repo, not the defaults.
- **Existing directories of recurring content** (per-report folders, per-experiment writeups, meeting notes) belong in the directories table, and each is a candidate for its own `CLAUDE.md` — read a few of the files, draft the job line and the conventions they already follow implicitly, and propose it. Classify the audience from the files themselves: a spec or report someone reviews is *for people*; data pulls, meeting notes, and research the assistant works from are *working context*. Declare it in the job line — that selects which of the root file's two writing profiles governs the folder. Additive, like everything else in this pass.

**4. Report.**

Three lists: created, skipped because it already exists, and proposed merges awaiting a yes. Plus the role-overlap candidates from step 1.

**5. Offer the reshape — with the warning.**

The adopt was additive, so the repo's existing content is still wherever it was: status buried in the README, decisions in old docs, dead files alongside live ones. Offer to run **project-cleanup** to pull the repo into the structure, and warn plainly: *that pass proposes moving files into `archive/`, deleting dead ones, and restructuring folders — it presents its full plan for review before touching anything, but it is the step where files move and some get deleted.* Run it only on an explicit yes, as its own pass.

## What not to do

- Do not move, rename, or delete anything, no matter how clearly it belongs elsewhere — that is project-cleanup's job, after its own review.
- Do not rewrite the target's README or any existing document to mention the new structure; propose such edits and wait.
- Do not fold a cleanup into the adopt because the user said "set this up and tidy it" in one breath — confirm the destructive half separately, after the additive half is done and reported.
- Do not create optional directories (`reference/`, `notes/`, `data/`, `outputs/`, `archive/`). They appear when something needs them, each with its `CLAUDE.md`.
