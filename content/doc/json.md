+++
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""
date = "2020-11-10T13:12:17+01:00"
title = "json"
menu = "main"

+++

# JSON format used in Grew

:warning: the format described here in not the one used for exchanges with the Python binding.

The JSON format described here is intended to be the exchange format between the various graph representations used in different existing projects.

A graph is described by a JSON object with the following fields:

 * `meta` (optional): an JSON object storing metadata at the graph level;
 * `nodes` (required): an JSON object for graph nodes;
 * `edges` (optional): an array for graph edges;
 * `order` (optional): an array of node identifiers (strings) describing the subset of nodes of the graph that are ordered.

## JSON encoding of nodes

Nodes are described by an JSON objects where keys are node identifiers and values describe the node content.

The node content can be in one of the two following forms:

 1. a string
 2. a JSON object in which all values are strings (in general this describes a feature structure).

The string form is used when the node does not have a complex structure. In this case, the given string is interpreted as a feature structure with only one feature named `label`. Hence we have:

  * `"nodes": { "N": "A" }` is equivalent to `"nodes": { "N": { "label" : "A" } }`

Nodes in CoNLL files are interpreted as complex node, for instance:

```
3	are	be	AUX	VA	Mood=Ind|Number=Plur|Tense=Pres|VerbForm=Fin	4	aux	_	_
```

will give the following JSON node object:
```json_alt
{
  "form": "are",
  "lemma": "be",
  "upos": "AUX",
  "xpos": "VA"
  "Mood": "Ind",
  "Number": "Plur",
  "Tense": "Pres",
  "VerbForm": "Fin",
},
```

## JSON encoding of an edge

An edge is described by a JSON object with three following required fields:

 * `src`: the node identifier of the source of the edge
 * `label`: a JSON object where all values are strings which encodes the edge feature structure
 * `tar`: the node identifier of the target of the edge

As for nodes, edges labels are described by a feature structure with a shortcut for simple labels.
Hence an edges label can be:

 1. a string
 2. a JSON object in which all values are strings (this describes a feature structure)

The string case is interpreted as a feature structure with on feature named `1` (to be compatible with complex edges used in UD / SUD encoding, see [Graph edges](../graph#edges) description).

  * `"edges": [ "src": "M", "label": "obj", "tar": "N" ]` is equivalent to `"edges": [ "src": "M", "label": { "1" : "obj" }, "tar": "N" ]`


## JSON encoding of a metadata

The meta data associated with a graph is a JSON object in which all values are strings.

## Nodes ordering

The field `order` must be a list of string, each string being a node identifier.

---

# Examples

## The empty graph

The empty graph is described by [`empty_graph.json`](empty_graph.json):

{{< json file="/static/doc/json/empty_graph.json" >}}

## Encoding of a non linguistic graph

|   {{< json file="static/doc/json/abc.json" >}}  |   ![abc](/doc/json/_build/abc.svg)  |
|-----|-----|

## Encoding of a CoNLL graph

{{< input file="static/doc/json/fr-ud-dev_00327.conllu" >}}

{{< json file="static/doc/json/_build/fr-ud-dev_00327.json" >}}

:warning: the feature `wordform` and `textform` are set when a CoNLL structure is loaded (see [CoNLL-U format](../conllu#additional-features-textform-and-wordform)).

