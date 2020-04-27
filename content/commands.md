+++
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""
date = "2017-05-15T21:43:09+02:00"
title = "Command syntax"
menu = "main"

+++

# Command syntax
Each rule contains a sequence of commands introduced by the keyword `commands`, separated by semicolon symbol `;` and surrounded by braces.

## Node deletion
The following command removes the A nodes and all its incident edges.
~~~grew
del_node A
~~~

## Node creation
To create a new node, the command is `add_node`.
The command below creates a new node and give it the identifier `A` until the end the rule application.

~~~grew
add_node A
~~~

Moreover, if the node must be placed at a specific position in the linear order of the nodes,  two syntax are available: the new node `B` (resp. `C`) is placed on the immediate left (resp. right) of the node `N`.
~~~grew
add_node B :< N
add_node C :> N
~~~

## Edge deletion
To delete an edge, the `del_edge` command can refer either to the full description of the edge or to an identifier `e` given in the pattern:

~~~grew
del_edge A -[obj]-> B;
del_edge e;
~~~

**NOTE**: for the first syntax, if the corresponding edge does not exists, an exception is raised and the full rewriting process is stopped.

## Add a new edge
There are two ways to add a new edge: with an given label edge or with a label edge coming from the pattern.

### Add a new edge with a given label
The syntax of the command is:
~~~grew
add_edge N -[suj]-> M
~~~

### Add a new edge with a label taken in the pattern
The command `add_edge e: N -> M` adds a new edge in the current graph from the node matched with identifier `N` to the node matched with identifier `M` with the same label as the edge that was match in the pattern with the edge identifier `e`.

There is an example on usage of the command [here](../complex_edges#reverse-an-edge).

## Edge redirection
Commands are available to move globally incident edges of some node of the pattern.
keywords are `shift_in`, `shift_out` and `shift`, respectively for moving in-edges, out-edges and all incident edges.

Brackets can be used to select the set of edges to move according to their labelling.

~~~grew
  shift A ==> B
  shift_out B =[suj|obj]=> C
  shift_in C =[^suj|obj]=> D
~~~

The action of the 3 commands above are respectively:

  * modifying all edges which are incident to `A`: any edge in the graph starting in `A` (resp. ending in `A`) is redirected to start in `B` (resp end in `B`).
  * modifying all out-edges which are starting in `B` with a `suj` or `obj` label: they are redirected to start in `C`.
  * modifying all in-edges which are ending in `B` with a label different from `suj` and `obj`: they are redirected to end in `D`.

# Effective commands
There are situations where commands may not be properly defined.
Consider the rule `r` below and and a graph with two nodes `A` and `B` linked by two edges `X` and `Y` both going from `A` to `B`.
The rule `R` can be applied to the graph but the command `add_edge` can not be applied (the edge labelled `Y` already exists).

```grew
rule r {
  pattern { N -[X]-> M }
  commands { add_edge N -[Y]-> M }
}
```

The fact that a rule is effective or not depends on the graph on which the rule is applied.


In fact, to deal with this case, **Grew** has two running modes with different behaviors.

 1. In the default mode, ineffective commands are simply ignored and the rewriting goes on with the next commands or rules.
 1. In the safe mode (set by the `-safe_commands` argument), an ineffective command stop the rewriting with and produces an exection error.

## List of ineffective Commands
Command which may be ineffective are:

 * `add_edge` when the edge is already present in the graph
 * `del_edge` when the edge does not exists in the graph
 * `del_node` when the node does not exists in the graph (this can happen when there are two commands `del_node A` in the same rule)
 * `del_feat` when the feat does not exists in the node

Note that it is always possible to define a Graph Rewriting System with only effective commands following the procedure:

 * a rule with an potential ineffective `add_edge` commands can be replaced by two rules, one with a `without` clause ensuring the absence of the edge and one without the `add_edge` command.
 * a rule with an potential ineffective `del_edge` commands can be replaced by two rules, one with the given edge in the pattern and one without the `del_edge` command.
 * an ineffective `del_node` command can be safely removed
 * a rule with an potential ineffective `del_feat` commands can be replaced by two rules, one with the feat in the pattern and one without the `del_feat` command.


