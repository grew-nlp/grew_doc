+++
date = "2020-10-03T09:47:54+02:00"
title = "conllup"
Description = ""
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]

+++

# CoNLL-U Plus Format

**Grew** partially takes into account the [CoNLL-U Plus Format](https://universaldependencies.org/ext-format.html).

## Columns declaration

If some CoNLL file start with the initial line `# global.columns = …`, it is taken into account for the parsing of the file.

In order to specify the columns declaration to be used in output, the command line argument `-columns …` can be used.
For instance `-columns "ID FORM UPOS"` will produce a 3 columns output with token id, phonological form and universal POS.

 * by default, the [CoNLL-U format](../conllu) is used: it is equivalent to `-columns "ID FORM LEMMA UPOS XPOS FEATS HEAD DEPREL DEPS MISC"`
 * `-cupt` argument is a shortcut for: `-columns "ID FORM LEMMA UPOS XPOS FEATS HEAD DEPREL DEPS MISC PARSEME:MWE"`
 * `-semcor` argument is a shortcut for: `-columns "ID FORM LEMMA UPOS XPOS FEATS HEAD DEPREL DEPS MISC PARSEME:MWE FRSEMCOR:NOUN"`

## New columns

In addition to CoNLL-U columns, two column declarations are handled by **Grew**:

 * `PARSEME:MWE` see (http://multiword.sourceforge.net/cupt-format/) for details.
 * `FRSEMCOR:NOUN` see (https://frsemcor.github.io/FrSemCor)

In both cases, **Grew** interprets each annotated element as a new node with linked to all tokens it contains.

Below, an example of these annotations on **UD_French-Sequoia** (blue: MWE annotation of the Parseme project, orange: NE annotation of the Parseme project, green: semantic noun annotation of the FrSemCor project).

<div>
<img src="https://deep-sequoia.inria.fr/example/frwiki_50.1000_00754-ud.parseme.frsemcor.svg">
</div>

**NB**: other aspects of the CoNLL-U Plus Format, like cross-reference are not handled.