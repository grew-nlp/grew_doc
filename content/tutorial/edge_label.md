+++
title = "Tuto • Changing an edge label"
+++

• [:arrow_up: Top](../top) •

# Howto change an edge label

The goal of this page is to show a few ways **Grew** can be used to change the label of an edge in a graph.

In all examples above, we suppose that we want to change the UD-style label `obj:lvc` into the SUD-style one `comp:obj@lvc`.

| UD | SUD |
|----|-----|
| ![take_a_walk_UD](_build/take_a_walk.svg) | ![sud_take_a_walk](_build/take_a_walk_del_add.svg) |

Below, we show just one rule application, in real usage, such a rule should be used in a strategy `Onf` to deal with graph with zero on more then on occurrences of the `obj:lvc` relation.

## Remove and add

One way to code the transformation is to remove the old edge and add a new one with the new label.
The two rules above make this transformation whithout naming the old edge in the first case and with naming in the second.

{{< grew file="static/tutorial/edge_label/del_add.grs" >}}
{{< tryit "http://transform.grew.fr/?corpus=https://grew.fr/tutorial/edge_label/take_a_walk.conllu&grs=https://grew.fr/tutorial/edge_label/del_add.grs" >}}

{{< grew file="static/tutorial/edge_label/del_add_with_name.grs" >}}
{{< tryit "http://transform.grew.fr/?corpus=https://grew.fr/tutorial/edge_label/take_a_walk.conllu&grs=https://grew.fr/tutorial/edge_label/del_add_with_name.grs" >}}

## Modify the existing edge

Another way to encode the transformation is to keep the existing edge and to change its label.
The rule above does this with a command  `e.label = "…"` which update the whole label.

{{< grew file="static/tutorial/edge_label/change_whole_label.grs" >}}
{{< tryit "http://transform.grew.fr/?corpus=https://grew.fr/tutorial/edge_label/take_a_walk.conllu&grs=https://grew.fr/tutorial/edge_label/change_whole_label.grs" >}}

**NB**: the quote around `comp:obj@lvc` are required because of the special characters `:` and `@`.


Using the fact that edge labels are encoded as feature structures (see [here](../../doc/graph/#edges)), the edge label updating can be done by changing features.
The rule above makes the expected changes in three steps, changing features `1`, `2` and `deep` successively.

{{< grew file="static/tutorial/edge_label/change_features.grs" >}}
{{< tryit "http://transform.grew.fr/?corpus=https://grew.fr/tutorial/edge_label/take_a_walk.conllu&grs=https://grew.fr/tutorial/edge_label/change_features.grs" >}}

**NB** In order to have the expected behavior in the last example, the config must be set to `sud` (with the argument `-config sud` on the command line or with `grewpy.set_config ("sud")` in Python).
