+++
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""
date = "2017-05-22T23:01:05+02:00"
title = "request"
aliases = [
    "/doc/pattern"
]
+++

# Requests

Requests are used in **Grew** to describe the left part of rewriting rules and in **Grew-match** to describe queries to be executed on corpora.

The syntax of requests in **Grew** can be learned using the [tutorial part](https://universal.grew.fr?tutorial=yes) of the [Grew-match](https://match.grew.fr) tool.

---
## Requests syntax

A request is defined through 4 different kinds of *request items*.

 * Global items (introduced by the keyword `global`) filter structures based on information about the whole graph or its metadata.
 * Matching items (introduced by the keyword `pattern`) describe nodes and relations that must be found in the graph.
 * Positive filtering items (introduced by the keyword `with`) filter out matchings previously selected by other items (keeping only those that **follow** the additional graph constraints).
 * Negative filtering items (introduced by the keyword `without`) filter out matchings previously selected by other items (keeping only those that **do not follow** the additional graph constraints).
 
The full matching process on a graph is:

 * Take a graph and a request as input.
 * Output a set of matchings; where a *matching* is a function from nodes and edges defined in the matching items to nodes and edges of the host graph.

 1. If the graph metadata does not satisfy any of the global items, the output is empty.
 1. Else the set M is initialised as the set of matchings that satisfy the union of matching items.
 1. For each positive filtering item, remove from M the matchings that do not satisfy it.
 1. For each negative filtering item, remove from M the matchings that satisfy it.

On a corpus, the graph matching process is repeated on each graph.

### Remarks
 * If there is more than one matching `pattern` items, the union is taken into account.
 * If there is more than one filtering (`without` or `with`) items, there are all interpreted independently.
 * The order of items in a request are irrelevant.
 * It there is no matching item (`pattern`), there is a trivial matching which is the empty function.

---
## Matching and filtering items
Both matching and filtering items both follow the same syntax.
They are described by a list of clauses: node clauses, edge clauses and additional constraints.

### Node clauses
In a *node clause*, a node is described by an identifier (`X` in the example below) and some constraints on its feature structure.

```grew
X [upos = VERB, Mood = Ind|Imp, Tense <> Fut, Number, !Person, form = "être", lemma = re"s.*", Gloss = /.*POSS.*/i] ]
```

The clause above illustrates the syntax of constraint that can be expressed, in turn:

 * `upos = VERB` requires that the feature `upos` is defined with the value `VERB`
 * `Mood = Ind|Imp` requires that the feature `Mood` is defined with one of the two values `Ind` or `Imp`
 * `Tense <> Fut` requires that the feature `Tense` is defined with a value different from `Fut`
 * `Number` requires that the feature `Number` is defined whatever is its value (note that the same constraint can also be written `Number = *` )
 * `!Person` requires that the feature `Person` is not defined
 * `form = "être"` quotes are required when non-ASCII characters are used
 * `lemma = re"s.*"` the prefix `re` before a string declares a regular expression
 * [🆕 `1.16.2`] `Gloss = /.*POSS.*/i` PCRE-style regular expression (the optional suffix `i` is for case-insensitive matching).

### Anchor nodes
⚠️ For dependency trees, an anchor node (position 0) is added to the structure (see [here](../conllu/#the-anchor-node-at-position-0)).
In **ArboratorGrew**, this node is not displayed but is still taken into account when searching requests or when applying rules.

### Disjunction in node clause
⚠️ Since version 1.14

Following the feature request [#47](https://github.com/grew-nlp/grew/issues/47), a node can be matched with a disjunction of feature structures
(separated by the pipe symbol `|`).

#### Examples
The following clause selects either a past participle verb or an adjective {{< tryit "https://universal.grew.fr/?request=pattern { X[upos=VERB, VerbForm=Part, Tense=Past]|[upos=ADJ] }" >}}:
```grew
X [upos=VERB, VerbForm=Part, Tense=Past]|[upos=ADJ]
```

A node with either a `upos` `ADV` (and no `ExtPos`) or an `ExtPos` `ADV` can be searched with {{< tryit "https://universal.grew.fr/?corpus=SUD_French-GSD@2.16&request=pattern { X [upos=ADV, !ExtPos]|[ExtPos=ADV] }" >}}:
```grew
X [upos=ADV, !ExtPos]|[ExtPos=ADV]
```


### Edge clauses

All *edge clauses* below require the existence of an edge between the node selected by `X` and the node selected by `Y`, eventually with additional constraints:

 * `X -> Y`: no additional constrains
 * `X -[nsubj]-> Y`: the edge label is `nsubj`
 * `X -[nsubj|obj]-> Y`: the edge label is either `nsubj` or `obj`
 * `X -[^nsubj|obj]-> Y`: the edge label is different from `nsubj` and `obj`
 * `X -[re".*subj"]-> Y`: the edge follows the regular expression (see [here](http://caml.inria.fr/pub/docs/manual-ocaml/libref/Str.html#VALregexp) for regular expressions accepted)

Edges may also be named for usage in commands (in **Grew**) or in clustering (in **Grew-match**) with an identifier:

 * `e: X -> Y`
 * `e: X -[nsubj]-> Y`
 * …

Note that edges may refer to undeclared nodes, these nodes are then implicitly declared without constraint.
For instance, the two requests below are equivalent:

```grew
pattern { X -[nsubj]-> Y }
```

```grew
pattern { X[]; Y[]; X -[nsubj]-> Y }
```

### Additional constraints

These constraints do not bind new elements in the graph, but must be fulfilled (i.e. binding solutions which do not fulfill the constraints are filtered out).

#### Constraints on feature values:
 - `X.lemma = Y.lemma` &rarr; The `lemma` of nodes `X` and `Y` must be the same
 - `X.lemma <> Y.lemma` &rarr; The `lemma` of nodes `X` and `Y` must be different
 - `X.lemma = "constant"` &rarr; The feature `lemma` of node `X` must be equal to the value `constant`
 - `X.lemma = re".*ing"` &rarr; The feature `lemma` of node `X` must follow a regular expression (see [here](http://caml.inria.fr/pub/docs/manual-ocaml/libref/Str.html#VALregexp) for accepted regular expressions)
 - [🆕 `1.16.2`] `X.lemma = /.*ing/` &rarr; The feature `lemma` of node `X` must follow a PCRE-style regular expression
 - [🆕 `1.16.2`] `X.lemma = /.*ing/i` &rarr; The feature `lemma` of node `X` must follow a case-insensitive PCRE-style regular expression
 - `X.lemma = lexicon.field` &rarr; The feature `lemma` of node `X` must be present in the `field` of the `lexicon`. **Note**: this also reduces the current lexicon to the items for which `field` is equal to `X.lemma`.

Note that disjunction cannot be used in this context.
You cannot write `X.upos = VERB|AUX`.

#### Constraints on node ordering:
 - `X < Y` &rarr; The node `X` immediately precedes the node `Y`
 - `X << Y` &rarr; The node `X` precedes the node `Y`

#### Constraints on large dominance
 - [🆕 `1.16.2`]  `X ->> Y`: there is a path, regardless of its length, from `X` to `Y` (see [#49](https://github.com/grew-nlp/grew/issues/49)).
   - {{< tryit "https://semantics.grew.fr/?corpus=Little_Prince&request=pattern { X [concept = \"see-01\"]; Y [concept = \"name\"]; X ->> Y }" >}} on AMR
   - {{< tryit "https://universal.grew.fr/?corpus=bUD_English-EWT@2.16&request=pattern { V1 [upos=VERB]; V1 ->> P; P[upos=PRON, PronType=Rel] }" >}} on `bUD_English-EWT@2.16` &rarr; Find a `VERB` that dominates a relative pronoun.
   - {{< tryit "https://universal.grew.fr/?corpus=bUD_English-EWT@2.16&request=pattern { V1 [upos=VERB]; V1 ->> P; P[upos=PRON, PronType=Rel] }%0Awithout { V2 [upos=VERB]; V1 ->> V2; V2 ->> P; }" >}} on `bUD_English-EWT@2.16` &rarr; Find a `VERB` that dominates a relative pronoun without another `VERB` on the path.

#### Constraints on in or out edges on bound nodes:
 - `* -[nsubj]-> Y` &rarr; There is an incoming edge with label `nsubj` with target `Y`. **Note**: the source node of the incoming edge is not bound; it can be equals to any other node (bound or not).
 - `Y -[nsubj]-> *` &rarr; There is an outgoing edge with label `nsubj` with source `Y`. **Note**: the target node of the outcoming edge is not bound; it can be equals to any other node (bound or not).

#### Constraints on edge labels:
 - `e1.label = e2.label` &rarr; The labels of the two edges `e1` and `e2` are equal.
 - `e1.label <> e2.label` &rarr; The labels of the two edges `e1` and `e2` are different.

#### Constraints on edges relative positions
These constraints impose that the source and the target of both edges are ordered).
 - `e1 >< e2` &rarr; The two edges intersect (this implies that the 4 nodes are all ordered) {{< tryit "https://universal.grew.fr/?corpus=SUD_French-GSD@latest&request=pattern { %0A  e1: N1 -[subj]-> M1;%0A  e2: N2 -[comp:obj]-> M2;%0A  e1 >< e2%0A}" >}}.
 - `e1 << e2` &rarr; The edge `e1` is covered by `e2`.
 - `e1 <> e2` &rarr; The two edges are disjoint.

#### Position of a node with respect to an edge
 - `X << e` &rarr; The node `X` is strictly included between the source and the target of edge `e`.

#### Constraints on distance between two nodes
[🆕 `1.16.0`] These constraints imply that both `X` and `Y` are ordered nodes.
 - `length(X,Y) = 4` &rarr; The length of the dependency relation is 4 (i.e. there are exactly 3 other nodes between `X` and `Y`), whatever is the relative position of `X` and `Y`.
 - `delta(X,Y) = 4` &rarr; The length of the dependency relation is 4 and `Y` is after `X` in the linear order.
 - `delta(X,Y) = -4` &rarr; The length of the dependency relation is 4 and `Y` is before `X` in the linear order.

In the previous constraints, `=` can be replaced by `<`, `<=`,  `>` or `>=` with an obvious meaning!
The keywords `length` and `delta` are also [available as clustering keys](../clustering#clustering-on-distance-between-nodes).

---

## Injectivity in nodes matching

By default, node matching is injective, meaning that two different nodes in the request are mapped to two different nodes in the graph.

For example, the following request searches for two different tokens, both with the same lemma *make* {{<tryit "https://universal.grew.fr/?corpus=UD_English-ParTUT@2.16&request=pattern { X1 [ lemma=\"make\" ]; X2 [ lemma=\"make\" ] }" >}}.

```grew
pattern { X1 [ lemma="make" ]; X2 [ lemma="make" ] }
```

If the node identifier is suffixed by the symbol `$`, the injectify constraint is relaxed.
A node `X$` can be mapped to any node in the graph (either already mapped by another node of the request or not).
Note that `X$` is a new name unrelated to any potential node named `X`.

### Example

In AMR graphs, if we look for a predicate (with `concept=judge-01` in the example) with two arguments `ARG0` and `ARG1`, there are two dictinct cases:
 * two different nodes `A0` and `A1` are respectively `ARG0` and `ARG1` &rarr; 1 occurence {{<tryit "https://semantics.grew.fr/?corpus=Little_Prince&request=pattern { X [concept=\"judge-01\"]; X -[ARG0]-> A0; X -[ARG1]-> A1; }" >}}

```grew
pattern { X [concept="judge-01"]; X -[ARG0]-> A0; X -[ARG1]-> A1; }
```
 * the same node `A`is both `ARG0` and `ARG1` &rarr; 4 occurences {{<tryit "https://semantics.grew.fr/?corpus=Little_Prince&request=pattern { X [concept=\"judge-01\"]; X -[ARG0]-> A; X -[ARG1]-> A; }" >}}

```grew
pattern { X [concept="judge-01"]; X -[ARG0]-> A; X -[ARG1]-> A; }
```

If we do not require the injectivity on one of the two arguments, then both cases above are returned &rarr; 5 occurences  {{<tryit "https://semantics.grew.fr/?corpus=Little_Prince&request=pattern { X [concept=\"judge-01\"]; X -[ARG0]-> A; X -[ARG1]-> B$; }" >}}


```grew
pattern { X [concept="judge-01"]; X -[ARG0]-> A; X -[ARG1]-> B$; }
```

For a more complex example with non-injective matching, you can see [this example](../../gallery/span).


---
## Complex edges

As label edges are internally represented by feature structures (see [here](../graph#edges)), it is possible to match them with a standard unification mechanism, similar to the one used for feature structures in nodes.

 * `X -[1=subj]-> Y` the edge must match the edge feature constraints (more examples below).
 * `X -[2="зад"]-> Y` the edge must match the edge feature constraints with non-ASCII characters {{< tryit "https://universal.grew.fr/?corpus=UD_Bulgarian-BTB@2.16&request=pattern { X -[2=\"зад\"]-> Y }" >}} (see [#36](https://gitlab.inria.fr/grew/libcaml-grew/-/issues/36)).



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

It is important to note that from the request point of view, the two clauses `X -[1=comp]-> Y` (first line in the table) and `X -[comp]-> Y` (last line in the table) are not equivalent!

### Difference with node features matching

Note that we would expect that the syntax `X -[1=comp, 2]-> Y` should be equivalent to `X -[1=comp, 2=*]-> Y` but it will bring an ambiguity for `X -[lab]-> Y` that can be interpreted as the atomic label `X -[lab]-> Y` or as `X -[lab=*]-> Y`.
To avoid this ambiguity, the syntax `X -[1=comp, 2]-> Y` in not allowed and you should write `X -[1=comp, 2=*]-> Y`.

---
## Global request
Global requests let the user express constrains about the structure of the whole graph.
It is also possible to express constraints about metadata of the graph.

### Structure constraints
Structure constraints are expressed with a fixed list of keywords.

We describe below 4 of the constraints available.
For each one, its negation is available by changing the `is_` prefix by the `is_not_` prefix.

  * `is_cyclic`: the graph satisfied this constraint if and only if it contains a cycle.
  A cycle is a list of nodes `X1`, `X2` … `X(k-1)`, `Xk` such that there are edges `X1 -> X2`, `X2 -> X3`, `X(k-1) -> Xk`, `Xk -> X1`.
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

For corpora described by the CoNLL-U format, available metadata are described before each sentence (see [CoNLL-U doc](https://universaldependencies.org/format.html#sentence-boundaries-and-comments)).
In the UD or SUD corpora, each sentence contains at least the two metadata `sent_id` and `text`.

---

## Some other tricks

### Equivalent nodes
When two or more nodes are equivalent in a request (i.e. they can be interchanged without altering the meaning of the request), each occurrence of the request in a graph is reported multiple times (up to permutation in the sets of equivalent nodes).
For example, in the request below, the 3 nodes `X1`, `X2` and `X3` are equivalent.

```grew
pattern { X1 -[ARG1]-> X; X2 -[ARG1]-> X; X3 -[ARG1]-> X; }
```

This request is found 270 times in the Little Prince corpus {{< tryit "https://semantics.grew.fr/?corpus=Little_Prince&request=pattern { X1 -[ARG1]-> X; X2 -[ARG1]-> X; X3 -[ARG1]-> X; }" >}}
but there are only 45 different occurrences; each one being reported 6 times with all permutations on `X1`, `X2` and `X3`.
To avoid this, the constraint `X1.__id__ < X2.__id__` can be used, which imposes an ordering on some internal representation of the nodes and so avoids these permutations.
**Note**: If a constraint `X1.__id__ < X2.__id__` is used with two non-equivalent nodes, the result is unspecified.


The request below returns the 45 expected occurrences
{{< tryit "https://semantics.grew.fr/?corpus=Little_Prince&request=pattern {%0A  X1 -[ARG1]-> X; X2 -[ARG1]-> X; X3 -[ARG1]-> X;%0A  X1.__id__ < X2.__id__; X2.__id__ < X3.__id__; %0A}%0A" >}}

```grew
pattern {
  X1 -[ARG1]-> X; X2 -[ARG1]-> X; X3 -[ARG1]-> X;
  X1.__id__ < X2.__id__; X2.__id__ < X3.__id__;
}
```

### Multiple constraints on the same feature

It is not always possible to constrain the same feature of the same node several times in node clauses.
More specifically, this is not possible if one of the constraints refers to a lexicon or a regular expression.

The following request, for instance, will not be accepted:
The error message is 'Cannot build a pattern with these constraints'.

```grew
pattern { X [form=re".*a.*"] }
pattern { X [form=re".*b.*"] }
```

If you wish to submit such a request, you should convert one of the constraints into a `with` request item.

```grew
pattern { X [form=re".*a.*"] }
with { X [form=re".*b.*"] }
```
