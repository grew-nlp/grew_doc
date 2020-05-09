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
A node is described by a an identifier (needed to refer to nodes in edges definitions) and a feature structure (basically a finite list of pairs (*feature_name*, *feature_value*)).

TODO: nodes order!!

## Edges
An edge is described by two nodes (called the *source* and the *target* of the edge) and by an edge label.

Before version 1.2, edge labels were atomic and did not have an internal structure.
This was not very convenient to deal with complex edges:

  * in [Deep-sequoia](deep-sequoia.inria.fr), the edge `suj:obj` means that the final function is `suj` and the canonical function is `obj`;
  * in [UD](https://universaldependencies.org), the label `aux:pass` is a subtype of the label `aux`;
  * in SUD, the label `compl:obl@agent` contains both a subtype `obl` and a deep feature `agent` (see [TLT 2019](https://hal.inria.fr/hal-02266003v1)).

In all these cases, with atomic edge labels, it is not possible to deal with one part of the label independently.
Since version 1.2, the implementation of edge labels has changed to tackle this problem.
Edge labels are now encoded as feature structures.

In **Grew** graphs, an edge label is internally stored as a flat feature structure or, in other words, a finite set of couples `(f_1,v_1)` … `(f_k,v_k)` where all `f_i` are pairwise different.
We will use the traditional notation `f=v` for these couples.

For backward compatibility and for ease of use in practice, a **compact** notation may be used for edge labels.
An edge label can be written with a compact notation only if it contains features with names `rel`, `subrel` and or `deep`.
In the compact notation, the `subrel` is introduced by `:` and the `deep` feature by `@` (this corresponds to the convention used in [SUD](https://surfacesyntacticud.github.io/)).

In version 1.3, feature names `1` and `2` where used instead of `rel` and `subrel`, this is still available but considered deprecated.

| Internal representation             | Compact notation    |    Deprecated alternative    |
|-------------------------------------|---------------------|------------------------------|
| `rel=suj, subrel=obj`               | `suj:obj`           | `1=suj, 2=obj`               |
| `rel=aux, subrel=pass`              | `aux:pass`          | `1=aux, 2=pass`              |
| `rel=compl, subrel=obl, deep=agent` | `compl:obl@agent`   | `1=compl, 2=obl, deep=agent` |

TODO: add info about `kind`

# Graph input formats
To describe a graph in practice, **Grew** offers several input formats:

 * [CoNLL format](../conll)
 * a native `gr` format (TODO)
* the `amr` format (TODO)
