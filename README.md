# Project Helper

A Claude Code plugin for projects you work on with an AI agent — product work, analysis, research, code. It exists to solve one specific failure: **documents that get stitched together over time.**

You know the shape of it. A file that started clean picks up a correction, then a caveat on the correction, then a note to double-check the caveat. Nothing is ever deleted, only annotated. Six weeks later the document is three times longer and you trust none of it.

## The idea

Two rules do all the work.

**Every document declares its job in one sentence, at the top.** The bar is not "is this file short enough." It is *does every line serve that one job, stated as what is true now?* A long list of reference IDs can be perfect. A short status file narrating what you believed last month is not.

**Present-state documents are rewritten, never appended.** This is the part that actually works. A regenerated document cannot be stitched together, because stitching requires keeping the old text around. So append-only writing is confined to two files — `LOG.md` for what happened, `DECISIONS.md` for what was settled — and everything else gets rewritten. History has a home, which is what makes deleting from the other files safe.

## Install

```bash
claude
```

```
/plugin marketplace add jefflanzi/project-helper
/plugin install project-helper@project-helper
```

Working from a local clone instead, add the marketplace by path: `/plugin marketplace add /path/to/project-helper`.

Then, in any empty directory, say **"set this up as a new project"** (or run `/project-helper:new-project`) and answer a few questions. In a repo that already has content, say **"adopt this project"** instead. That is the whole setup — no cloning, no copying.

Updates ship through the plugin: `/plugin update project-helper`, and every project picks up the new version at once.

## What a project looks like

Five markdown files. No `.claude/` directory, no scripts, no configuration — the machinery lives in the plugin, the project is pure content.

| File | Its job |
|---|---|
| `CLAUDE.md` | Where each kind of content lives, and how to work here |
| `BRIEF.md` | Why the project exists and what done looks like |
| `STATE.md` | Where you left off, right now |
| `LOG.md` | What happened, dated, newest first |
| `DECISIONS.md` | Settled choices and their reasoning, ADR-style, newest first |

Plus optional directories you add only when you need them: `reference/`, `notes/`, `data/`, `outputs/`, `archive/` — or any folder your project invents. A directory is for a *kind* of content that recurs: the files inside share one job and one set of conventions, with many iterations of the thing (per-dashboard build records, per-experiment writeups, weekly reports). Each directory carries its own `CLAUDE.md` — the folder's job statement plus its file conventions — so folder-level structure lives with the folder instead of bloating the root file. Claude Code loads these lazily, only when working in that folder, which keeps the default context small no matter how many directories a project grows.

Documents are written differently for their two possible readers, and the structure says which is which. Files **for people** — briefs, specs, reports — lead with the answer, prefer bullets and tables over paragraphs, and follow "less is more": a reader retains what they can process in one sitting. Files that are **working context** — notes, data pulls, research the assistant works from — optimize for completeness and retrieval instead: exact values, no personality, as long as they need to be. Each directory's `CLAUDE.md` declares its folder's audience; conversation itself follows the for-people rules. This is opinionated on purpose — there is nothing to configure, and the defaults are the product.

