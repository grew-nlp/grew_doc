+++
date = "2017-05-29T18:30:19+02:00"
title = "new_grs"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""

+++

# GRS syntax

:warning: the syntax has changed since version 1.5. See the [end the page](#obsolete).

## Global structure
A GRS is composed by a set of declarations that may be provided in several files.
These files are expected to used the `.grs` file extension.

Three kinds of declarations can be used:

  * **Rule** declaration (keyword `rule`)
  * **Strategy** declaration (keyword `strategy`)
  * **Package** declaration (keyword `package`)

## Rules
Rule declaration is introduced by the keyword `rule`. For the syntax, see [rule page](../rule).

## Strategies
Strategies are used to specify the way rules are applied during transformation.
The syntax of strategies definition is:

~~~grew
strat strat_id {
  <<< strategy_description >>>
}
~~~

Strategy descriptions are defined by the following syntax:

~~~grew
  S ::= rule_id               % Apply the gives rule
      | package_id            % Apply any rule defined in the package (not in sub-packages)
      | strat_id              % Called a strategy defined elsewhere
      | Pick (S)              % Select arbitrary one of the graph produced by the strategy S
      | Alt (S_1, …, S_n)     % Collect graphs produced by each sub-strategies (union)
      | Seq (S_1, …, S_n)     % Apply sequentially S_1, then S_2 on S_1 output …
      | Iter (S)              % Iterate the application of the strategy S until normal forms
      | If (S, S_1, S_2)      % If S is productive then it is equivalent to S_1 else it is equivalent to S_2
~~~

Other constructors are provided for some strategies:
~~~grew
  Empty ≜ Seq()               % The Empty strategy always returns the input graph
  Try (S) ≜ If (S, S, Empty)  % Equivalent to S if S is productive else it returns the input graph
~~~

### Computing one normal form
To compute only one normal form with a strategy `S`, one can used the strategy: `Pick (Iter (S))`:
the strategy `Iter (S)` computes the full set of normal forms and the `Pick` operator choses one of them.
But this may be not efficient as all the normal forms are computed before picking one of them (the number of normal forms can be high).

For this case, another implementation of the rewriting is available with the operator `Onf` (the name stands for 'One normal form').
With this operator, only one normal form is built, and so :

~~~grew
  Onf (S) = Pick (Iter (S))
~~~

:warning: But `Onf` can be safely used only if the strategy is terminating. More info about this on the [rewriting page](../rewriting).



## Packages
Packages are used to organize the set of declarations and to define scopes of definitions.
Syntax of packages definition:

~~~grew
package package_id {
  declarations_list
}
~~~

where `declarations_list` is a list of declarations of **rules**, **packages** and **strategies**.

The syntax for accessing to some element `e` defined in package `P` is `P.e`.
In case of nested packages, an identifier may look like `P1.P2.P3.e`.
When a reference is made to an element `P1.P2.e`, the system tries to find inside the current package a sub-package `P1` which contains a sub-package `P2` which contains an element `e`.
If no such element is found, the same thing is searched recursively, first in the mother package of the current one, up to the root package.

## Multi-file management
When a GRS becomes large and contains an high number of rules, it is sensible to define it in several files.
Two mechanisms are available for this purpose: external file import and external file inclusion.

### External file import
At any place in a list of declaration in a GRS file, one can use the syntax:

```grew
import "filename.grs"
```

This creates a new package with the same name as the file (without the `.grs` extension).
Hence, the meaning of the code above is the same as the following code:

```grew
package filename {
  <<< content of the file "filename.grs" >>>
}
```

### External file inclusion
With file inclusion, the content of the external file is interpreted as if it was placed directly in the file at the same place.
In other words, the code:
```grew
include "filename.grs"
```
has the same meaning as

```grew
<<< content of the file "filename.grs" >>>
```

## A complete example

We consider the same GRS defined through the multi-file mechanism and with a single file.

### Multi-file declaration
Consider a folder with the files:

  * [`p_1.grs`](../grs/p_1.grs)
{{< grew file="/static/doc/grs/p_1.grs" >}}

  * [`p_2.grs`](../grs/p_2.grs)
{{< grew file="/static/doc/grs/p_2.grs" >}}

  * [`multi.grs`](../grs/multi.grs)
{{< grew file="/static/doc/grs/multi.grs" >}}


### Single file declaration
The five files above define a GRS, equivalent to the one below:

  * [`single.grs`](../grs/single.grs)
{{< grew file="/static/doc/grs/single.grs" >}}

Note that all the rules consist in the changement of the label of one edge.
Package `p_1` rewrites the label `L` into `L_1` and `L_1` into either `L_11` or `L_12`.
Similarly, package `p_2` rewrites the label `L` into `L_2` and `L_2` into either `L_21` or `L_22`.


### Apply the GRS to a graph

Consider small graph with 3 nodes and 2 edges labeled `L` defined in

[`input.gr`](../grs/input.gr):
{{< grew file="/static/doc/grs/input.gr" >}}

Next commands rewrite the graph [`input.gr`](../grs/input.gr), following different strategies (:warning: the `-gr` options is needed to output graph in the native format instead of CoNLL-U)

#### strategy `p_1_nfs`

`grew transform -grs single.grs -config basic -strat p_1_nfs -i input.gr -gr` computes all normal forms for the input graph with rules of package `p_1`.
 Each initial edges `L` can be rewritten either `L_11` or `L_12`, and so 4 graphs are produced:

{{< grew file="/static/doc/grs/_build/p_1_nfs.gr" >}}

#### strategy `p_1_onf`

`grew transform -grs single.grs -config basic -strat p_1_onf -i input.gr -gr` produces one of the 4 graphs of the previous strategy.
{{< grew file="/static/doc/grs/_build/p_1_onf.gr" >}}

#### strategy `union`
`grew transform -grs single.grs -config basic -strat union -i input.gr -gr` compute the application of the union of one step of rewriting with `p_1` (which produces 2 graphs, replacing one the two `L` edge by `L_1` and the same with `p_2`. In the end, 4 graphs are produced (there is no iteration of rule application).
{{< grew file="/static/doc/grs/_build/union.gr" >}}

#### strategy `all_nfs`
`grew transform -grs single.grs -config basic -strat all_nfs -i input.gr -gr` computes all normal forms that can be obtained with these all the rules and produces 16 graphs.
{{< grew file="/static/doc/grs/_build/all_nfs.gr" >}}


---
---

# Obsolete

In previous version, it was possible to define domains for features edges (introduced by the keyword `features`) and for edges labels (introduced by the keyword `labels`).

The notion of domain previously used before are not adapted to the new implementation.
The usage of configuration (see [here](../upgrade#the-config-argument)) replaces the obsolete domains.