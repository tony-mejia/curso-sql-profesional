---
name: mejorar-apunte
description: "Trigger: mejorar apunte, aplicar plantilla, mejora este apunte, plantilla de apunte, formato de apunte. Mejora un apunte crudo del curso SQL con el molde TEMA + comentarios + bloque de cierre, sin modificar las líneas propias del alumno."
metadata:
  author: tony-mejia
  version: "1.1"
---

## Activation Contract

Activate when improving, formatting, or "applying the template" to a raw `.sql` note in this repository.

Not for: writing a lesson from scratch, fixing the learner's grammar, or normalizing indentation.

## Hard Rules

- The learner's lines are immutable. Never edit, complete, reorder, or fix typos in them. The surviving typos prove compliance.
- Only add: header, comments, section separators, closing block. Corrections go in an ADDED comment beside the line.
- Preserve the file's encoding and line endings. Check `file <path>` before and after: CRLF is not an error, and converting it is a modification.
- A note here may be untracked, so git cannot restore it. Back up the original outside the repo before rewriting.
- Header separator: exactly 79 characters (76 `=`).
- Write in neutral professional Spanish.
- Only use tables and columns present in the learner's material.
- Never present invented data as real. Mark it as an example.
- Never reformat indentation: tabs and spaces are already mixed.

## Decision Gates

| Situation | Action |
| --- | --- |
| Note has sequential steps | Add `-- n. TÍTULO` separators |
| Note has no steps | No separators |
| `Objetivo: ...` fits the header slot | Use it |
| An explanation or the learner's own note fits better | Use that instead |
| A statement is wrong or incomplete | Correct it in an added comment; leave the line |
| A statement is right but easy to misread | Clarify it in an added comment; do not call it wrong |
| SQL cannot run (missing table or schema) | Comment it with `/* */` |
| Topic warrants a modern technique the course does not cover | Add a closing-block section with it; report which and why |
| Topic does not warrant it | Do not add it |
| Closing block title | Adapt it to the topic; never copy one blindly |

## Execution Steps

1. Back up the original outside the repo (the script's default path) and record `file <path>`.
2. Read `assets/plantilla.sql` for the skeleton.
3. Read the target note; separate the learner's own lines (first person, `#`, typos) from the rest.
4. Add the header, comments where they help, and the closing block with a topic-adapted title.
5. Verify before reporting: `bash assets/verifica-apunte.sh "<path>"`. It checks every learner line byte-identical, zero content lines deleted, separators at 79 characters, and line endings. Never report the task as done while it fails.
6. Commit only when asked. One file per commit: `git add -- "<path>"`, confirm `git diff --cached --name-only` lists exactly one file, then `docs(<carpeta>): <tema>` with no body. Full convention with examples: `references/molde-verificado.md`.

## Output Contract

Return: files modified; what was added, one line each; which technique went into the closing block and why, or `none`; the verification result; unresolved ambiguity.

## References

- `assets/plantilla.sql` — the reusable skeleton.
- `references/molde-verificado.md` — measured evidence and the no-invent list.
