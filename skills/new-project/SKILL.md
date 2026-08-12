---
name: new-project
description: Scaffold and set up a new Claude project in the current directory — create the core documents (CLAUDE.md, BRIEF.md, STATE.md, LOG.md, DECISIONS.md) from the plugin's templates, interview the user to fill in the brief and working conventions, settle the git convention, and trim what the project will not use. Use when the user says new project, start a project, scaffold a project here, or initialize the project structure in an empty or nearly empty directory. For a repo that already has real content, use setup-project instead.
---

# New project

Set up a new project in the current directory. The scaffolds ship with this plugin; every document starts as a template with angle-bracket placeholders, and this interview fills them in.

If the directory already has real content — code, documents, its own history — stop and use **setup-project** instead; this skill is for empty or nearly empty directories.

## 1. Scaffold the documents

Copy every file from `${CLAUDE_PLUGIN_ROOT}/templates/` into the project root (including the dotfiles). Never overwrite: if a target file already exists, skip it and say so. If several already exist, this is probably a setup, not a new project — say that and switch.

No `.claude/` directory is created. The skills and the session-start hook come with the plugin; the project itself is pure markdown.

## 2. Ask, then write

Ask these as a short conversation — a few at a time, not a form. Use `AskUserQuestion` where the answer is a choice, plain questions where it is prose. Do not ask anything you can infer from the folder name or from files already present.

**For `BRIEF.md`:**
- What is wrong or missing today? (The problem, stated without reference to the solution.)
- Who is affected, who decides, who reviews? If nobody reviews it, say so — it changes how much rigor is worth spending.
- What does done look like, in terms someone outside could check?
- What constrains this? Deadlines, systems that cannot change, decisions already made elsewhere, data that does not exist.
- What is deliberately out of scope?

**For `CLAUDE.md`'s working conventions:**
- Which tools and data sources does this project actually use?
- Anything that needs human sign-off before it happens?
- Any convention you already know you will want followed?

## 3. Check git and settle the version-control convention

Run `git --version`.

**If git is not installed:** recommend installing it (macOS: `xcode-select --install`; Linux: the system package manager; Windows: git-scm.com) and say why it earns its place — commit history is what makes reverting safe, and `/handoff` uses it as a checkpoint boundary. Everything still works without it: if the user declines, record "No version control" under Working conventions and skip the rest of this step.

**If git is installed** but this folder is not a repo (`git rev-parse --is-inside-work-tree` fails), offer to run `git init` first. Then ask, with `AskUserQuestion`, how git should be used here:

- **Auto-commit** — for users who do not want to manage git themselves and just want version-control safety. Claude commits at natural checkpoints — after a coherent piece of work lands, and at every `/handoff` — with descriptive messages, and uses the history to revert when something goes wrong. The user never touches git.
- **Ask before committing** — for users who review and stage their own changes. Claude never commits on its own; it flags when the tree is at a natural commit point (every `/handoff` ends at one) and commits only when asked.

Record the choice as one line under Working conventions in `CLAUDE.md` — it is a rule about how to work here, so that section owns it.

## 4. Fill in the scaffolds

Rewrite `BRIEF.md` and the "Working conventions" section of `CLAUDE.md` with the answers. Replace every `<placeholder>`; delete any section that turns out not to apply rather than leaving it empty.

Leave `STATE.md`'s placeholders alone unless there is already work in flight — the first real handoff will fill it. Leave `DECISIONS.md`'s template entry alone too — the first real decision replaces it.

Set the date in `LOG.md`'s first entry to today.

## 5. Trim what this project does not need

The optional directories (`reference/`, `notes/`, `data/`, `outputs/`, `archive/`) are listed in `CLAUDE.md`'s directories table but not created. Create only the ones this project will use now, and remove the rows for the rest. An empty folder is a small lie about how the project is organized. If the project will not record decisions, delete `DECISIONS.md` and its row too.

Every directory you create gets its `CLAUDE.md` in the same step: one line stating the folder's job **and its audience**, then whatever conventions the interview surfaced — naming, required sections, lifecycle. If the user does not have conventions yet, the job-and-audience line alone is enough; conventions get added the first time two files in the folder need to agree on something.

The audience is one question, and usually not even that: **will people read these files, or are they working material for the assistant?** Deliverables someone reviews — specs, reports, briefs — are *for people*; data pulls, research notes, and records kept to work from are *working context*. Infer it from what the user says the folder is for, and only ask when genuinely unclear. Do not ask about style — the two profiles in `CLAUDE.md`'s "Writing for the audience" section are the defaults, and declaring the audience is what turns the right one on.

## 6. Check the job statements

Open each document you touched and confirm it still opens with a one-line statement of its job, and that the statement matches what you actually wrote underneath. That line is the contract every later edit gets judged against — it is the first thing anyone reads before adding to the file — so a file without an accurate one cannot be kept honest.

Then tell the user what you set up, and mention the three passes: `/handoff` before a break or at the end of a session, `/file-cleanup` when one document stops reading well, `/project-cleanup` every few weeks when the question is which files should exist at all.
