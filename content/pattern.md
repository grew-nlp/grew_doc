+++
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""
date = "2017-05-22T23:01:05+02:00"
title = "pattern"
+++

# Pattern syntax

A Pattern is defined through 3 different parts that are all optional.

 * at most one positive clause introduced by keyword `pattern` which describes a positive pattern that must be find a the graph.
 * any number of nogative clauses introduced by the keyword `without`; each clause filters out a subpart of the matchings previously selected
 * :warning: New from version 1.2: at most one global clause introduced by the keyword `global` which filters out a subpart of graphs.

The global matching process is:

 * It takes a graph and a pattern as input.
 * It outputs a set of matchings; a matching being a function from nodes and edges defined in the positive clause to nodes and edges of the host graph.

 * If the graph does not satisfied one of the global constrains, the output is empty.
 * Else the set M is initialized as the set of matchings which satisfies the positive pattern.
    * For each negative clause, matchings which satisfies the negative pattern are removed from M.
 * Output M

Note that if there is more than one negative matching, there are all interpreted independently.

The basic syntax of patterns in grew can be learned using the tutorial part of the [Grew-match](http://match.grew.fr) tool.

## Positive pattern

## Negative pattern

## Global pattern
Global patterns were introduced in version 1.2 to let the user express constrain about the whole graph.
Currently, constraints may be expressed with a fixed list of keywords.
We plan to add more constraints in the near future. Please drop us a [feature request](https://gitlab.inria.fr/grew/grew/issues) if you like to suggest one.
We describe below 4 of the constraints available in version 1.2.
For each one, its negation is available by changing the `is_` prefix by the `is_not_` prefix.

  * `is_cyclic`: the graph satisfied this constrain if and only if it contains a cycle.
  A cycle is a list of nodes `N1`, `N2` … `N(k-1)`, `Nk` such that there are edges `N1 -> N2`, `N2 -> N3`, `N(k-1) -> Nk`, `Nk -> N1`.
  In graph theory, a non cyclic graph is also called a Directed Acyclic Graph (DAG).

  * `is_forest`: the graph satisfied this constrain if and only it is acyclic and if there are no couples of edges with the same target.
  In other words, a graph is a forest if and only if it is acyclic and each node has at most one incoming edge.

  * `is_tree`: a graph is a tree if it is a forest and if it have exactly one root.

  * `is_projective`: the usual notion of projectivity defined on tree is generalized by saying the a structure is projective if there are no 4-tuples (`A`, `B`, `C`, `D`) of ordered nodes (i.e. `A << B`, `B << C` and `C << D`) such that `A` and `C` are linked and `B` and `D` are linked (two nodes are linked when there is at least one edge between the two, whatever is the orientation).




