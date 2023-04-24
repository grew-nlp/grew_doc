+++
title = "Gallery • span"
+++

[:arrow_up:](../top) Top
# Compute span of nodes in a dependency tree

This example illustrates the usage of non-injective matching introduced in version 1.11 (January 2023).

The objective is to add to each node, two new outgoing edges (labeled `span=left` and `span=right`) from the given node to its leftmost projection and rightmost projection respectively.

The main idea of the GRS is:
  1. add to each node two looping links `span=left` and `span=right` (rule `init` above)
  2. iteratively _enlarge_ the span of one node either on the left or on the right (package `enlarge` above): *"if one of my daughter node has a left [resp. right] span which is more on the left [resp. right] than mine, it become my new left [resp. right] span"*. When this last rule cannot be applied further, the spans are correcly computed.

The second item (for the left case) can be formulated in the Grew rule below, with nodes:
 - `N`: the current node where the span will be enlarge
 - `LN`: the left span of `N` before the application of the rule
 - `X`: the daughter of `N` having a left span `LX` which is more on the left than `LN`
 - `LX`: the left span of `X`

```grew
rule left {
  pattern { e: N -[span=left]-> LN; N -> X; X -[span=left]-> LX; LX << LN }
  commands { 
    del_edge e;
    add_edge N -[span=left]-> LX;
  }
}
```

The main difficulty is that we have to take into account some superposition subcases (NB: the other superposition cases cannot arise, the proof is left as an exercise!)
Possible cases are:
  1. all nodes are different
  1. `N` and `LN` refers to the same node
  1. `X` and `LX` refers to the same node
  1. (`N` and `LN` refers to the same node) and (`X` and `LX` refers to the same node)
  1. `LN` and `X` refers to the same node

When using only injective matching, we then have to design 10 rules (5 on the left and 5 on the right) for the `enlarge` package (see [below](.#solution-with-only-injective-matching)).

With non-injective matching (introduced in version 2.11), the same package can be written with only two rules.

## Solution with non-injective matching

With the grs file [non_injective.grs](../span/non_injective.grs):

{{< grew file="/static/gallery/span/non_injective.grs" >}}

{{< tryit "http://transform.grew.fr/?corpus=https://grew.fr/gallery/span/input.conllu&grs=https://grew.fr/gallery/span/non_injective.grs" >}}
⚠️ In **Grew-web**, dependency graphs are drawn with dep2pict and loops can not be displayed directly.
Loops are replaced by special features with a green background and with double brackets.
See for instance, the final graph computed with the example above:

![output](/gallery/span/graph_with_loops.svg)

## Solution with only injective matching

With the grs file [injective.grs](../span/injective.grs):

{{< grew file="/static/gallery/span/injective.grs" >}}

{{< tryit "http://transform.grew.fr/?corpus=https://grew.fr/gallery/span/input.conllu&grs=https://grew.fr/gallery/span/injective.grs" >}}

