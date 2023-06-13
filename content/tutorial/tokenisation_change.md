+++
title = "tokenisation_change"
+++

• [:arrow_up: Top](../top) •

---

# Grew Tutorial • Change tokenization

We reuse here the example of conversion of Sequoia POS tagging to the SUD POS tagging.

We recall the two formats:

| Format | `frwiki_50.1000_00907` |
|:---:|:---:|
| Sequoia | ![sequoia](/tutorial/02_first_rule/_build/frwiki_50.1000_00907.seq.svg) |
| SUD | ![sud](/tutorial/02_first_rule/_build/frwiki_50.1000_00907.sud.svg) |

You can observe that in addition to a different POS tagset, the SUD format also uses a different tokenisation.
The word *du* of the input sentence is one token *du* with POS `P+D` in Sequoia but this is in fact an amalgam of two lexical units: a preposition and a determiner (this is exactly what the tag `P+D` means).
In SUD, such combined tag are not allowed, so the sentence is annotated with two tokens *de* and *le* for the word *du*.

## The command `add_node`

So, we have to design a rule to make this new tokenisation.
The commented rule below computes this transformation (file: [`amalgam1.grs`](/tutorial/tokenisation_change/amalgam1.grs)):

{{< grew file="/static/tutorial/tokenisation_change/amalgam1.grs" >}}

This is our first rule in this tutorial with more than one command.
In general, the transformation is described by a sequence of commands which are applied successively to the current graph.

The application of this rule to our input graph builds:

![onf_du](/tutorial/tokenisation_change/_build/onf_amalgam1.svg)

Good, we have the final tokenisation we expected, but the new node for "le" is not linked to the graph.
We can imagine to connect it later with some other rule but it may be dangerous: imagine an input sentence with several occurrences of the word "du", the application of `Onf (amalgam)` will build a graph with several isolated nodes "le" and it may be confusing to choose later the "right" determiner with the "right" noun!
In practice, it is safer to avoid to build disconnected graph.

## The command `add_edge`

With our example above, our rule should take care of the connection of the new node to the relevant noun.
This can be done with a command `add_edge M -[det]-> D` where `M` is the node for the word *doigt*.
But, to be able to use this node `M` in the `command` part, it must be declared in the `pattern` part.

The new rule is then (file: [`amalgam2.grs`](/tutorial/tokenisation_change/amalgam2.grs)):

{{< grew file="/static/tutorial/tokenisation_change/amalgam2.grs" >}}

The application of this rule to our input graph builds:

![onf_du](/tutorial/tokenisation_change/_build/onf_amalgam2.svg)


## Advanced topic

When an amalgam (also called [Multi word token](https://universaldependencies.org/format.html#words-tokens-and-empty-nodes) in UD) is used, an additional information should be added in the CoNLL-U file in order to keep the link with the raw text.
A special line indicates that the two tokens _de_ and _le_ are present together _du_ in the raw text.
So the expected encoding of the graph above should contains:

```
7-8	du	_	_	_	_	_	_	_	_
7	de	de	ADP	_	_	6	mod	_	s=def
8	le	_	DET	_	_	9	det	_	_
```

These special lines (with index like `7-8`) are encoded in Grew version of graphs with the help of the `textform` features (see [CoNNL-U page](https://grew.fr/doc/conllu/#additional-features-textform-and-wordform)).

The full rule which produce the expected output is:

{{< grew file="/static/tutorial/tokenisation_change/amalgam3.grs" >}}

## Reverse transformation

In the GRS file [rm_mwt.grs](https://github.com/surfacesyntacticud/tools/blob/master/rewrite/rm_mwt.grs), there is a rewriting system for the reverse operation.
It contains some lexical information specific to French but it shows a way to deal with this kind of transformation.

---

• [:arrow_up: Top](../top) •
