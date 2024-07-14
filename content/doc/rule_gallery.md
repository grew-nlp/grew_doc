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

{{< tryit "http://web.grew.fr/?corpus=https://grew.fr/doc/rule_gallery/tok_punct.conllu&grs=https://grew.fr/doc/rule_gallery/tok_punct_gw.grs" >}}

## Splitting a token in sub-tokens and adding a Multi-Word token

UD proposes a mechanism to deal with difficult tokenisation examples (See [UD guidelines](https://universaldependencies.org/format.html#words-tokens-and-empty-nodes)).
The rule above shows how to split a token into sub tokens, adding a MWT in the structure.
The first example correspond the the French example contraction _au_ which should be split into _à_ and _le_.
Note that the rule does not consider the dependency relations, so the output of the rule should be edited for a complete annotation.

First, we consider only the case of _au_ split in _à_ and _le_.
See **TODO** for a more general rule parametrized by a lexicon.

{{< grew file="/static/doc/rule_gallery/mwt.grs" >}}

{{< tryit "http://web.grew.fr/?corpus=https://grew.fr/doc/rule_gallery/tok_punct.conllu&grs=https://grew.fr/doc/rule_gallery/mwt_gw.grs" >}}

