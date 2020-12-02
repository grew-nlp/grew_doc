+++
Description = ""
date = "2020-12-02T21:19:25+01:00"
title = "06_more_commands"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]

+++

[[Lesson 5] Confluence](../05_confluence) ---

---

# Grew Tutorial • Lesson 6 • More commands

Let us go on with our conversion of Sequoia POS taggind to the SUD POS tagging.

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
The commented rule below computes this transformation:

{{< grew file="/static/tutorial/06_more_commands/amalgam1.grs" >}}

This is our first rule in this tutorial with more than one commands.
In general, the transformation is described by a sequence of commands which are applied successively to the current graph.

The application of this rule to our input graph builds:

![onf_du](/tutorial/06_more_commands/_build/onf_amalgam1.svg)

Good, we have the final tokenisation we are expected, but the new node for "le" is not linked to the graph.
We can imagine to connect it later with some other rule but it may be dangerous: imagine an input sentence with several occurrences of the word "du", the application of `Onf (amalgam)` will build a graph with several isolated nodes "le" and it may be confusing to choose later the "right" determiner with the "right" noun!
In practice, it is safer to avoid to build disconnected graph.

## The command `add_edge`

With our example above, our rule should take care of the connection of the new node to the relevant noun.
This can be done with a command `add_edge M -[det]-> D` where `M` is the node for the word *doigt*.
But, to be able to use this node `M` in the `command` part, it must be declared in the `pattern` part.

The new rule is then:

{{< grew file="/static/tutorial/06_more_commands/amalgam2.grs" >}}

The application of this rule to our input graph builds:

![onf_du](/tutorial/06_more_commands/_build/onf_amalgam2.svg)


## Advanced topic

TODO: dealing the the special encoding of Mutli-Word Tokens in (S)UD with `wordform` and `textform`.



---

[[Lesson 5] Confluence](../05_confluence) ---
