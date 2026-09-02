---
name: update-project
description: Sync an existing project's conventions to the plugin's current templates after a plugin update — port new or changed rules into the project's CLAUDE.md by meaning, preserving everything project-specific. Use when the user says update this project, sync the conventions, bring this project up to date with the template, the plugin updated, or port the new conventions here. For a repo missing the documents entirely, use setup-project; for one document that reads badly, use file-cleanup.
---

# Update project

The plugin's templates evolve with each release; a project scaffolded earlier is a snapshot. The skills and hooks update themselves through the plugin, but the conventions written into the project's own `CLAUDE.md` do not — and they are the part that does the daily work. This pass ports convention changes forward without touching anything the project made its own.

It is a **reading** task, the same as every maintenance pass here: two documents compared by meaning, not a diff applied by position.

## Ground rules

- **Conventions move; content never does.** `STATE.md`, `BRIEF.md`, `LOG.md`, `DECISIONS.md`, and every working file are out of scope. So are the project-specific parts of `CLAUDE.md`: the Working conventions section, routing-table rows pointed at the project's own homes, directory tables and their folders' `CLAUDE.md` files.
- **Deliberate divergence is respected.** A project that trimmed a home it does not use, reworded a rule to fit its domain, or points a role at its own file (`HANDOFF.md` doing `STATE.md`'s job) is not out of date. Out of date means a template rule is *absent or contradicted*, not restyled.
- **Port rules in the template's own words** unless the project already has a working variant of that rule — then leave the variant alone.
- **Headless or unattended, every change is a proposal.** Apply only in an interactive session, after showing the list.

## The pass

**1. Read the canon.**

`${CLAUDE_PLUGIN_ROOT}/templates/CLAUDE.md` is the current conventions. `${CLAUDE_PLUGIN_ROOT}/RELEASE-NOTES.md` says what changed recently, newest first — useful for orienting, but the template is the ground truth; port from it, not from the notes.

**2. Read the project.**

The root `CLAUDE.md` (or `AGENTS.md`, when `CLAUDE.md` is an import line — edit the file that holds the content), plus the one-line job statements of the core documents. Directory `CLAUDE.md` files only if a template change concerns directory conventions.

**3. Compare rule by rule, by meaning.**

For each rule, section, and discipline in the template, classify its counterpart in the project:

- **Present** — same rule, any wording. Nothing to do.
- **Missing** — the template says it, the project doesn't. Candidate to add.
- **Trimmed** — the project deliberately dropped it (an unused home, an irrelevant section). Leave it out; mention it only if the rule changed in a way that makes it newly relevant.
- **Contradicted** — the project's rule now conflicts with the template's. Not yours to resolve: present both and let the user decide. Their variant may be the better rule for this project.

**4. Propose the delta.**

A short numbered list: each missing rule quoted, the section it would join, and one line on why it exists (the release notes usually say). Nothing else — no reformatting of sections that pass, no rewriting for style.

**5. Apply what is approved.**

Insert each rule into the matching section of the project's file, in the template's words. Then append one line to the project's history file: conventions synced to the current plugin version, listing what was added.

## What not to do

- Do not overwrite the project's `CLAUDE.md` with the template, or "regenerate" it. This pass adds and flags; it does not replace.
- Do not restore trimmed sections or homes without asking — trimming is the system working as designed.
- Do not restyle, reorder, or tighten sections that already pass. That is **file-cleanup**, on request.
- Do not touch scaffold placeholders in a project that never filled them; note them in the report instead.
- Do not chain into other passes uninvited. If the comparison surfaces drifted documents or dead files, name them and point at **file-cleanup** or **project-cleanup**.
