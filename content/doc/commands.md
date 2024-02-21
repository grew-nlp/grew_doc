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

---

## Edge deletion
To delete an edge, the `del_edge` command can refer either to the full description of the edge or to an identifier `e` given in the request:

~~~grew
del_edge X -[obj]-> Y;
del_edge e;
~~~

For the first syntax, if the corresponding edge does not exists, an exception is raised and the full rewriting process is stopped.

---

## Add a new edge

The basic syntax to add a new edge is:

~~~grew
add_edge X -[suj]-> Y
~~~

It is also possible to give a name to the newly created edge, in order to manipulate it in the next commands.
For instance the two commands below create a new edge `f` and copy the edge label of some other edge `e`.

~~~grew
add_edge f: X -> Y;    % this supposes that `f` is a fresh name in the rule
f.label = e.label;     % this supposes that `e` is a known edge in the rule
~~~

**NB**: the syntax above (`add_edge f:…`) has changed in version 1.4, please see [here](../upgrade) for info about migration.

---

## Node deletion
The following command removes the node `X` and all its incident edges.
~~~grew
del_node X
~~~

---

## Node creation
To create a new node, the command is `add_node`.
The command below creates a new node and give it the identifier `X` until the end the rule application.

~~~grew
add_node X
~~~

Moreover, if the node must be placed at a specific position in the linear order of the nodes, two syntax are available:
the new node `Y` (resp. `Z`) is placed on the immediate left (resp. right) of the node `X`.
~~~grew
add_node Y :< X
add_node Z :> X
~~~

---

## Shifting (edge redirection)
Commands are available to move globally incident edges of some node of the pattern.
Keywords are `shift_in`, `shift_out` and `shift`, respectively for moving in-edges, out-edges and all incident edges.

Brackets can be used to select the set of edges to move according to their labelling.

:warning: edges between two nodes matched by the pattern are not changed by `shift` rules.
The only edges that are moved are edges linking one node of the pattern and one node which is not in the pattern.

~~~grew
  shift X ==> Y
  shift_out X =[suj|obj]=> Y
  shift_in X =[^suj|obj]=> Y
~~~

The action of the 3 commands above are respectively:

  * modifying edges which are incident to `X`: any edge in the graph starting in `X` (resp. ending in `X`) is redirected to start in `Y` (resp end in `Y`).
  * modifying out-edges which are starting in `X` with a `suj` or `obj` label: they are redirected to start in `Y`.
  * modifying in-edges which are ending in `X` with a label different from `suj` and `obj`: they are redirected to end in `Y`.

---

## Add or update a node feature

The following commands update the feature `f` of the node `X`.
If the node `X` does not have such a feature, it is added.

~~~grew
X.f = "new_value"    % give a new value
X.f = Y.f            % copy a feature value from another node
~~~

It is possible to use the `+` symbol for string concatenation:

~~~grew
X.f = Y.f + "/" + Y.lemma
~~~

