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
 1. Else the set M is initialised as the set of matchings which satisfy the union of positive items.
 1. For each negative item, remove from M the matchings which satisfy it.

### Remarks
 * If there is more than one positive `pattern` items, the union is considered.
 * If there is more than one negative `without` items, there are all interpreted independently (and the output is different from the one obtained with a union of negative items)
 * The order of patterns items in a pattern are irrelevant.
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

The clause above illustrates the syntax of constraint that can be expressed, in turn:

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
 * `N -[1=subj]-> M` the edge must match the edge feature constraints (more examples below).

Edges may also be named for usage in commands (in **Grew**) or in clustering (in **Grew-match**) with an identifier:

 * `e: N -> M`
 * `e: N -[nsubj]-> M`
 * …

Note that edge may refer to undeclared nodes, these nodes are then implicitly declared without constraint.
For instance, the two patterns below are equivalent:

```grew
pattern { N -[nsubj]-> M }
```

```grew
pattern { N[]; M[]; N -[nsubj]-> M }
```


As label edges are internally represented by feature structures (see [here](../graph#edges)), it is possible to match them with a standard unification mechanism, similar to the one used for feature structures in nodes.

Some examples (with `sud` configuration) are given below.

| Syntax            | Description | `comp` | `comp:obl` | `comp:obl@agent` | `comp:aux` | `comp:obj@lvc` |
|-------------------|-------------|:------:|:----------:|:----------------:|:----------:|:----------:|
| `X -[1=comp]-> Y` | any edge such that the feature `1` is defined with value `comp` | YES | YES | YES |YES | YES |
| <code>X -[1=comp, 2=obl&vert;aux]-> Y</code> | the feature `1` is defined with value `comp` and the feature `2` is defined with one of the two values `obl` or `aux` | NO | YES |YES |YES | NO|
| <code>X -[1=comp, 2<>obl&vert;aux]-> Y</code> | the feature `1` is defined with value `comp` and the feature `2` is defined with a value different from `obl` or `aux` | NO | NO | NO | NO | YES |
| `X -[1=comp, !deep]-> Y` | the feature `1` is defined with value `comp` and the feature `deep` is not defined | YES | YES | NO |YES | NO|
| `X -[1=comp, 2=*]-> Y` | the feature `1` is defined with value `comp` and the feature `2` is defined with any value | NO | YES | YES |YES | YES|
| `X -[comp]-> Y` | the exact label `comp` and nothing else | YES | NO | NO | NO | NO |

### :warning: Matching with atomic labels :warning:

It is important to note that from the pattern point of view, the two clauses `X -[1=comp]-> Y` (first line in the table) and `X -[comp]-> Y` (last line in the table) are not equivalent!

### Difference with node features matching

Note that we would expect that the syntax `X -[1=comp, 2]-> Y` should be equivalent to `X -[1=comp, 2=*]-> Y` but it will bring an ambiguity for `X -[lab]-> Y` that can be interpreted as the atomic label `X -[lab]-> Y` or as `X -[lab=*]-> Y`.
To avoid this ambiguity, the syntax `X -[1=comp, 2]-> Y` in not allowed.

### Additional constraints

These constrains do not bind new elements in the graph, but must be fulfilled (i.e. binding solutions which do not fulfil the constraints are filtered out).

 * Constraints on features values:
  * `N.lemma = M.lemma` two feature values must be equal
  * `N.lemma <> M.lemma` two feature values must be different
  * `N.lemma = "constant"` the feature `lemma` of node `N` must be the value `constant`
  * `N.lemma = re".*ing"` the value of a feature must follow a regular expression (see [here](http://caml.inria.fr/pub/docs/manual-ocaml/libref/Str.html#VALregexp) for regular expressions accepted)
  * `N.lemma = lexicon.field` imposes that the feature `lemma` of node `N` must be the be present in the `field` of the `lexicon`. **NB**: this reduce also the current lexicon the items for which `field` is equals to `N.lemma`.

 * Constraints on node ordering:
  * `N < M` the node `N` immediately precedes the node `M`
  * `N << M` the node `N` precedes the node `M`

 * Constraints on in or out edges on binded nodes:
  * `* -[nsubj]-> M` there is an incoming edge with label `nsubj` with target `M`
  * `M -[nsubj]-> *` there is an outgoing edge with label `nsubj` with source `M`

 * [Since 1.3] Constraints on edge labels:
   * `label(e1) = label(e2)` the labels of the two edges `e1` and `e2` are equal
   * `label(e1) <> label(e2)` the labels of the two edges `e1` and `e2` are different

 * [:new: 1.4] Constraints on edges relative positions (these constraints impose that the source and the target of both edges are ordered)
   * `e1 >< e2` the two edges intersect (this implies that the 4 nodes are all ordered)
   * `e1 << e2` the edge `e1` is covered by `e2`
   * `e1 <> e2` the two edges are disjoint

 * [:new: 1.4] Position of a node with respect to an edge
   * `N << e` the node `N` is strictly included between source and targer of edge `e`.


### Remarks
When two or more nodes are equivalent in a pattern, each occurrence of the pattern in a graph is found several times (up to permutation in the sets of equivalent nodes).
For instance, in the pattern below, the 3 nodes `N1`, `N2` and `N3` are equivalent.

```grew
pattern { N1 -[ARG1]-> N; N2 -[ARG1]-> N; N3 -[ARG1]-> N; }
```

This pattern is found 120 times in the Little Prince corpus
(<a href="http://match.grew.fr/?corpus=Little_Prince&custom=5d4d6c143cfa6" target="blank">Grew-match</a>)
but there are only 20 different occurrences, each one is reported 6 times with all permutations on `N1`, `N2` and `N3`.
To avoid this, a constraint `id(N1) < id(N2)` can be used.
It imposes an ordering on some internal representation of the nodes and so avoid these permutations.
**NB**: if a constraint `id(N1) < id(N2)` is used with two non-equivalent nodes, the result is unspecified.


The pattern below returns the 20 expected occurrences
(<a href="http://match.grew.fr/?corpus=Little_Prince&custom=5d4d6bb86ce49" target="blank">Grew-match</a>)

```grew
pattern {
    N1 -[ARG1]-> N; N2 -[ARG1]-> N; N3 -[ARG1]-> N;
    N1.__id < N2.__id; N2.__ < N3.__id;
}
```

---
## Global pattern
Global patterns let the user express constrains about the structure of the whole graph.
It is also possible to express constraints about metadata of the graph.

### Structure constraints
Structure constraints are expressed with a fixed list of keywords.

We describe below 4 of the constraints available.
For each one, its negation is available by changing the `is_` prefix by the `is_not_` prefix.

  * `is_cyclic`: the graph satisfied this constraint if and only if it contains a cycle.
  A cycle is a list of nodes `N1`, `N2` … `N(k-1)`, `Nk` such that there are edges `N1 -> N2`, `N2 -> N3`, `N(k-1) -> Nk`, `Nk -> N1`.
  In graph theory, a non cyclic graph is also called a Directed Acyclic Graph (DAG).

  * `is_forest`: the graph satisfied this constraint if and only it is acyclic and if there are no couples of edges with the same target.
  In other words, a graph is a forest if and only if it is acyclic and each node has at most one incoming edge.

  * `is_tree`: a graph is a tree if it is a forest and if it have exactly one root.

  * `is_projective`: the usual [notion of projectivity](https://en.wikipedia.org/wiki/Discontinuity_(linguistics)) defined on tree is generalised by saying the a structure is projective if there are no 4-tuples (`A`, `B`, `C`, `D`) of ordered nodes (i.e. `A << B`, `B << C` and `C << D`) such that `A` and `C` are linked and `B` and `D` are linked (two nodes are linked when there is at least one edge between the two, whatever is the orientation).

### Metadata constraints

In **Grew**, each graph is associated with a list of metadata: a list of (key, value) pairs.

In `global` items, constraints of these metadata can be expressed with:

 * `sent_id = "fr-ud-train_01234" | "fr-ud-train_12345"`: the metadata `sent_id` has one of the two given values;
 * `sent_id <> "fr-ud-train_01234" | "fr-ud-train_12345"`: the metadata `sent_id` is different from two given values;
 * `text = re".*\baux\b.*`: the `text` metadata field follows the given regexp (see [here](http://caml.inria.fr/pub/docs/manual-ocaml/libref/Str.html#VALregexp) for regular expressions accepted; in the example, the field must contain the word *aux*).

For corpora described by the CoNLL-U format, available metadata are described before each sentence (see [CoNNL-U doc](https://universaldependencies.org/format.html#sentence-boundaries-and-comments)).
In the UD or SUD corpora, each sentence contains at least the two metadata `sent_id` and `text`.

## Note about CoNNL-U specificities

Additional information available in the CoNNL-U format can be accessed through special features `textform` and `wordform` (see [CoNLL-U format](../conllu#additional-features-textform-and-wordform))
