+++
Description = ""
Tags = ["Development", "golang"]
Categories = ["Development", "GoLang"]
menu = "main"
+++

# Compute the connected components of a graph

The strategy `main` of the GRS below ([cc.grs](/gallery/connected_components/cc.grs)) outputs a set of graphs, each one being one of the connected components of the input graphs.

{{< grew file="/static/gallery/connected_components/cc.grs" >}}

---

## Explaining the GRS

Applied on a graph *G*, the GRS works as follow:

 1. Apply the `select_one` rule which output exactly one new graph for each connected component (see comments in rule for detail); in the graph one of the node of the selected connected component contained the features `select=yes`
 2. Apply iteratively the package `propagate` in order to mark all the node of the connected component with the feature `select=yes`
 3. Remove all unselected nodes that are not in the current connected component
 4. Remove the feature `select=yes` on all nodes

---

## Examples

### Basic two components graph

With the graph [`two_cc.json`](/gallery/connected_components/two_cc.json), and the command:

```
grew transform -grs cc.grs -i two_cc.json -json
```

We obtained two output graphs, one for each connected component in the input graph.

| Input | Output 1 | Output 2 |
|---|---|---|
| ![two_cc](/gallery/connected_components/_build/two_cc.svg) | ![cc1](/gallery/connected_components/_build/cc1.svg) | ![cc1](/gallery/connected_components/_build/cc2.svg) |

### Example with linguistic data

Starting with the sentence below:

![fr-ud-train_04997](/gallery/connected_components/_build/fr-ud-train_04997.svg)

We apply to it the following GRS which removes `appos` relations:

{{< grew file="/static/gallery/connected_components/del_appos.grs" >}}

We obtained the following structure:

![fr-ud-train_04997_split](/gallery/connected_components/_build/fr-ud-train_04997_no_appos.svg)

If we applied the GRS above, we obtained 3 small structures:

| cc1 | cc2 | cc3 |
|-----|-----|-----|
| ![cc1](/gallery/connected_components/_build/fr-ud-train_04997_cc1.svg) | ![cc2](/gallery/connected_components/_build/fr-ud-train_04997_cc2.svg) | ![cc3](/gallery/connected_components/_build/fr-ud-train_04997_cc3.svg)  |

