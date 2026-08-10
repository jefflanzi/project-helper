# Project instructions

**This file's job: say where each kind of content lives and how to work here. It names things; it does not contain them.**

Do not put facts, status, decisions, or findings in this file. Every one of those has an owner below. A fact written here gets loaded into every session forever and drifts out of sync with the copy that lives in its real home.

## Read at the start of every session, in this order

1. **`STATE.md`** — where we left off. Active focus, next actions, what needs a human, what is ruled out.
2. **`BRIEF.md`** — why this project exists and what done looks like. Read once; it rarely changes.

Read `LOG.md` only when you need history. It is long by design. Search it; do not load it.

## Where things go

**Core files** — single documents, one job each:

| Content | Home | Discipline |
|---|---|---|
| Current status, next actions, open questions | `STATE.md` | Rewritten from scratch each time |
| What happened, dated | `LOG.md` | Append-only, newest first |
| Why this project exists, scope, success criteria | `BRIEF.md` | Near-static |
| A settled choice and its reasoning | `DECISIONS.md` | ADR entries, newest first; superseded in place, never deleted |
| High-level overview of the system — files, disciplines, skills | `README.md` | Updated in the same edit that changes a convention or skill |

**Directories** — for kinds of content that recur. A directory earns its place the same way a file does, one level up: the files inside share one declared job and one set of conventions, with many iterations or variations of that kind of thing. One-off content does not get a folder. A series the user declares recurring ("we'll do one weekly") has already earned it: create its directory — `CLAUDE.md`, table row, and all — at the first instance. A deliverable series never lives in `LOG.md`; the log records that an instance happened, the directory holds it.

| Content | Home | Discipline |
|---|---|---|
| Durable facts — IDs, glossary, access, schemas | `reference/` | Rewritten when a fact changes |
| Working scratch, hypotheses, dead ends | `notes/` | Free-form |
| Retired material kept for provenance | `archive/` | Never edited, never cited as current |

Anything not on this list gets a home before it gets written. A fact whose home does not exist yet gets that home created — `reference/` (with its `CLAUDE.md` and table row) or the document that owns its kind — never this file.

## Directory conventions

Every directory in the table carries its own `CLAUDE.md`: a one-line statement of the folder's job **and its audience — people, or working context** (see "Writing for the audience" below), then the conventions its files follow — naming, required sections, lifecycle. That file is where folder-level structure lives, so this file stays an index and the default context stays small.

- **Read the folder's `CLAUDE.md` before writing in the folder.** It loads automatically when files there are read, but not necessarily before a first write into the folder.
- **Folder files add local structure only.** They never restate or override the rules in this file — concatenated instructions that conflict get resolved arbitrarily, so the same fact must never live in both.
- **A folder's `CLAUDE.md` is a document like any other:** job statement on top, same editing rules, same maintenance passes.
- **Creating a directory means creating its `CLAUDE.md` in the same edit**, and adding a row to the table above.

## Writing for the audience

Every document serves one of two readers, and its home decides which: each directory's `CLAUDE.md` names the folder's audience; the core files above are working context, except `BRIEF.md` and `README.md`, which are written for people.

**For people** — deliverables, specs, briefs, reports; anything a person will read:
- Lead with the answer or recommendation. Supporting detail follows, for readers who want it.
- Prefer bullets, tables, and headings over paragraphs; short sentences over long ones.
- Less is more: a reader retains what they can process in one sitting. Include what changes their decision or next action; cut the rest.

**For working context** — notes, data pulls, research, records the assistant keeps to work from:
- Completeness beats brevity. These files load on demand, so length costs nothing until it costs accuracy.
- Purely informational: exact values, IDs, dates, and sources; no personality, no persuasion, no hedging — an unresolved fact is marked as an open question, not softened.
- Structure for retrieval: whatever headings and lists make a fact findable by someone searching, in whatever shape serves the content.

Replies in conversation follow the "for people" rules: answer first, concise, plainly structured.

## Editing these documents

Every document above opens with a one-line statement of its job. **Read that line before you write anything into the file.** What you are about to add either serves that job or belongs in a different file.

These rules apply to every edit, not to a periodic cleanup. Documents do not bloat in one bad session; they bloat one reasonable-looking addition at a time.

- **Update in place. Never prepend.** Find the sentence that is now wrong and rewrite it. Adding a newer statement above an older one, and leaving both, is the single most common way a short document becomes a long one.
- **Every addition implies a deletion.** After adding something, ask what it just made obsolete, and remove that. An edit that only grows a present-state file is usually a mistake.
- **What you just did is not the state.** A summary of this session belongs in `LOG.md`. `STATE.md` says where things stand now — not how they got there, and not what you accomplished getting them there.
- **Do not date-stamp inside a present-state file.** No "as of," no "(updated …)", no dated headings. If the fact needs a date to be true, it is history and belongs in `LOG.md`. Git already records when every line changed.
- **Say it once.** If the fact lives in another file, link. If it is already in this file, do not restate it at greater length further down.
- **Cut the scaffolding.** "It's worth noting that," "importantly," "as mentioned above," qualifiers stacked on qualifiers. If a sentence survives its own deletion, delete it.
- **Most edits should leave the file the same length or shorter.** Present-state documents describe a situation of roughly constant size. If one is steadily growing, it is accumulating history, duplicating something, or quietly taking on a second job.

## Maintenance passes

- **`/handoff`** before switching tools, before a break, or at the end of a session. Rewrites `STATE.md` from scratch, logs the session, re-aligns any working document that has drifted from its stated job, and ends at a commit boundary per the git convention below.
- **`/file-cleanup`** when one document stops reading cleanly. Rewrites that file against its job and moves displaced content to the files that own it.
- **`/project-cleanup`** every few weeks or after a phase lands, when the question is which files should exist rather than what they say.

Neither is a substitute for the rules above. A periodic pass reliably catches the one document that has become obviously unreadable, and walks straight past the three that are quietly growing.

## Working conventions

<Add project-specific conventions here: tools, data sources, review requirements, what needs human sign-off, and the git convention from setup — auto-commit at checkpoints, ask before committing, or no version control. Keep them to rules about how to work. Facts go in `reference/`.>
