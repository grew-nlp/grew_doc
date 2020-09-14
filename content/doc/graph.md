+++
date = "2018-06-05T11:16:30+02:00"
title = "graphs"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""

+++

# Graphs definition
The graphs we consider in **Grew** are defined as usually in mathematics by two sets:

 * A set **N** of nodes
 * A set **E** of edges

## Nodes
A node is described by a an identifier (needed to refer to nodes in edges definitions) and a feature structure: a finite list of pairs (*feature_name*, *feature_value*).

TODO: nodes order!!

## Edges
An edge is described by two nodes (called the *source* and the *target* of the edge) and by an edge label.

Before version 1.2, edge labels were atomic and did not have an internal structure.
This was not very convenient to deal with complex edges:

  * in [Deep-sequoia](deep-sequoia.inria.fr), the edge `suj:obj` means that the final function is `suj` and the canonical function is `obj`;
  * in [UD](https://universaldependencies.org), the label `aux:pass` is a subtype of the label `aux`;
  * in [SUD](https://surfacesyntacticud.github.io/), the label `compl:obl@agent` contains both a subtype `obl` and a deep feature `agent` (see [TLT 2019](https://hal.inria.fr/hal-02266003v1)).

In all these cases, with atomic edge labels, it is not possible to deal with one part of the label independently.
Since version 1.2, the implementation of edge labels has changed to tackle this problem.
Edge labels are now encoded as feature structures.

In **Grew** graphs, an edge label is internally stored as a flat feature structure or, in other words, a finite set of couples `(f_1,v_1)` … `(f_k,v_k)` where all `f_i` are pairwise different.
We will use the traditional notation `f=v` for these couples.

For backward compatibility and for ease of use in practice, a **compact** notation may be used for edge labels.
An edge label can be written with a compact notation if it contains only features with names `1`, `2` or `deep`.
In the compact notation, the `2` feature is introduced by `:` and the `deep` feature by `@` (this corresponds to the convention used in [SUD](https://surfacesyntacticud.github.io/)).
A few other specific features are used for the encoding of special relations used in deep syntax representation (either in [Enhanced UD](https://universaldependencies.org/u/overview/enhanced-syntax.html) of in [Deep-sequoia](http://deep-sequoia.inria.fr/)).

The table below gives examples of correspondance between compact and internal representation.

|               Relation                                                                                  | Compact notation    |  Internal representation     |
|---------------------------------------------------------------------------------------------------------|---------------------|------------------------------|
| Simple relation                                                                                         | `obj`               | `1=obj`                      |
| relation with subtype in UD or in SUD                                                                   | `aux:pass`          | `1=aux, 2=pass`              |
| [SUD relation with deep feature](https://surfacesyntacticud.github.io/guidelines/u/#sud-deep-features)  | `compl:obl@agent`   | `1=compl, 2=obl, deep=agent` |
| [Enhanced UD relation](https://universaldependencies.org/u/overview/enhanced-syntax.html)               | `E:subj`            | `1=suj, enhanced=yes`        |
| [Deep-sequoia](http://deep-sequoia.inria.fr/) (both surf & deep)                                        | `suj:obj`           | `1=suj, 2=obj`               |
| Deep-sequoia (surf only)                                                                                | `S:suj:obj`         | `1=suj, 2=obj, kind=surf`    |
| Deep-sequoia (deep only)                                                                                | `D:suj:obj`         | `1=suj, 2=obj, kind=deep`    |


Any other feature names (a few reserved names exists, see below) can be used in edge label representation.
In this case, these is not compact representation and the internal representation is used.

Reserved feature names are:

 * `label`: the syntax `e.label` is a shortcut to make reference to the full feature structure. It can be used for instance to copy the edge label from one edge `e` to antothe edge `f` with the command: `f.label = e.label`.
 * `length`: the syntax `e.length` is used to refer the distance (natural number) between two ordered nodes. The length of a relation between two consecutive nodes is 1.
 * `delta`: the syntax `e.delta` is used to refer the relative position (an integer) between two ordered nodes.



# Graph input formats
To describe a graph in practice, **Grew** offers several input formats:

 * [CoNLL format](../conll)
 * a native `gr` format (TODO)
* the `amr` format (TODO)
