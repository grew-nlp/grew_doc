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
The following command removes the A node and all its incident edges.
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

The basic syntax to add a new edge is:

~~~grew
add_edge N -[suj]-> M
~~~

It is also possible to give a name to the newly created edge, in order to manipulate it in the next commands.
For instance the two commands below create a new edge `f` and copy the edge label of some other edge `e`.

~~~grew
add_edge f: N -[suj]-> M;    % this supposes that `f` is a fresh name in the rule
f.label = e.label;           % this supposes that `e` is a known edge in the rule
~~~

**NB**: the syntax above (`add_edge f:…`) has changed in version 1.4, please see [here](../upgrade) for info about migration.

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

## Modification of an existing edge

In commands, it is possible to manipulate subpart of edges.
If the pattern binds the identifier `e` to some edge (with the syntax `e: X -[…]-> Y`), the following commands can be used:

 * `e.2 = aux`: update the current edge `e`
 * `add_edge X -[1=suj, 2=e.2]-> Z`: add a new edge where the value of feature `2` is copied from the value of feature `2` of edge `e`;
 * `del_feat e.deep`: remove the feature `deep` from the edge `e` (the edge is not removed);


---
---

## Example: copy an edge feature value

Rule: [`copy.grs`](/doc/commands/copy.grs):

{{< grew file="/static/doc/commands/copy.grs" >}}

| Input graph: [`copy.json`](/doc/commands/copy.json) | Rewritten graph |
|:---:|:---:|
| ![input](/doc/commands/_copy.svg) | ![output](/doc/commands/_copy_1_out.svg) |

---
---

The next couple of examples show that modifying an edge before copying it is different from the reverse order

## Example: modify and edge and copy it

Rule: [`modify_and_copy.grs`](/doc/commands/modify_and_copy.grs ):
{{< grew file="/static/doc/commands/modify_and_copy.grs" >}}

| Input graph: [`copy.json`](/doc/commands/copy.json) | Rewritten graph |
|:---:|:---:|
| ![input](/doc/commands/_copy.svg) | ![output](/doc/commands/_copy_2_out.svg) |

## Example: copy and edge and modify it

Rule: [`copy_and_modify.grs`](/doc/commands/copy_and_modify.grs ):
{{< grew file="/static/doc/commands/copy_and_modify.grs" >}}

| Input graph: [`copy.json`](/doc/commands/copy.json) | Rewritten graph |
|:---:|:---:|
| ![input](/doc/commands/_copy.svg) | ![output](/doc/commands/_copy_3_out.svg) |


---
---

## Example: reverse an edge

GRS: [`reverse.grs`](/doc/commands/reverse.grs ):
{{< grew file="/static/doc/commands/reverse.grs" >}}


| Input graph: [`reverse.json`](/doc/commands/reverse.json) | Rewritten graph |
|:---:|:---:|
| ![input](/doc/commands/_reverse.svg) | ![output](/doc/commands/_reverse_out.svg) |


By contrast, with the GRS: [`fail_reverse.grs`](/doc/commands/fail_reverse.grs ):
{{< grew file="/static/doc/commands/fail_reverse.grs" >}}

the command `grew transform -grs fail_reverse.grs` applied to the same graph produces the error:

``` MESSAGE : [file: fail_reverse.grs, line: 6] Unknown identifier "e" ```

---




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


