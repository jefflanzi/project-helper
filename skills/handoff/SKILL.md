---
name: handoff
description: Save where the project stands so the next session — yours, another tool's, or another person's — can resume without re-establishing context. Rewrites STATE.md from scratch, logs the session, and re-aligns any working document that has drifted from its stated job. Use when wrapping up a work session, before switching between Claude Code and Cowork, before a break, or when the user says handoff, write a handoff, hand this off, checkpoint, wrap up, save state, tidy the docs, or where did we leave off. For tightening one bloated document, use file-cleanup instead.
---

# Handoff

A session ends. The next one — tomorrow's, another tool's, another person's — starts cold, and everything not written down is gone. This pass writes it down: where things stand, what comes next, what has been ruled out. And since it has every working document open anyway, it re-aligns whatever has drifted from its stated job.

It is a **reading** task. There is no script that finds the problem for you.

## The test

Every present-state document opens with a one-line statement of its job. That line is the contract.

For each file: **read the job statement, then read the file, then list everything in it that does not serve that job.** That list is the work.

Two questions sharpen it:

- *If I had to write this file today, from scratch, knowing only its job and what is currently true — would this sentence be in it?* If no, it is residue.
- *After reading the whole file, can I still state its job in one sentence?* If not, the file has taken on a second job and needs splitting.

## What drift looks like

- **Archaeology.** The file explains how it came to say what it says — what was believed before, what got corrected, what was reversed. Legitimate content, wrong file. It goes to the history file.
- **Hedges that never resolved.** "Worth double-checking," "may be out of date," "confirm before relying on this." Each one is an open question hiding in prose where nobody will act on it. Move it to `STATE.md` under Open questions, with an owner, or resolve it now.
- **A second job.** Status crept into a reference file; facts crept into the instructions file; a how-to grew a results log. Move the content to the file that owns it.
- **Restating.** The same fact stated in two files, or twice in one file at different lengths. Pick the owner, delete the copy, link.
- **Padding.** Three sentences doing one sentence's work. Qualifiers on qualifiers. Say it once, plainly.

## The pass

**1. Rewrite `STATE.md` from scratch.**

Not edit — rewrite. Read it, then write the file fresh from what you actually know: active focus, next actions, open questions with owners, ruled out. Never invent an owner — a question whose owner is not stated in the project's own documents or the conversation is marked "(owner unassigned)". Completed work is **deleted**; it goes to the history file in step 3.

**2. Rewrite every other file that failed the test.**

Write what is true now, in the present tense, serving only the stated job. If a file has drifted so far that its job statement no longer describes it, the fix is a decision, not a rewrite: either restate the job to match what the file has become, or split it. Say which you did and why.

Directories count. A folder's `CLAUDE.md` is a present-state document like the rest — apply the same test to any folder this session touched. If the session dropped a file outside the directory that owns its kind, move it now; if it left files that ignore their folder's conventions, or a pile that looks like it wants to become a directory, that restructure is **project-cleanup**'s call — put it in `STATE.md` as a next action, not something to improvise at handoff time.

**3. Append one entry to the history file** — `LOG.md`, or whatever this project uses.

Newest first, five lines or fewer. Anything deleted above that has lasting value lands here. This step is what makes deleting safe.

**4. Promote durable facts to `reference/`.**

Anything that has stopped being news and become a standing fact — an ID, a definition, a constraint — belongs in `reference/`, stated plainly.

**5. Check whether the plugin's conventions moved.**

Read the top entry of `${CLAUDE_PLUGIN_ROOT}/RELEASE-NOTES.md`. If its version is newer than the last "conventions synced" line in the history file — or no such line exists and the recent notes name template or convention changes this project's `CLAUDE.md` visibly lacks — add one line to the handoff summary offering **update-project**. One line only; do not run it as part of the handoff.

**6. End at a commit boundary.**

A handoff is the natural checkpoint: the documents are freshly true and the session's work is complete. If the project uses git, follow the convention recorded in `CLAUDE.md`'s working conventions:

- **Auto-commit:** commit everything from the session — the working files and the documents just rewritten — with the `LOG.md` entry as the commit message. One commit; the log entry and the commit describe the same checkpoint.
- **Ask before committing:** do not commit. Say that the tree is at a clean checkpoint and list what changed, so the user can review and commit on their own terms.

If no convention is recorded or the project has no git, skip this step.

## What not to do

- Do not add a "Recent changes" or "Updates" section to a present-state document. That is the history file.
- Do not add status fields, `last-updated` headers, or metadata frontmatter. The filesystem and git track that, and hand-maintained metadata goes stale and then misleads.
- Do not soften a deletion into a strikethrough or a note. If it is done, it leaves.
- Do not grow `CLAUDE.md`. It says where things live. Facts go in `reference/`, status in `STATE.md`, reasoning in the history file.
- Do not rewrite a file just because it is long. Length is not the defect; serving two jobs is.

For tightening a single document the user points at, use the **file-cleanup** skill. For deciding which files should exist at all — archiving finished work, deleting dead weight, reshaping the folders — use **project-cleanup**. Handoff saves the state of the whole project; file-cleanup fixes one file's text; project-cleanup decides which files there are.
