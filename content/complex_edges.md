+++
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
date = "2019-07-25T08:46:38+02:00"
title = "complex_edges"
Description = ""

+++

# Complex edges

:warning: Complex edges are available since version 1.2 (2019/03/26)

## Motivation
Before version 1.2, label edges were atomic and didn't have an internal structure.
This was not very convenient to deal with complex edges:

  * in [Deep-sequoia](deep-sequoia.inria.fr), the edge `suj:obj` means that the final function is `suj` and the canonical function is `obj`;
  * in [UD](https://universaldependencies.org), the label `aux:pass` is a subtype of the label `aux`;
  * in SUD, the label `compl:obl@agent` contains both a subtype `obl` and a deep feature `agent` (see TLT 2019).

In all these cases, with atomic edge labels, it is not possible to deal with one part of the label independently.
Since version 1.2, the implementation of label edges has changed to tackle this problem.

## Complex edges in graphs
In Grew graphs, an edge label is internally stored as a flat feature structure or, in other words, a finite set of couples `(f_1,v_1)` … `(f_k,v_k)` where all `f_i` are pairwise different.
We will use the traditional notation `f=v` for these couples.

In graph defined through CoNLL, we keep using the old syntax with symbols `:`and `@` with an implicit conversion:

  * the sub labels, separated by `:` and before `@` are transformed in numbered features following their position
  * the sub label after `@` is transformed in a `deep` feature

In Grew output, the reverse conversion is done.
If the conversion is not possible, a bracketed view of the edge is displayed

The table below shows the conversion of the 3 initial examples and a case where the conversion fails (last line).
Note that it is not possible to use a bracketed notation as an input file.

| Internal representation      | Label used in CoNNL |
|------------------------------|---------------------|
| `1=suj, 2=obj`               | `suj:obj`           |
| `1=aux, 2=pass`              | `aux:pass`          |
| `1=compl, 2=obl, deep=agent` | `compl:obl@agent`   |
| `2=obl`                      | `[2=obl]`           |

## Complex edges in patterns

In pattern, it is possible to match edges with a standard unification mechanism, similar to the one used for feature structures in nodes.
Some examples (with SUD labels) are given below.

| Syntax            | Description | `comp` | `comp:obl` | `comp:obl@agent` | `comp:aux` | `comp:obj@lvc` |
|-------------------|-------------|:------:|:----------:|:----------------:|:----------:|:----------:|
| `X -[1=comp]-> Y` | any edge such that the feature `1` is defined with value `comp` | YES | YES | YES |YES | YES |
| `X -[1=comp, 2=obl¦aux]-> Y`* | the feature `1` is defined with value `comp` and the feature `2` is defined with one of the two values `obl` or `aux` | NO | YES |YES |YES | NO|
| `X -[1=comp, 2<>obl¦aux]-> Y`* | the feature `1` is defined with value `comp` and the feature `2` is defined with a value different from `obl` or `aux` | NO | NO | NO | NO | YES |
| `X -[1=comp, !deep]-> Y` | the feature `1` is defined with value `comp` and the feature `deep` is not defined | YES | YES | NO |YES | NO|
| `X -[1=comp, 2=*]-> Y` | the feature `1` is defined with value `comp` and the feature `2` is defined with any value | NO | YES | YES |YES | YES|
| `X -[comp]-> Y` | the exact label `comp` and nothing else | YES | NO | NO | NO | NO |

\* replace the symbol `¦` by the pipe `|` symbol in Grew (the right symbol cannot be used in Markdown table!)

### :warning::warning: Matching with atomic labels :warning::warning:

It is important to note that from the pattern point of view, the two clauses `X -[1=comp]-> Y` (first line in the table) and `X -[comp]-> Y` (last line in the table) are not equivalent!

### Difference with node features matching

Note that we would expect that the syntax `X -[1=comp, 2]-> Y` should be equivalent to `X -[1=comp, 2=*]-> Y` but it will bring a ambiguity for `X -[lab]-> Y` that can be interpreted as the atomic label `X -[lab]-> Y` or as `X -[lab=*]-> Y`.
To avoid this ambiguity, the syntax `X -[1=comp, 2]-> Y` in not allowed.

## Complex edges in commands

In commands, it is possible to manipulate subpart of edges.
If the pattern binds the identifier `e` to some edge (with the syntax `e: X -[…]-> Y`), the following commands can be used:

 * `e.2 = aux`: update the current edge `e`
 * `add_edge X -[1=suj, 2=e.2]-> Z`: add a new edge where the value of feature `2` is copied from the value of feature `2` of edge `e`;
 * `del_feat e.deep`: remove the feature `deep` from the edge `e`;
 * `add_edge e: Y -> Z`: add a new edge with the same label as `e`;

Note that, if the identifier `e` is used several times in the commands of a same rule, each occurrence refers to the "current" `e` edge eventually modified by previous commands.

## Examples

### Modify and copy an edge

Rule: [`mod_copy.grs`](../complex_edges/mod_copy.grs):
{{< grew file="/static/complex_edges/mod_copy.grs" >}}

Command: `grew transform -grs mod_copy.grs -strat "Onf(mod_copy)"`

Input graph: [`mod_copy.gr`](../complex_edges/mod_copy.gr)

| ![input](/complex_edges/_mod_copy_in.svg) | ![output](/complex_edges/_mod_copy_out.svg) |
|:---:|:---:|

Observe the difference if the two commands are swapped:

Rule: [`copy_mod.grs`](../complex_edges/copy_mod.grs):
{{< grew file="/static/complex_edges/copy_mod.grs" >}}

Command: `grew transform -grs copy_mod.grs -strat "Onf(copy_mod)"`

Input graph: [`copy_mod.gr`](../complex_edges/copy_mod.gr)

| ![input](/complex_edges/_copy_mod_in.svg) | ![output](/complex_edges/_copy_mod_out.svg) |
|:---:|:---:|


### Reverse an edge

Rule: [`reverse.grs`](../complex_edges/reverse.grs):
{{< grew file="/static/complex_edges/reverse.grs" >}}

Command: `grew transform -grs reverse.grs -strat "Onf(reverse)"`

Input graph: [`reverse.gr`](../complex_edges/reverse.gr)
{{< grew file="/static/complex_edges/reverse.gr" >}}

| ![input](/complex_edges/_reverse_in.svg) | ![output](/complex_edges/_reverse_out.svg) |
|:---:|:---:|

By contrast, with the rule [`fail_reverse.grs`](../complex_edges/fail_reverse.grs):
{{< grew file="/static/complex_edges/fail_reverse.grs" >}}

the command `grew transform -grs fail_reverse.grs -strat "Onf(fail_reverse)"` applied to the same graph produces the error:

```[file: fail_reverse.grs, line: 3] ADD_EDGE_EXPL: the edge identifier 'e' is undefined```

The `add_edge` command cannot be executed because the edge `e` does not exist anymore.
Note that with previous Grew versions, the rule `fail_reverse` can be applied and hence, it may be needed to update existing rule systems.

### Copy a feature value (since v1.4)

Rule: [`copy_sub.grs`](../complex_edges/copy_sub.grs):
{{< grew file="/static/complex_edges/copy_sub.grs" >}}

Command: `grew transform -grs copy_sub.grs -strat "Onf(copy_sub)"`

Input graph: [`copy_sub.gr`](../complex_edges/copy_sub.gr)
{{< grew file="/static/complex_edges/copy_sub.gr" >}}

| ![input](/complex_edges/_copy_sub_in.svg) | ![output](/complex_edges/_copy_sub_out.svg) |
|:---:|:---:|

