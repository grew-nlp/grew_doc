+++
Description = ""
Tags = ["Development", "golang"]
Categories = ["Development", "GoLang"]
menu = "main"
+++

# Example of edge feature updating

This example shows how `libcaml_grew` version `1.4.3` fixes [#23](https://gitlab.inria.fr/grew/libcaml-grew/-/issues/23).

In the GRS file below, the command update an edge feature, using both concatenation with the `+` symbol and reference to a lexicon.

{{< grew file="/static/gallery/update_edge_feature/update_edge_feature.grs" >}}

When applied to the sentence:

{{< input file="/static/gallery/update_edge_feature/fr-ud-test_00018.conllu" >}}

![fr-ud-test_00018](/gallery/update_edge_feature/_build/fr-ud-test_00018.svg)

It produces two graphs (because of the non functional lexicon).

{{< input file="/static/gallery/update_edge_feature/_build/output.conllu" >}}

| ![output_1](/gallery/update_edge_feature/_build/output_1.svg) | ![output_2](/gallery/update_edge_feature/_build/output_2.svg) |
|-|-|

