+++
date = "2017-05-29T18:30:19+02:00"
title = "new_grs"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""

+++

# GRS syntax

:warning: This page describes the new GRS syntax which is still in project :warning:

## Global structure
A GRS is composed by a set of declarations that may be provided in several files.
These files are expected to used the `.grs` of the `.dom` file extension.

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

It is common to compute one normal form with respect to a strategy `S`.
For instance, when one knows that the strategy is confluent, it is a much more efficient way to compute the unique normal form.
Some syntactic sugar is provided for this:
~~~grew
  Onf (S) ≜ Pick (Iter (S))   % Onf stands for 'One normal form'
~~~

Other constructor are provided for some strategies
~~~grew
  Empty ≜ Seq()               % The Empty strategy returns the input graph
  Try (S) ≜ If (S, S, Empty)  % Equivalent to S if S is productive else it returns the input graph
~~~



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

We consider the same GRS defined through the multi-file mechanism and with a single files.

### Multi-file declaration
Consider a folder with the five files:

  * `d_1.dom`

```grew
labels { E_1, E_11, E_12 }
```
  * `p_1.grs`

```grew
rule r_1  { pattern { e:X -[E]-> Y   } commands { del_edge e; add_edge X -[E_1]-> Y  } }
rule r_11 { pattern { e:X -[E_1]-> Y } commands { del_edge e; add_edge X -[E_11]-> Y } }
rule r_12 { pattern { e:X -[E_1]-> Y } commands { del_edge e; add_edge X -[E_12]-> Y } }
```

* `d_2.dom`

```grew
labels { E_2, E_21, E_22 }
```
* `p_2.grs`

```grew
rule r_2  { pattern { e:X -[E]-> Y   } commands { del_edge e; add_edge X -[E_2]-> Y  } }
rule r_21 { pattern { e:X -[E_2]-> Y } commands { del_edge e; add_edge X -[E_21]-> Y } }
rule r_22 { pattern { e:X -[E_2]-> Y } commands { del_edge e; add_edge X -[E_22]-> Y } }
```

  * `multi.grs`

```grew
labels { E }

include "d_1.dom"
include "d_2.dom"

import "p_1.grs"
import "p_2.grs"

strat p_1_nfs { Iter (p_1) }  % all normal forms with package p_1
strat p_1_onf { Onf (p_1) }   % one normal form with package p_1

strat union { Alt (p_1,p_2) } % union of the two set of rules
strat all_nfs { Iter (union)} % all normal forms

strat s_1 { Seq (Pick(p_1), Pick(p_2), all_nfs) }
```
### Single file declaration
The five files above define a GRS, equivalent to the one below:

  * `single.grs`

```grew
labels { E }

labels { E_1, E_11, E_12 }
labels { E_2, E_21, E_22 }

package p_1 {
  rule r_1  { pattern { e:X -[E]-> Y   } commands { del_edge e; add_edge X -[E_1]-> Y  } }
  rule r_11 { pattern { e:X -[E_1]-> Y } commands { del_edge e; add_edge X -[E_11]-> Y } }
  rule r_12 { pattern { e:X -[E_1]-> Y } commands { del_edge e; add_edge X -[E_12]-> Y } }
}

package p_2 {
  rule r_2  { pattern { e:X -[E]-> Y   } commands { del_edge e; add_edge X -[E_2]-> Y  } }
  rule r_21 { pattern { e:X -[E_2]-> Y } commands { del_edge e; add_edge X -[E_21]-> Y } }
  rule r_22 { pattern { e:X -[E_2]-> Y } commands { del_edge e; add_edge X -[E_22]-> Y } }
}

strat p_1_nfs { Iter (p_1) }  % all normal forms with package p_1
strat p_1_onf { Onf (p_1) }   % one normal form with package p_1

strat union { Alt (p_1,p_2) } % union of the two set of rules
strat all_nfs { Iter (union)} % all normal forms

strat s_1 { Seq (Pick(p_1), Pick(p_2), all_nfs) }
```

### Apply the GRS to a graphs

Consider the graph defined in `input.gr`:

```grew
graph {
  A -[E]-> B;
  B -[E]-> C;
}
```
