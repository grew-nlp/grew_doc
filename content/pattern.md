+++
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""
date = "2017-05-22T23:01:05+02:00"
title = "pattern"
+++

# Patterns

Patterns are used in **Grew** to describe left part of rewriting rules and in **Grew-match** to describe queries to be executed on corpora.

---
## Pattern syntax

A Pattern is defined through 3 different kind of *pattern items*.

 * global items (introduced by the keyword `global`) filter out structures based on information about the whole graph.
 * positive items (introduced by keyword `pattern`) describe a positive part (nodes and relations) that must be found in the graph.
 * negative items (introduced by the keyword `without`) filter out a part of the matchings previously selected by global and positive clauses.

The full matching process is:

 * Take a graph and a pattern as input.
 * Output a set of matchings; a *matching* being a function from nodes and edges defined in the positive items to nodes and edges of the host graph.

 1. If the graph does not satisfied one of the global items, the output is empty.
 1. Else the set M is initialised as the set of matchings which satisfies the union of positive items.
 1. For each negative item, remove from M the matchings which satisfies it.

### Remarks
 * If there is more than one positive `pattern` items, the union is considered.
 * If there is more than one negative `without` items, there are all interpreted independently (and the output is different from the one obtained with a union of negative items)
 * It there is no positive item, there is a trivial matching which is the empty function.

