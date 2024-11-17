+++
title = "Rule gallery"
menu = "main"
+++

# Rule gallery

This page gives examples of rules that can be used either with ArboratorGrew and when writing more complex [GRS](../grs).

---

# Tokenisation


## Splitting a punctuation mark at the end of a token
This example below splits the tokenisation signs which were kept on the previous word.

{{< grew file="/static/doc/rule_gallery/tok_punct.grs" >}}

Note that the new punctuation is not attached. It should be attached manually after or with a rule like **TODO**.

{{< tryit "https://web.grew.fr/?corpus=https://grew.fr/doc/rule_gallery/tok_punct.conllu&grs=https://grew.fr/doc/rule_gallery/tok_punct_gw.grs" >}}

## Splitting a token in sub-tokens and adding a Multi-Word token

UD proposes a mechanism for dealing with difficult tokenisation examples (see [UD guidelines](https://universaldependencies.org/format.html#words-tokens-and-empty-nodes)).
This mechanism is called a Multi-Word Token (MWT).
The rule above shows how to split a token into sub tokens by adding a MWT to the structure.
The first example corresponds to the French contraction _au_, which should be split into _à_ and _le_.
Note that the rule does not handle the dependency relations, so the output of the rule should be edited for a full annotation.

{{< grew file="/static/doc/rule_gallery/mwt.grs" >}}

{{< tryit "https://web.grew.fr/?corpus=https://grew.fr/doc/rule_gallery/mwt.conllu&grs=https://grew.fr/doc/rule_gallery/mwt_gw.grs" >}}

