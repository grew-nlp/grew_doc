+++
date = "2020-10-03T09:47:54+02:00"
title = "conllup"
Description = ""
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]

+++

# CoNLL-U Plus Format

[:new: 1.4] **Grew** partially takes into account the [CoNLL-U Plus Format](https://universaldependencies.org/ext-format.html).

## Columns declaration

If some CoNLL file start with the initial line `# global.columns = …`, it is taken into account for the parsing of the file.

**Grew** handles 3 specific declarations for CoNLL-like output

 1. by default, CoNlL-U format: `# global.columns = ID FORM LEMMA UPOS XPOS FEATS HEAD DEPREL DEPS MISC`
 1. with `-cupt` argument: `# global.columns = ID FORM LEMMA UPOS XPOS FEATS HEAD DEPREL DEPS MISC PARSEME:MWE`
 1. with `-semcor` argument: `# global.columns = ID FORM LEMMA UPOS XPOS FEATS HEAD DEPREL DEPS MISC PARSEME:MWE FRSEMCOR:NOUN`

## New columns

Two new column declarations are handled by **Grew** 1.4:

 * `PARSEME:MWE` see (http://multiword.sourceforge.net/cupt-format/) for details.
 * `FRSEMCOR:NOUN` see (https://frsemcor.github.io/FrSemCor)

In both cases, **Grew** interprets each annotated element as a new node with linked to all tokens it contains.

Below, an example of these annotations on **UD_French-Sequoia** (blue: MWE annotation of the Parseme project, orange: NE annotation of the Parseme project, green: semantic noun annotation of the FrSemCor project).

<div>
<img src="https://deep-sequoia.inria.fr/example/frwiki_50.1000_00754-ud.parseme.frsemcor.svg"/>
</div>

**NB**: other aspects of the CoNLL-U Plus Format, like cross-reference are not handled.