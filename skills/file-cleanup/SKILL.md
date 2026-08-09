---
name: file-cleanup
description: Read one document with fresh eyes and rewrite it so every line serves the file's job, moving displaced content to the files that own it. Use when the user points at a single file and says clean up this file, this doc has gotten bloated, tighten this document, this file is hard to trust, or names a specific document that has grown long, repetitive, or layered with corrections — in any repo, even mid-task. Companion to project-cleanup, which audits the whole repo: run file-cleanup when the problem is one file's contents, project-cleanup when the problem is which files exist.
---

# File cleanup

Documents drift. Each pass over a file adds a clarification, a caveat, a note about what changed — and none of it gets removed, because removing text feels like losing information. After a dozen iterations the file is three times longer, says less clearly what it once said clearly, and has quietly taken on jobs that belong to other files.

This is the pass that undoes that, for one file. It is a **reading** task — no script finds the problem for you.

## The test

Find the file's job — the one sentence describing what a reader should come here for. Some projects state it as the file's opening line; if this file doesn't, infer it from the content and how the file is used. Then: **read the file and list everything in it that does not serve that job.** That list is the work.

Two questions sharpen it:

- *If I had to write this file today, from scratch, knowing only its job and what is currently true — would this sentence be in it?* If no, it is residue.
- *After reading the whole file, can I still state its job in one sentence?* If not, the file has taken on a second job and needs splitting, not just rewriting.

## Files inside a directory

If the file lives in a directory that has its own `CLAUDE.md` (or equivalent conventions file), **read that first — it is half the contract.** The file under cleanup is usually one instance of the folder's declared kind, so it is judged against two things: its own job, and the folder's conventions — naming, required sections, lifecycle. Not following the folder's conventions is drift, the same as not serving the job.

The folder's declared **audience** sets the direction of the cleanup. A document *for people* tightens toward less: lead with the answer, restructure paragraphs into bullets and tables, cut what the reader cannot use. A document that is *working context* tightens toward retrieval, not brevity: deduplicate and reorganize so facts are findable, but never cut facts, values, IDs, or sources to make it shorter — completeness is that document's job, and "shorter" is not an improvement.

The folder's `CLAUDE.md` can itself be the cleanup target. Its job is to state what the folder's files have in common; conventions no file follows anymore, or rules that restate the project's root instructions, are its residue. If the folder file and its files disagree, decide which is right — update the convention or fix the files — and say which you did.

## What drift looks like

- **Archaeology.** The file explains how it came to say what it says — what was believed before, what got corrected, what was reversed. Legitimate content, wrong file: it belongs in the project's history home (a log, a decision record, git).
- **Hedges that never resolved.** "Worth double-checking," "may be out of date," "confirm before relying on this." Each is an open question hiding in prose where nobody will act on it. Resolve it now, or move it somewhere it has an owner.
- **A second job.** Status crept into a reference file; facts crept into instructions; a how-to grew a results log. Move the content to the file that owns it.
- **Restating.** The same fact stated twice at different lengths, here or in another file. Pick the owner, delete the copy, link.
- **Padding.** Three sentences doing one sentence's work. Qualifiers on qualifiers. Say it once, plainly.

## The pass

1. **Rewrite, don't edit.** Write the file fresh against its job — and its folder's conventions, if it lives in one — present tense, from what is currently true. If no job statement existed, write the one you inferred as the one-line opener — it is the most durable thing the cleanup leaves behind, because it makes the next drift visible.
2. **Relocate, don't delete.** Displaced content moves to the file that owns it; deleted history with lasting value gets one entry in the project's history home (`LOG.md`, a decision log, or failing those, the commit message). This is what makes cutting safe.
3. **Repair the seams.** Anything that links to a section you removed or renamed gets updated. Grep for the filename and its heading anchors before calling it done.
4. **Report the diff honestly.** Say what moved where and what was dropped as residue, so the author can veto a cut cheaply.

## What not to do

- Do not add "Recent changes" sections, status fields, `last-updated` headers, or metadata frontmatter. The filesystem and git track that; hand-maintained metadata goes stale and then misleads.
- Do not soften a deletion into a strikethrough or an annotation. If it is done, it leaves.
- Do not rewrite a file just because it is long. Length is not the defect; serving two jobs is.
- Do not let one file's cleanup silently rewrite others — content moves are part of the deliverable, named in the report.

If the real problem is bigger than this file — stale siblings, finished work nobody archived, a layout that hides the process — that is a **project-cleanup** run, not a bigger file-cleanup.