:new: in version 1.8: A [Python like slicing](https://www.w3schools.com/python/python_strings_slicing.asp) can be added in the right-hand side of the updating command.
~~~grew
X.f = Y.f[1:]          % copy `Y.f` on node `X`, skipping the first character
X.f = Y.f[:-1] + X.f   % prepend `Y.f` (without the last character) to `X.f`
~~~

**NB**: the indexes used in slicing refers the UFT-8 characters. If `X.form` is `"помощник"` then `X.form[2:4]` is `"мо"`

---

## Remove a node feature

~~~grew
del_feat X.f
~~~

---

## Modification of an existing edge

In commands, it is possible to manipulate subpart of edges.
If the request binds the identifier `e` to some edge (with the syntax `e: X -[…]-> Y`), the following commands can be used:

 * `e.2 = aux` &rarr; update the current edge `e`
 * `add_edge X -[1=suj, 2=e.2]-> Z`  &rarr;  add a new edge where the value of feature `2` is copied from the value of feature `2` of edge `e`;
 * `del_feat e.deep`  &rarr;  remove the feature `deep` from the edge `e` (the edge is not removed, even if its label is an empty feature structure);

---

## Changing nodes order

Change an ordered node into an unordered node

~~~grew
unorder X
~~~

Change an unordered node into an ordered node

~~~grew
insert X :> Y  % put the unordered node X right after the node Y 
insert X :< Y  % put the unordered node X right before the node Y 
~~~

The two commands `unorder` and `insert` can be used together to move a node. For instance the next rule exchanges the positions of `X1` and `X2`

~~~grew
rule ex {
  pattern { X1 [upos=VERB]; X2 [upos=ADV]; X1 < X2 }
  commands { unorder X1; insert X1 :> X2 }
}
~~~

## Copy several features from one node to another

The commands `append_feats X ==> Y` / `prepend_feats X ==> Y` appends / prepends all features (different from `form`, `lemma`, `upos`, `xpos`) of node `X` to features of node `Y`.

To be more precise, the commands `append_feats X ==> Y` / `prepend_feats X ==> Y` modify the feature structure of node `Y`:
 * if the same feature `f` is defined for both nodes, same effect as: `Y.f = Y.f + X.f` for `append_feats` and `Y.f = X.f + Y.f` for `prepend_feats`.
 * if the feature `f` is defined in `X` only, same effect as: `Y.f = X.f`
 * other features of `Y` are unchanged

It is also possible to add a string separator for feature values concatenation.
The command `append_feats "/" X ==> Y` will have the same effect as `Y.f = Y.f + "/" + X.f` when `f` is defined in both nodes.

This can be used to clone a node. The command below clones the node `Y` into a new node, called `X` in the rule, such that `X` follows `Y`.
A new edge `copy` is added from `Y` to its clone.

~~~grew
rule clone {
  pattern { X [form, lemma, upos=VERB]; }
  commands {
    add_node M :> X;
    append_feats X ==> Y;
    Y.form = X.form; Y.lemma = X.lemma; Y.upos = X.upos;
    add_edge X -[copy]-> Y;
  }
}
~~~

With the syntax below, the set of features taken into account can be filtered with a regexp:

~~~grew
append_feats X1 =[re"Number\|Gender"]=> X2;
prepend_feats X3 =[re"Gloss"]=> X4;
~~~

---
---
# Examples


## Example 1: copy an edge feature value

Rule: [`copy.grs`](/doc/commands/copy.grs):

{{< grew file="/static/doc/commands/copy.grs" >}}

| Input graph: [`copy.json`](/doc/commands/copy.json) | Rewritten graph |
|:---:|:---:|
| ![input](/doc/commands/_build/copy.svg) | ![output](/doc/commands/_build/copy_1_out.svg) |



## Example 2: modify and edge and copy it

This example and the next one show that modifying an edge before copying it is different from the reverse order

Rule: [`modify_and_copy.grs`](/doc/commands/modify_and_copy.grs ):
{{< grew file="/static/doc/commands/modify_and_copy.grs" >}}

| Input graph: [`copy.json`](/doc/commands/copy.json) | Rewritten graph |
|:---:|:---:|
| ![input](/doc/commands/_build/copy.svg) | ![output](/doc/commands/_build/copy_2_out.svg) |

## Example 2bis: copy and edge and modify it

Rule: [`copy_and_modify.grs`](/doc/commands/copy_and_modify.grs ):
{{< grew file="/static/doc/commands/copy_and_modify.grs" >}}

| Input graph: [`copy.json`](/doc/commands/copy.json) | Rewritten graph |
|:---:|:---:|
| ![input](/doc/commands/_build/copy.svg) | ![output](/doc/commands/_build/copy_3_out.svg) |

## Example 3: reverse an edge

GRS: [`reverse.grs`](/doc/commands/reverse.grs ):
{{< grew file="/static/doc/commands/reverse.grs" >}}


| Input graph: [`reverse.json`](/doc/commands/reverse.json) | Rewritten graph |
|:---:|:---:|
| ![input](/doc/commands/_build/reverse.svg) | ![output](/doc/commands/_build/reverse_out.svg) |


By contrast, with the GRS: [`fail_reverse.grs`](/doc/commands/fail_reverse.grs ):
{{< grew file="/static/doc/commands/fail_reverse.grs" >}}

the command `grew transform -grs fail_reverse.grs` applied to the same graph produces the error:

``` MESSAGE : [file: fail_reverse.grs, line: 6] Unknown identifier "e" ```

## Example 4: shifting

GRS: [`shift.grs`](/doc/commands/shift.grs ):
{{< grew file="/static/doc/commands/shift.grs" >}}

| Input graph: [`shift.json`](/doc/commands/shift.json) | after one command | after two commands | Rewritten graph |
|:---:|:---:|:---:|:---:|
| ![input](/doc/commands/_build/shift.svg) | ![step1](/doc/commands/_build/shift_one.svg) | ![step2](/doc/commands/_build/shift_two.svg) | ![output](/doc/commands/_build/shift_rewritten.svg) |


---
---

# Effective commands

There are situations where the actions commands may be difficult to define.
Consider the rule `r` below and and a graph with two nodes `A` and `B` linked by two edges `X` and `Y` both going from `A` to `B`.
The rule `r` can be applied to the graph but the command `add_edge` can not be applied (the edge labelled `Y` already exists).

```grew
rule r {
  pattern { N -[X]-> M }
  commands { add_edge N -[Y]-> M }
}
```

The fact that a rule is effective or not depends on the graph on which the rule is applied.


In fact, to deal with this case, **Grew** has two running modes with different behaviors.

 1. In the default mode, ineffective commands are simply ignored and the rewriting goes on with the next commands or rules.
 1. In the safe mode (set by the `-safe_commands` argument), an ineffective command stop the rewriting with and produces an execution error.

## List of ineffective Commands
Commands which may be ineffective are:

 * `add_edge` when the edge is already present in the graph
 * `del_edge` when the edge does not exists in the graph
 * `del_feat` when the feat does not exists in the node
 * feature updating, like `X.f=v` if the node `X` already have a feature `f` with value `v` (same with `e.f=v` for and edge `e` already having a feature `f` with value `v`).

Note that it is always possible to define a Graph Rewriting System with only effective commands following the procedure:

 * a rule with an potential ineffective `add_edge` commands can be replaced by two rules, one with a `without` clause ensuring the absence of the edge and one without the `add_edge` command.
 * a rule with an potential ineffective `del_edge` commands can be replaced by two rules, one with the given edge in the request and one without the `del_edge` command.
 * a rule with an potential ineffective `del_feat` commands can be replaced by two rules, one with the feature in the request and one without the `del_feat` command.
 * a ineffective feature updating can be avoided with a clause `X.f<>v` or a `X.f=v` in a without clause.


