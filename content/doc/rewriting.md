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
When a GRS is **terminating** and **confluent**, we have the equivalence of the four strategies:

~~~grew
  Onf (S) ≃ Iter(S) ≃ Pick (Iter (S)) ≃ Iter (Pick (S))
~~~

They all compute one graph which is the unique normal form.
In this case, the `Onf` strategy should be used as it is the more efficient one.


## Terminating system
When a GRS is **terminating**, we have the equivalence of the two strategies:

~~~grew
  Onf (S) ≃ Pick (Iter (S))
~~~

Again, prefer the more efficient `Onf`.

See below for an example of a non-terminating system where the equivalence does not hold.

## Example of non-terminating rewriting system

The following code described a non-terminating rewriting system:

{{< grew file="/static/doc/rewriting/non_term.grs" >}}

Each rule replaces one edge label with another.
For example, the rule `B2A` removes an edge with a `B` label and adds one with an `A` label.

Let `G_A`, `G_B`, `G_C` and `G_D` be the four graphs with two nodes and one edge labelled `A`, `B`, `C` and `D` respectively.

The schema below shows how the four rules act on these four graphs:

![input.gr](/doc/rewriting/_build/non_term.svg)

### Applying `S` to `G_B`

 * The strategy `Iter (S)` applied to `G_B` produces the two graphs `G_A` and `G_D` (i.e. the two normal forms).
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
   * a non-terminating execution (in practice **Grew** tries to detect these cases and raises an error after a given number of rule applications)

In the last three cases, the output is unpredictable, but multiple executions with the same input data will give the same output.
However, if the order of the rules in the package `S` is changed, the behaviour may be different.
