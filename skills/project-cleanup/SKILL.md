---
name: project-cleanup
description: Periodic fresh-eyes audit that keeps a project repo lean, current, and repeatable — inventory every file, verify what is actually live against tickets and PRs, archive completed iterations, delete dead weight, restructure around the durable process, and reset the state docs. Use when the user says review this project with fresh eyes, streamline the project, clean up or declutter the repo, there's a lot of bloat, reorganize these files, keep the project fresh, or wants the working process made repeatable; after a milestone lands (a POC ships, a phase completes, a big PR merges); or when a new contributor would have to read superseded documents to get oriented. Companion to file-cleanup (one document's text) and handoff (saving project state) — run project-cleanup when the problem is which files exist, not what they say.
---

# Project refresh

A working repo accumulates two kinds of material: the **durable process** (runbooks, methodologies, skills, reference facts) and the **iterations that ran through it** (round docs, drafts, exports, run output, meeting notes). Projects go stale when the two stay mixed — every file looks equally load-bearing, so a newcomer can't tell current from superseded, and the docs that matter drown in the ones that don't.

This skill is the periodic separation pass: keep the loop, archive the iterations, delete the debris. It complements `handoff` (which resets the present-state docs — you will call it in step 6); this skill decides the *inventory and structure*.

## Ground rules

- **Review first, then act — as two separate deliverables.** Present the full assessment and proposed dispositions before moving anything. The user redirects cheaply on a proposal and expensively on a done deed.
- **Verify aliveness against reality, not labels.** A file marked "draft" may be load-bearing (another doc defers to its methodology); a file that looks current may describe a merged branch. Check tickets, PRs, git dates, and cross-references before classifying anything.
- **Prefer reversible moves.** `git mv` to `archive/` preserves history and is cheap to undo. Reserve deletion for things that are regenerable (build artifacts, run output, generated files) or already captured in git history (applied patches, superseded snapshots). When unsure, archive.
- **Never commit on your own.** Make a clean snapshot commit of pre-existing work first *with the user's explicit permission*, so the refresh isn't tangled into a dirty tree — then leave the refresh itself uncommitted for review.

## The pass

**1. Survey as a newcomer.**
List the full tree (`git ls-files` + untracked), then follow the project's own stated entry path (CLAUDE.md → STATE.md → README, or whatever it prescribes) exactly as a new contributor would. Note where the path misleads: docs that self-describe as current but aren't, state files that have become chronicles, load-bearing files the path never mentions. The gap between "what the docs say to read" and "what you actually needed to read" is the core finding.

**2. Inventory and classify every file.**
Four buckets: **live** (the process, current state, active work), **live-but-misplaced** (methodology buried in a stale doc; a rule that belongs in a skill; a file sitting outside the directory that owns its kind), **historical** (completed iterations, superseded versions — provenance value only), **dead** (regenerable artifacts, applied patches, stale one-off status snippets, `.pyc`/`.DS_Store`). For anything ambiguous, check the external record: is the ticket closed? did the PR merge? does anything still reference it? A dependency from a live doc keeps a file live regardless of its age.

While classifying, run two directory checks:

- **Strays.** A directory exists for a kind of content, but instances of that kind sit elsewhere — a per-report file at the root, an experiment writeup in `notes/`. These are live-but-misplaced; their disposition is a `git mv` into the directory that owns them.
- **Ungrouped kinds.** Several files share one job and one implicit convention — same shape, same header pattern, same lifecycle — but no directory owns them. That is a directory waiting to be named: propose creating it, moving the files in, and writing its `CLAUDE.md` from the conventions the files already follow (job line on top, then naming, required sections, lifecycle). Two files is a coincidence; three with the same shape is a kind.

**3. Name the repeatable process.**
Read across the live docs for the loop the project actually runs — the stages of work and which doc governs each. Write or update the README to state it as a stage → doc table. This is the highest-leverage artifact of the whole pass: it replaces most onboarding reading, and it's the test for step 4 (everything is either part of the loop or an iteration of it).

**4. Execute dispositions.**
Delete the dead. `git mv` the historical into `archive/` (flat is fine; never edited, never cited as current). Restructure the live if the flat layout hides the process — e.g. `process/` for runbooks, one directory per artifact family. Extract the misplaced content into its proper home per the CLAUDE.md "Where things go" table, and move strays into the directories that own them. A directory created in this step is created whole: the files move in, its `CLAUDE.md` states the folder's job, audience (people, or working context), and conventions, and the root CLAUDE.md directories table gains its row — a folder without a stated job is just a place to lose files. Keep only the latest version of generated files in the working tree — git history holds the rest.

While in each surviving directory, audit its `CLAUDE.md` against its contents: conventions no file follows anymore, file kinds that no longer exist, files inside that don't match the folder's declared job. Fix the convention or fix the files — a folder file that describes a folder that no longer exists that way misleads every future write into it. A directory that has emptied out loses its folder, its `CLAUDE.md`, and its table row together.

**5. Repair the seams.**
- **Cross-references:** grep for every moved filename across the remaining live files (including `.claude/skills/` and scripts) and update paths. Then *verify* every markdown link resolves — don't trust the sweep. Leave references inside append-only history files (`LOG.md`, decision logs) as-is; they describe the past.
- **Git hygiene:** untrack committed artifacts (`__pycache__`, `.DS_Store`) and gitignore them; track valuable untracked files (skills, hooks, scripts — often the most load-bearing and least protected things in the repo).
- **Working data vs. record:** for each data directory, ask where the source of truth is. If it's an external system, the local copies are working documents — untrack them, ignore the directory, and have the relevant runbook say where durable conclusions must be recorded instead. State any reproducibility caveat honestly (e.g. the external system expires old data).
- **Broken tooling:** if you touched any script's inputs or location, run it and diff its output against the previous version. Fix what the run exposes.

**6. Reset the state docs.**
Run `handoff` (or its manual pass) so STATE.md and the other present-state docs are rewritten clean. While doing it, collect every dangling thread the survey surfaced — open PRs, unmerged old branches, undecided proposals, pending manual chores — into STATE.md's open-threads section, each with an owner. A refresh that leaves threads undecidable for the next reader has only moved the bloat around.

**7. Log the why, report, and stop.**
One entry in the project's history home (`LOG.md` or decision log): what was retired, the new structure, and the reasoning — future sessions need to know the reorganization was deliberate. Then report to the user: disposition summary (moved / deleted / restructured, with counts), the seams repaired, the open threads needing their decision, and what remains theirs (the commit, any tickets to file). Do not commit.

## What not to do

- Do not edit files in `archive/` or rewrite append-only history files — provenance only survives untouched.
- Do not delete data whose source of truth you haven't identified, and never data that can't be regenerated.
- Do not fold the refresh into feature work or mix it into an existing dirty tree — one coherent, reviewable diff.
- Do not preserve a document out of politeness. If its useful content has migrated elsewhere and its remainder misleads, archiving it *is* the respectful disposition; say why in the log entry.
