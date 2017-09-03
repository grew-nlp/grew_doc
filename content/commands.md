+++
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""
date = "2017-05-15T21:43:09+02:00"
title = "Command syntax"
menu = "main"

+++

# Command syntax
Each rule contains a sequence of commands introduced by the keyword `commands`, separated by semicolon symbol ; and surrounded by braces.

## Node deletion
This following command removes the A nodes and all its incident edges.
~~~grew
del_node A
~~~

## Node creation
To create a new node, the command is `add_node`.
The command below create a new node and give it the identifier `A` until the end the rule application.

~~~grew
add_node A
~~~

Moreover, if the node must be placed at a specific position in the linear order of the nodes, the two syntax are available: the new node `B` (resp. `C`) is placed on the immediate left (resp. right) of the node `N`.
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
The command `add_edge e: N -> M` add a new edge in the current graph from the node matched with indentifier `N` to the node matched with indentifier `M` with the same label as the edge that was match in the pattern with the edge indentifier `e`.

#### Example:
`add_edge_pattern.grs`:
~~~grew
module deterministic M {
  rule r {
    match { A[phon=A]; B[phon=B]; e: B -> A }
    commands { del_edge e; add_edge e: A -> B }
  }
}
sequences { main { M }}
~~~

`input.gr`:
~~~grew
graph {
   A [phon="A"];
   B [phon="B"];
   B -[x]-> A;
   B -[y]-> A;
   B -[z]-> A;
}
~~~

With the command `grew -det -grs add_edge_pattern.grs -gr input.gr -o output.gr`, the rewriting will produce the graph `output.gr` below.

| `input.gr` | `output.gr` |
|:---:|:---:|
| ![input.gr](/examples/add_edge_pattern/in.svg) | ![output.gr](/examples/add_edge_pattern/out.svg) |

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



