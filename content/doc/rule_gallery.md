+++
title = "Rule Gallery"
menu = "main"
+++

# Rule Gallery

This page gives examples of rules that can be used either with ArboratorGrew and when writing more complex [GRS](../grs).

 - [Tokenisation](./#tokenisation)
   - [Split one token into two tokens](./#split-one-token-into-two-tokens)
   - [Splitting a token in sub-tokens and adding a Multi-Word token](./#splitting-a-token-in-sub-tokens-and-adding-a-multi-word-token)
   - [Splitting a punctuation mark at the end of a token](./#splitting-a-punctuation-mark-at-the-end-of-a-token)
   - [Merge 2 tokens into 1](./#merge-2-tokens-into-1)
   - [Larger change in tokenisation](./#larger-change-in-tokenisation)


## Tokenisation

⚠️ NOTE: the rules proposed in this section are just modifying the sequence of tokens.
The dependency links are not taken into account.
In order to take these into account, you can:
 - Add specific commands to move or change these relations
 - Or, in ArboratorGrew, you can post edit the graph after the **Apply rules** operation

---

### Split one token into two tokens

Suppose that your data contains a token *didn't* that should be splitted into two separated tokens *did* and *n't*.
The rule above implements this operation:

{{< grew file="/static/doc/rule_gallery/split_1to2.grs" >}}

{{< tryit "https://web.grew.fr/?corpus=https://grew.fr/doc/rule_gallery/split_1to2.conllu&grs=https://grew.fr/doc/rule_gallery/split_1to2_gw.grs" >}}

Note again that the token *not* is isolated, something more is needed to connect it!

---

### Splitting a token in sub-tokens and adding a Multi-Word token

UD proposes a mechanism for dealing with difficult tokenisation examples (see [UD guidelines](https://universaldependencies.org/format.html#words-tokens-and-empty-nodes)).
This mechanism is called a Multi-Word Token (MWT).
The rule above shows how to split a token into sub tokens by adding a MWT to the structure.
The first example corresponds to the French contraction _au_, which should be split into _à_ and _le_.
Note that the rule does not handle the dependency relations, so the output of the rule should be edited for a full annotation.

{{< grew file="/static/doc/rule_gallery/mwt.grs" >}}

{{< tryit "https://web.grew.fr/?corpus=https://grew.fr/doc/rule_gallery/mwt.conllu&grs=https://grew.fr/doc/rule_gallery/mwt_gw.grs" >}}

---

### Splitting a punctuation mark at the end of a token
This example below splits the tokenisation signs which were kept on the previous word.
For example: split *Go!* into *Go* and *!*.

{{< grew file="/static/doc/rule_gallery/tok_punct.grs" >}}

Note that commands order is important: if the command `X.form = X.form[:-1]` appear before `Y.form = X.form[-1:]` the result will be wrong.

{{< tryit "https://web.grew.fr/?corpus=https://grew.fr/doc/rule_gallery/tok_punct.conllu&grs=https://grew.fr/doc/rule_gallery/tok_punct_gw.grs" >}}


---
### Merge 2 tokens into 1

The rule below performs the reverse operation of the one above: turn two consecutive token *did* and *n't* into one token *didn't*.

{{< grew file="/static/doc/rule_gallery/change_2to1.grs" >}}

{{< tryit "https://web.grew.fr/?corpus=https://grew.fr/doc/rule_gallery/change_2to1.conllu&grs=https://grew.fr/doc/rule_gallery/change_2to1_gw.grs" >}}

Note that, depending on the dependency relations and the features on the initial tokens `X1` and `X2`,
it may be simpler to pu the new `form` on `X2` and to remove `X1`.

---

### Larger change in tokenisation

The next example is taken from `mSUD_Bokota` where some data tokenized as 3 tokens *ho*+*ked*+*-a* should be changed into the 2 token sequence *hoke*+*da*.

{{< grew file="/static/doc/rule_gallery/change_3to2.grs" >}}

{{< tryit "https://web.grew.fr/?corpus=https://grew.fr/doc/rule_gallery/change_3to2.conllu&grs=https://grew.fr/doc/rule_gallery/change_3to2_gw.grs" >}}
