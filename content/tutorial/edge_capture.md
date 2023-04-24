+++
title = "Tuto • Edge capture"
+++

• [:arrow_up: Top](../top) •

# Edge capture

This trap is linked to the fact that graphs cannot have two "identical" edges (same source, same target and same label), and the fact that commands are executed one after the other.

We use again the example of the page [Changing an edge label](../edge_label) and we consider the rule below:

{{< grew file="static/tutorial/edge_capture/change_features.grs" >}}

The rule `change_features` can be used for the following transformation:

| UD | SUD |
|----|-----|
| ![take_a_walk_UD](_build/take_a_walk.svg) | ![sud_take_a_walk](_build/take_a_walk_change_features.svg) |

## The trap

Now, let's change the input graph.


| input | Expected output | after `change_features` |
|----|-----|-----|
| ![trap](_build/trap.svg) | ![sud_take_a_walk](_build/trap_del_add.svg) | ![trap_change_features](_build/trap_change_features.svg) |

{{< tryit "http://transform.grew.fr/?corpus=https://grew.fr/tutorial/edge_capture/trap.conllu&grs=https://grew.fr/tutorial/edge_capture/change_features.grs" >}}

What happended?

As we said, commands are run one by one, after the application of the two first commands `e.1 = comp` and `e.2 = obj`, the label `e` has now the label `comp:obj` and is identical to the other edge from _take_ to _walk_ in the input graph. But there can not be several identical edges in a graph and so there is only **one** edge `comp:obj` from _take_ to _walk_ further modified by the last command `e.deep = lvc` producing the graph in the last column above.

To avoid the trap, one should use another alternative of writting the rule explained in page [Changing an edge label](../edge_label).
