+++
date = "2017-05-29T18:30:19+02:00"
title = "new_grs"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""

+++

# GRS syntax

## Global structure
A GRS is composed by a set of declarations that may be provided in several files.
These files are expected to used the `.grs` or the `.dom` file extension.

Five kinds of declarations can be used:

  * **Feature domain** declarations (keyword `features`)
  * **Label domain** declarations (keyword `labels`)
  * **Rule** declaration (keyword `rule`)
  * **Strategy** declaration (keyword `strategy`)
  * **Package** declaration (keyword `package`)

The first two kinds (Feature domain and label domain) can only be used at the top level and they cannot be nested (see below the multi-file handling).

## Feature domains
In graphs and in rules, nodes contain feature structures.
To control these feature structures, a feature domain may be given first.
In the feature domain declaration, feature names are identifiers and are defined as:

  * **closed** feature accepts only an explicit given set of possible values (like the cat feature value below);
  * **open** feature name accepts any string value (like the lemma feature value below);
  * **numerical** feature (like the position feature below).

In closed features definition, feature values can be any strings; double quotes are required for string that are not lexical identifier (like values for pers).

:question: Explain merging of two feature domain declarations.


~~~grew
features {
  cat: n, np, v, adj;
  mood: inf, ind, subj, pastp, presp;
  lemma: STRING;
  phon: STRING;
  pers: "1","2","3";
  position: NUMERIC;
}
~~~

**REM:** values of pers feature are numerals but the only way to restrict to the finite domain {1, 2, 3} is to declare it as a closed feature and possible values as strings.

## Label domains
An explicit set of valid labels for edges may be given after the `labels` keyword.
It is possible to give several label domain declarations; the union of the different sets is then considered (:question: what about duplicates?, see [#4](https://gitlab.inria.fr/grew/libcaml-grew/issues/4)).

By default, edges are drawn with a black solid line and above the figure in DEP representation.

To modify the color or the position of the edges, the user can add attributes to a label with suffixes:

  * `@bottom` to put the label above
  * `@red`, `@blue`, … to modify the color of the link and the label
  * `@dot` or `@dash` to modify the style of the link

Several suffixes can be used simultaneously.

~~~grew
labels { OBJ, SUJ, DE_OBJ, ANT, ANT_REL@red, ANT_REP@blue@bottom@dash }
~~~
:warning: the color, style and position management will change soon (see [#5](https://gitlab.inria.fr/grew/libcaml-grew/issues/5))

## Rules
Rule declaration is introduced by the keyword `rule`. For the syntax, see [rule page](../rule).

## Strategies
Strategies are used specify the way rules are applied during transformation.
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

Other constructor are provided for some strategies
~~~grew
  Empty ≜ Seq()               % The Empty strategy always returns the input graph
  Try (S) ≜ If (S, S, Empty)  % Equivalent to S if S is productive else it returns the input graph
~~~

### Computing one normal form
To compute only one normal form with a strategy `S`, one can used the strategy: `Pick (Iter (S))`:
the strategy `Iter (S)` computes the full set of normal forms and the `Pick` operator choses one of them.
But this may be not efficient if the number of normal forms is high.

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

Note that it is not allowed to have a domain declaration inside a package.

## Multi-file management
When a GRS become large and contains an high number of rules, it is sensible to define it in through a set of files.
Two mechanisms are available for this purpose: external file import and external file inclusion.

### External file import
At any place in a list of declaration in a GRS file, one can use the syntax:

```grew
import "filename.grs"
```

This creates a new package with the same name as the file (without the `.grs` extension).
Hence, the meaning is the same as the following code:

```grew
package filename {
  <<< content of the file "filename.grs" >>>
}
```

As a consequence, it is not allowed to import a file which contains domain declarations because it would be equivalent to a domain declaration inside a package and this is forbidden.
To use a external domain declaration, one should use the file inclusion.

### External file inclusion
With file inclusion, the content of the external file is interpreted as if it was placed directly in the file at the same place.
In other words the code:
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
Consider a folder with the five files:

  * [`d_1.dom`](../examples/strategies/d_1.dom)
{{< grew file="/static/examples/strategies/d_1.dom" >}}

  * [`p_1.grs`](../examples/strategies/p_1.grs)
{{< grew file="/static/examples/strategies/p_1.grs" >}}

  * [`d_2.dom`](../examples/strategies/d_2.dom)
{{< grew file="/static/examples/strategies/d_2.dom" >}}

  * [`p_2.grs`](../examples/strategies/p_2.grs)
{{< grew file="/static/examples/strategies/p_2.grs" >}}

  * [`multi.grs`](../examples/strategies/multi.grs)
{{< grew file="/static/examples/strategies/multi.grs" >}}


### Single file declaration
The five files above define a GRS, equivalent to the one below:

  * [`single.grs`](../examples/strategies/single.grs)
{{< grew file="/static/examples/strategies/single.grs" >}}

Note that all the rules consist in the changement of the label of one edge.
Package `p_1` rewrites the label `L` into `L_1` and `L_1` into either `L_11` or `L_12`.
Similarly, package `p_2` rewrites the label `L` into `L_2` and `L_2` into either `L_21` or `L_22`.


### Apply the GRS to a graph

Consider small graph with 3 nodes and 2 edges labeled `L` defined in

[`input.gr`](../examples/strategies/input.gr):
{{< grew file="/static/examples/strategies/input.gr" >}}

Next commands rewrite the graph `input.gr`, following different strategies (:warning: the `-gr` options is needed to output graph in the native format instead of CoNLL-U)
#### strategy `p_1_nfs`

`grew transform -grs single.grs -strat p_1_nfs -i input.gr -gr` computes all normal forms for the input graph with rules of package `p_1`.
 Each initial edges `L` can be rewritten either `L_11` or `L_12`, and so 4 graphs are produced:
{{< grew file="/static/examples/strategies/p_1_nfs.out" >}}

#### strategy `p_1_onf`

`grew transform -grs single.grs -strat p_1_onf -i input.gr -gr` produces one of the 4 graphs of the previous strategy.
{{< grew file="/static/examples/strategies/p_1_onf.out" >}}

#### strategy `union`
`grew transform -grs single.grs -strat union -i input.gr -gr` compute the application of the union of one step of rewriting with `p_1` (which produces 2 graphs, replacing one the two `L` edge by `L_1` and the same with `p_2`. In the end, 4 graphs are produced (there is no iteration of rule application).
{{< grew file="/static/examples/strategies/union.out" >}}

#### strategy `all_nfs`
`grew transform -grs single.grs -strat all_nfs -i input.gr -gr` computes all normal forms that can be obtained with these all the rules and produces 16 graphs.
{{< grew file="/static/examples/strategies/all_nfs.out" >}}

