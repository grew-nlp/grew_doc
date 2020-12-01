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

 * `meta` (optionl): an array of metadata stored at the graph level;
 * `nodes` (required): an array for graph nodes;
 * `edges` (optional): an array for graph edges;
 * `order` (optional): an array of node identifiers (strings) describing the subset of nodes of the graph that are ordered.

## JSON encoding of a node

A node is described by a JSON object in which all values are strings.
The field "id" is required and must be unique in the graph (TODO: test dup id).
Any number of others fields can be given (for instance for describing a feature structure)

## JSON encoding of an edge

A node is described by a JSON object with three following required fields:

 * `src`: the node identifier of the source of the edge
 * `label`: a JSON object where all values are strings which encodes the edge feature structure
 * `tar`: the node identifier of the target of the edge

## JSON encoding of a metadata

A metadata is a JSON object with two fields `key` and `value`, both being strings

---
# Examples

## The empty graph

The empty graph is described by [`empty_graph.json`](empty_graph.json):

{{< json file="/static/doc/json/empty_graph.json" >}}

## TBC