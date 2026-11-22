# Contributing a proof

One pull request proves one posted gap. The rules below are checked by a program. A pull
request that breaks one of them is refused, and the reason is the only reply.

## The pull request

1. It adds exactly one file and changes nothing else. No edits, no deletions, no renames, no
   second file.
2. The file is the one the desk named for your gap. Its path has the form
   `lean/PEqualNP/Outside/L_<gap>.lean`, with lower case letters, digits and underscores only.
3. It is a plain text file in UTF-8, at most 512 KiB. Not a link, not executable.
4. The gap must still be posted when the pull request is checked. If someone else's proof of
   the same gap was accepted earlier, the gap is closed.

## The file

1. Imports come at the top, one per line, in the plain form `import Some.Module`, with nothing
   else among them (no comments between or before them, no `public`, `meta` or `module`).
2. It may import only `Mathlib`, modules of Mathlib, and the project modules listed for the
   gap. Nothing else.
3. After the import lines, the word `import` may not appear anywhere in the file, comments
   included.
4. It declares one theorem, named after the module. For `lean/PEqualNP/Outside/L_gct_101.lean`
   that is `PEqualNP.Outside.L_gct_101`.
5. The theorem proves exactly the posted statement. A stronger, weaker or reworded statement is
   refused. If you think the statement is false or needs another hypothesis, do not change it:
   release the gap at the desk with `statement_seems_false` or `hypothesis_too_weak`.
6. No `sorry`. No axioms beyond `propext`, `Classical.choice`, `Quot.sound`. No
   `native_decide`.
7. Helper lemmas and helper definitions go inside the same file.

## How it is checked

1. A check runs on the pull request and prints a verdict. It is a quick answer for you. It is
   advisory.
2. A second check is started by the maintainers from the base branch. It takes your one file as
   data, reads the statement from the desk's public list, and runs the checker of the base
   branch. Its verdict is the one that counts.
3. On `ACCEPTED` the pull request is merged and the lemma is recorded as checked. Credit goes
   to the author of the pull request.

## What is not read

The description of a pull request is not read. Neither are its title, its comments or its
commit messages. Only the one file is used, and only the checker judges it. Put nothing there
that you need anyone to see.

## Words

A lemma here is "checked". Please do not describe a proof in any other terms in this
repository.
