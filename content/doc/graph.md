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

In many linguistic structures, the notion of word order plays a crucial role.
To take this into account, in a Grew graph, nodes are split in two subsets:

 * totally ordered nodes (in general the words of some sentence)
 * non ordered nodes for other layers of information encoding (examples: constituent nodes in phrase structure, nodes in AMR graphs, additional nodes encoding MWE in PARSEME graphs…)

In the [node creation command](../commands#node-creation) `add_node`, the user can choose to add an unordered node or to place the new node before or after a existing one.

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

The correspondence between compact notation and feature structure depends on the `config` parameter.
In version 1.4, four predefine configuration are available: `ud`, `sud`, `sequoia` and `basic`.

The symbol `:` (used in `ud`, `sud` and `sequoia`) is interpreted as a separator, the left part is given feature value `1` and the right part feature value `2`.

The tables below give more examples of correspondances between compact and internal representation.

### `ud`

|               Relation                                                                        | Compact notation    |  Internal representation     |
|-----------------------------------------------------------------------------------------------|---------------------|------------------------------|
| Simple relation                                                                               | `obj`               | `1=obj`                      |
| relation with subtype                                                                         | `aux:pass`          | `1=aux, 2=pass`              |
| [Enhanced UD relation](https://universaldependencies.org/u/overview/enhanced-syntax.html)     | `E:nsubj`           | `1=nsuj, enhanced=yes`       |

### `sud`

|               Relation                                                                                  | Compact notation    |  Internal representation     |
|---------------------------------------------------------------------------------------------------------|---------------------|------------------------------|
| Simple relation                                                                                         | `mod`               | `1=mod`                      |
| relation with subtype                                                                                   | `comp:aux`          | `1=comp, 2=aux`              |
| [SUD relation with deep feature](https://surfacesyntacticud.github.io/guidelines/u/#sud-deep-features)  | `compl:obl@agent`   | `1=compl, 2=obl, deep=agent` |

### `sequoia`

|               Relation                                                                                  | Compact notation    |  Internal representation     |
|---------------------------------------------------------------------------------------------------------|---------------------|------------------------------|
| Simple relation                                                                                         | `obj`               | `1=obj`                      |
| [Deep-sequoia](http://deep-sequoia.inria.fr/) (both surf & deep)                                        | `suj:obj`           | `1=suj, 2=obj`               |
| [Deep-sequoia](http://deep-sequoia.inria.fr/) (surf only)                                               | `S:suj:obj`         | `1=suj, 2=obj, kind=surf`    |
| [Deep-sequoia](http://deep-sequoia.inria.fr/) (deep only)                                               | `D:suj:obj`         | `1=suj, 2=obj, kind=deep`    |

### `basic`
|               Relation                                                                                  | Compact notation    |  Internal representation     |
|---------------------------------------------------------------------------------------------------------|---------------------|------------------------------|
| Simple relation                                                                                         | `obj`               | `rel=obj`                    |

Any other feature names (except a few reserved names) can be freely used in edge label representation.
But, if the internal representation does not correspond to one described in the tables above, there is not compact representation and the internal representation is used.

Reserved feature names are:

 * `label`: the syntax `e.label` is a shortcut to make reference to the full feature structure. It can be used for instance to copy the edge label from one edge `e` to antothe edge `f` with the command: `f.label = e.label`.
 * `length`: the syntax `e.length` is used to refer the distance (natural number) between two ordered nodes. The length of a relation between two consecutive nodes is 1.
 * `delta`: the syntax `e.delta` is used to refer the relative position (an integer) between two ordered nodes.



# Graph input formats
To describe a graph in practice, **Grew** offers several input formats:

 * [CoNLL-U format](../conllu)
 * a native `gr` format (TODO)
* the `amr` format (TODO)
