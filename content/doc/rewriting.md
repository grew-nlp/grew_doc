+++
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""
date = "2018-02-17T18:07:38+01:00"
title = "rewriting"
menu = "main"

+++

# Graph rewriting

## Terminology
 * Normal form
 * Confluent
 * Terminating

## Terminating and confluent system
When a GRS is **terminating** and **confluent**, we have the equivalence of the 4 strategies:

~~~grew
  Onf (S) ≃ Iter(S) ≃ Pick (Iter (S)) ≃ Iter (Pick (S))
~~~

They all compute one graph which is the unique normal form.
In this case, the strategy `Onf` should be used because it is the more efficient one.


## Terminating system
When a GRS is **terminating**, we have the equivalence of the two strategies:

~~~grew
  Onf (S) ≃ Pick (Iter (S))
~~~

See below for an example of non-terminating system where the equivalence does not hold.


## Example of non-terminating rewriting system

The following code described a non-terminating rewriting system:

```grew
package S {
  rule B2A { pattern { e: N -[B]-> M } commands { del_edge e; add_edge N -[A]-> M } }
  rule B2C { pattern { e: N -[B]-> M } commands { del_edge e; add_edge N -[C]-> M } }
  rule C2B { pattern { e: N -[C]-> M } commands { del_edge e; add_edge N -[B]-> M } }
  rule C2D { pattern { e: N -[C]-> M } commands { del_edge e; add_edge N -[D]-> M } }
}
```

Each rule replaces an edge label by another.
For instance, the rule `B2A` removes and edge with an `B` label and adds one with an `A` label.

Let `G_A`, `G_B`, `G_C` and `G_D` the 4 graphs with 2 nodes and 1 edge labelled `A`, `B`, `C` and `D` respectively.

The schema below shows how the 4 rules act on these 4 graphs:

![input.gr](/examples/non-term/xyz.svg)

### Applying `S` to `G_B`

 * The strategy `Iter (S)` applied to `G_B` produces the 2 graphs `G_A` and `G_D`.
 * The strategy `Pick (Iter (S))` applied to `G_B` may produce (unpredictably):
   * the graph `G_A`
   * the graph `G_D`
 * The strategy `Iter (Pick (S))` applied to `G_B` may produce (unpredictably):
   * the graph `G_A`
   * the graph `G_D`
   * the empty set
 * The strategy `Onf (S)` applied to `G_B` may lead to (unpredictably):
   * the output of the graph `G_A`
   * the output of the graph `G_D`
   * a non-terminating execution

Note that all unpredictable behavior will be identical from one execution to another with the same input data.
But, if the order of rules in the pacakge `S` is changed, the behavior may be different.