The syntax of patterns in **Grew** can be learned using the [tutorial part](http://match.grew.fr?tutorial=yes) of the [Grew-match](http://match.grew.fr) tool.

---
## Positive and negative patterns
Positive and negative items both follow the same syntax.
They are described by a list of clauses: node clauses, edge clauses and additional constraints

### Node clauses
In a *node clause*, a node is described by an identifier and some constraints on its feature structure.

```grew
N [upos = VERB, Mood = Ind|Imp, Tense <> Fut, Number, !Person, lemma = "être" ]
```

The clause above illustrated the syntax of constraint that can be expressed, in turn:

 * `upos = VERB` requires that the feature `upos` is defined with the value `VERB`
 * `Mood = Ind|Imp` requires that the feature `Mood` is defined with one of the two values `Ind` or `Imp`
 * `Tense <> Fut` requires that the feature `Tense` is defined with a value different from `Fut`
 * `Number` requires that the feature `Number` is defined whatever is its value
 * `!Person` requires that the feature `Person` is not defined
 * `lemma = "être"` quotes are required when non-ASCII characters are used

### Edge clauses

All *edge clauses* below require the existence of an edge between the node selected by `N` and the node selected by `M`, eventually with additional constraints:

 * `N -> M`: no additional constrains
 * `N -[nsubj]-> M`: the edge label is `nsubj`
 * `N -[nsubj|obj]-> M`: the edge label is either `nsubj` or `obj`
 * `N -[^nsubj|obj]-> M`: the edge label is different from `nsubj` and `obj`
 * `N -[re".*subj"]-> M`: the edge follows the regular expression (see [here](http://caml.inria.fr/pub/docs/manual-ocaml/libref/Str.html#VALregexp) for regular expressions accepted)

Edges may also be named for future use (in commands or in clustering for instance) with an identifier:

 * `e: N -> M`

Note that edge may refer to undeclared nodes, these nodes are then implicitly declared without constraint.
For instance, the two patterns below are equivalent:

```grew
pattern { N -[nsubj]-> M }
```

```grew
pattern { N[]; M[]; N -[nsubj]-> M }
```

Since version 1.2, more complex edges can be used, see [here](../complex_edges#complex-edges-in-patterns).

### Additional constraints

These constrains do not identify new elements in the graph, but must be respected.

 * Constraints on features values:
  * `N.lemma = M.lemma` two feature values must be equal
  * `N.lemma <> M.lemma` two feature values must be different
  * `N.lemma = re".*ing"` the value of a feature must follow a regular expression (see [here](http://caml.inria.fr/pub/docs/manual-ocaml/libref/Str.html#VALregexp) for regular expressions accepted)
 * Constraints on node ordering:
  * `N < M` the node `N` immediately precedes the node `M`
  * `N << M` the node `N` precedes the node `M`
 * Constraints on edges:
  * `* -[nsubj]-> M` there is an incoming edge with label `nsubj` with target `M`
  * `M -[nsubj]-> *` there is an outgoing edge with label `nsubj` with source `M`
 * [Since version 1.3] Constraints on edge labels:
   * `label(e1) = label(e2)` the labels of the two edges `e1` and `e2` are equal
   * `label(e1) <> label(e2)` the labels of the two edges `e1` and `e2` are different

### Remarks
When two or more nodes are equivalent in a pattern, each occurrence of the pattern in a graph will be found several times (up to permutation in the sets of equivalent nodes).
For instance, in the pattern below, the 3 nodes `N1`, `N2` and `N3` are equivalent.

```grew
pattern { N1 -[ARG1]-> N; N2 -[ARG1]-> N; N3 -[ARG1]-> N; }
```

This pattern is found 120 times in the Little Prince corpus ([Grew-match](http://match.grew.fr/?corpus=Little_Prince&custom=5d4d6c143cfa6)) but there are only 20 different occurrences, each one is reported 6 times with all permutations on `N1`, `N2` and `N3`.
To avoid this, a constraint `id(N1) < id(N2)` can be used.
It imposes an ordering on some internal representation of the nodes and so avoid these permutations.
**NB**: if a constraint `id(N1) < id(N2)` is used with two non-equivalent nodes, the result is unspecified.


The pattern below returns the 20 expected occurrences ([Grew-match](http://match.grew.fr/?corpus=Little_Prince&custom=5d4d6bb86ce49))

```grew
pattern {
    N1 -[ARG1]-> N; N2 -[ARG1]-> N; N3 -[ARG1]-> N;
    id(N1) < id(N2); id(N2) < id (N3);
}
```

---
## Global pattern
Global patterns were introduced in version 1.2 to let the user express constrains about the structure of the whole graph.
Since version 1.3.4, it is also possible to express constraints about metadata of the graph.

### Structure constraints
Structure constraints are expressed with a fixed list of keywords.

We describe below 4 of the constraints available in version 1.2.
For each one, its negation is available by changing the `is_` prefix by the `is_not_` prefix.

  * `is_cyclic`: the graph satisfied this constraint if and only if it contains a cycle.
  A cycle is a list of nodes `N1`, `N2` … `N(k-1)`, `Nk` such that there are edges `N1 -> N2`, `N2 -> N3`, `N(k-1) -> Nk`, `Nk -> N1`.
  In graph theory, a non cyclic graph is also called a Directed Acyclic Graph (DAG).

  * `is_forest`: the graph satisfied this constraint if and only it is acyclic and if there are no couples of edges with the same target.
  In other words, a graph is a forest if and only if it is acyclic and each node has at most one incoming edge.

  * `is_tree`: a graph is a tree if it is a forest and if it have exactly one root.

  * `is_projective`: the usual notion of projectivity defined on tree is generalised by saying the a structure is projective if there are no 4-tuples (`A`, `B`, `C`, `D`) of ordered nodes (i.e. `A << B`, `B << C` and `C << D`) such that `A` and `C` are linked and `B` and `D` are linked (two nodes are linked when there is at least one edge between the two, whatever is the orientation).

### Metadata constraints

In **Grew**, each graph is associated with a list of metadata: a list of (key, value) pairs.

In `global` items, constraints of these metadata can be expressed with:

 * `sent_id = "fr-ud-train_01234" | "fr-ud-train_12345"`: the metadata `sent_id` has one of the two given values;
 * `sent_id <> "fr-ud-train_01234" | "fr-ud-train_12345"`: the metadata `sent_id` is different from two given values;
 * `text = re".*\baux\b.*`: the `text` metadata field follows the given regexp (see [here](http://caml.inria.fr/pub/docs/manual-ocaml/libref/Str.html#VALregexp) for regular expressions accepted; in the example, the field must contain the word *aux*).

For corpora described by the CoNLL-U format, available metadata are described before each sentence (see [CoNNL-U doc](https://universaldependencies.org/format.html#sentence-boundaries-and-comments)).
In the UD or SUD corpora, each sentence contains at least the two metadata `sent_id` and `text`.

---

## Note about CoNNL-U specificities

Additional information available in the CoNNL-U format can be accessed through special features:

  * Features of column 10 (MISC) are shown with the prefix `_MISC_`
  * Empty nodes have a feature `_UD_empty=Yes`
  * Multiword tokens are described on the first element with features `_UD_mw_fusion` and `_UD_mw_span`

⚠️ Note that these features are not handle in the same way in Grew-match (see [Grew-match doc](../match_doc#additional-feature-textform-and-wordform)).
