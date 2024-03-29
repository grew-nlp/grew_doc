+++
date = "2018-06-05T11:16:30+02:00"
title = "graphs"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""

+++

# Graphs definition
The graphs we consider in **Grew** are defined, as usual in mathematics, by two sets:

 * A set **N** of nodes
 * A set **E** of edges

## Nodes
A node is described by a an identifier (needed to refer to nodes in edge definitions) and a feature structure: a finite list of pairs (*feature_name*, *feature_value*).

In many linguistic structures, the notion of word order plays a crucial role.
To take this into account, nodes in a Grew graph are divided into two disjoint subsets:

 * totally ordered nodes (generally the words of a sentence)
 * non ordered nodes for other layers of information encoding (Examples: constituent nodes in phrase structure, nodes in AMR graphs, additional nodes encoding MWE in PARSEME graphs…)

In the [node creation command](../commands#node-creation) `add_node`, the user can choose to add an unordered node or to place the new node before or after a existing one.

## Edges
An edge is described by two nodes (called the *source* and the *target* of the edge) and by an edge label.

Before version 1.2, edge labels were atomic and had no internal structure.
This was not very convenient for dealing with complex edges:

  * in [UD](https://universaldependencies.org), the label `aux:pass` is a subtype of the label `aux`
  * in [SUD](https://surfacesyntacticud.github.io/), the label `compl:obl@agent` contains both a subtype `obl` and a deep feature `agent` (see [TLT 2019](https://hal.inria.fr/hal-02266003v1))
  * in [Deep-sequoia](https://deep-sequoia.inria.fr), the edge `suj:obj` means that the final function is `suj` and the canonical function is `obj`

In all these cases, with atomic edge labels, it is not possible to treat any part of the label independently.
Since version 1.2, the implementation of edge labels has changed to address this problem.
Edge labels are now coded as feature structures.

In **Grew** graphs, an edge label is stored internally as a flat feature structure or, in other words, as a finite set of couples `(f_1,v_1)` … `(f_k,v_k)` where all `f_i` are pairwise different.
We will use the traditional notation `f=v` for these pairs.

For backward compatibility and for ease of use in practice, a **compact** notation can be used for edge labels.

The correspondence between compact notation and feature structure depends on the `config` parameter.
Four predefined configurations are available: `ud`, `sud`, `sequoia` and `basic`.

The symbol `:` (used in `ud`, `sud` and `sequoia`) is interpreted as a separator, the left part is assigned feature name `1` and the right part is assigned feature name `2`.

Further examples of correspondence between compact and internal representation are given in the tables below.

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

All other feature names (except a few reserved names) can be used freely in the edge label representation.
However, if the internal representation does not correspond to one described in the tables above, there is no compact representation and the internal representation is used.

Reserved feature names are:

 * `label`: The syntax `e.label` is a shortcut to refer to the full feature structure. For example, it can be used to copy the edge label of an edge `e` to an edge `f` with the command: `f.label = e.label`.
 * `length`: The syntax `e.length` is used to refer to the distance (natural number) between two ordered nodes. The length of a relation between two consecutive nodes is 1.
 * `delta`: The syntax `e.delta` is used to denote the relative position (an integer) between two ordered nodes.
 * `__id__`: internal identifier, useful for dealing with subset of equivalent nodes in a request (see [here](../pattern#equivalent-nodes))

# Graph input formats
To describe a graph in practice, **Grew** offers several input formats:

 * [JSON](../json)
 * [CoNLL-U format](../conllu)
 * AMR format: **Grew** can also read data in the format used, for example, in corpora freely available on the [AMR website](https://amr.isi.edu/index.html).

# Graph output formats

 * [CoNLL-U](../conllu): this is the format used by default with `grew transform`
 * [JSON](../json): available with the `-json` argument on the command line
   * if the output contains one graph, the CoNLL code of the graph given
   * if the output contains zero or more than two graphs, a JSON list is returned
 * multi [JSON](../json): available with the `-multi_json` argument on the command line. Each graph is written is a separate file. With `grew transform … -o out.json -multi_json`, files will be named `out__0.json`, `out__1.json`…
 * Graphviz dot: available with `-dot` argument on the command line