The instructions file is `CLAUDE.md` at every level — the root and each directory use the same name, and Claude Code loads all of them natively. If you also work with [AGENTS.md-aware tools](https://agents.md), keep your content in `AGENTS.md` and make `CLAUDE.md` a one-line `@AGENTS.md` import — `adopt-project` sets an existing repo up that way automatically.

Every one of those files opens with a one-line statement of its job. That line is the contract — it sits at the top of the file, so it is in front of you at the moment you edit it, which is the moment that decides whether the file stays concise.

## What the plugin does

### The skills

| Skill | What it does |
|---|---|
| `new-project` | Scaffolds an empty directory and runs the setup interview: fills `BRIEF.md` and `CLAUDE.md`'s working conventions, checks that git is installed and asks how it should be used (auto-commit at checkpoints, or ask before committing), trims the homes the project will not use. |
| `adopt-project` | Setup for an existing repo. Adds the missing documents without touching anything already there, then offers the optional `project-cleanup` reshape — the step where files actually move. |
| `handoff` | The session-end pass. Saves where the project stands so the next session — yours, another tool's, or another person's — can resume cold: rewrites `STATE.md` from scratch, logs the session to `LOG.md`, re-aligns any document that has drifted from its job, and ends at a commit boundary — committing itself or handing the clean tree to you, per the git convention chosen at setup. |
| `file-cleanup` | The one-file pass. Rewrites a single document so every line serves the file's stated job, moving displaced content to the files that own it. |
| `project-cleanup` | The periodic deeper pass. A fresh-eyes audit of which files should exist: archives completed iterations, deletes dead weight, restructures around the durable process. |

Invoke them by name (`/project-helper:handoff`) or just say it — "wrap up", "clean up this file", "where did we leave off".

The skills are the judgment passes. The continuous discipline is the **editing rules** in `CLAUDE.md`, which apply to every edit: update in place rather than prepending; every addition implies a deletion; what you just did is not the state. Documents do not bloat in one bad session — they bloat one reasonable-looking addition at a time, so the guidance has to be present continuously rather than at cleanup time.

### The hook

The plugin ships one SessionStart hook: at every session start — including resume, `/clear`, and after context compaction — it prints the project's `STATE.md` into context, so every session opens knowing where the project left off. It self-gates on `STATE.md` existing, so it is silent in every other repo.

This is the only automation, deliberately: the hook makes sure the state gets *read*; keeping the state worth reading is judgment work, which is what the editing rules and skills are for.

## Living with it

Most sessions you will not notice it. A session opens with the current state; that is the whole footprint.

Run `handoff` before a break, before switching tools, or at the end of a session. Run `file-cleanup` when one document stops reading well. Run `project-cleanup` every few weeks, or after a phase lands.

Nothing in a project depends on any language, framework, or vendor. Git is recommended but optional — setup checks for it and asks how you want it used; without it everything still works, you just lose the revert safety net and the handoff commit boundary.

## This repo

This repo is both the plugin and its own marketplace: the skills, the hook, the document templates, and both manifests in `.claude-plugin/`. Each commit here is one release, tagged with its version — development happens in a private working repo, and what ships is the snapshot you're looking at. What changed in each version is in `RELEASE-NOTES.md`; installed copies pick releases up via `/plugin update`. MIT licensed. Feedback and bug reports: GitHub issues.

## A note on what is deliberately missing

There are no line limits, no metadata headers, no automated prose checker, and no document inventory tool. All four were built, tried, and cut.

**Line limits** measure the wrong thing. Length is a symptom, not the disease, and a cap punishes documents that are legitimately long.

**Metadata headers** like `updated: 2026-08-04` duplicate what the filesystem already knows. Hand-maintained fields rot and then lie, which is precisely the problem this system exists to prevent.

**An automated prose checker** was the most tempting and the most wrong. An earlier version shipped one — a list of phrases that signal a patched document (`previously`, `re-verify`, `earlier version`), plus a duplicate-sentence matcher. Tried against a real project it caught four of six defects, missed the worst one entirely, and fired nine false positives from a single rule. Every miss got fixed by appending another phrase, which is fitting the tool to the sample. A code linter can aim for completeness because syntax is finite; prose is not, and a checker reporting "clean" on a document that has quietly drifted is worse than no checker, because it launders a judgment call as a verdict.

**An inventory script** reporting length, age, and growth per file went the same way, for a simpler reason: a reader can see all of that by opening the files, and reporting numbers is not the same as noticing a problem.

The case that settled it: a real project's status file reached 53,879 bytes, almost all of it inside a **single line** that began as `**Last updated:** <date>` and had five sessions of narrative prepended into its parenthetical, each ending "Prior context follows." No checker would flag that line — no hedge words, no dated headings, no duplication. It is one field doing the wrong job, enormously. Only reading it catches that, which is why the guidance lives in `CLAUDE.md` at edit time and the judgment lives in the maintenance skills.

What survived is the part that generalizes: **each file states its job, and a reader checks the file against it.** That reading is what the maintenance skills do.
