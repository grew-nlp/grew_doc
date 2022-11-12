+++
date = "2020-05-09T17:49:29+02:00"
title = "upgrade"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""

+++

# Upgrade to Grew 1.4 (October 2020)

This page describes the breaking changes in **Grew** and provides the information needed to update a Graph Rewriting System and the CLI commands.
For older upgrading info, see [upgrade_old](../upgrade_old).

## CLI (Command Line Interface)

### the `-config` argument

See [here](../../usage/cli/#-config).
## GRS (Graph Rewriting System)

### Add a new edge with a label taken in the pattern

In the previous version, the syntax `add_edge e: N -> M` was used for adding a new edge between `N` and `M` with a label identical to the edge named `e` in the pattern.

In the 1.4 version, the semantic of the same syntax has changed.
Now, the syntax `add_edge e: N -> M` means: add a new edge between `N` and `M` and give it the **fresh** name `e`.

In order to have the same semantic as the previous version, the command:

```grew
add_edge e: N -> M;      # e being an edge declared in the pattern
```

must be replaced by:

```grew
add_edge f: N -> M;      # f is a fresh name
f.label = e.label;       # the label of f is set to be equal to the one of e.
```

Hopefully, this should not produce unexpected behaviour:

 * If the old syntax is used with the new **Grew** version (≥ 1.4), the error `ADD_EDGE_EXPL: the edge name 'e' already used` is reported.
 * If the new syntax is used with the old **Grew** version (< 1.4), the error `Unknown identifier "f"` is reported.



### Access to the label of an edge in the pattern

|Constraint | Old syntax | New syntax |
|:-----------------:|:-----------------:|:-----------------:|
| equality of two edge labels | `label(e1) = label(e2)` |  `e1.label = e2.label` |
| inequality of two edge labels | `label(e1) <> label(e2)` |  `e1.label <> e2.label` |

### Avoid duplicate matching solutions

When several nodes are equivalent in a pattern, each occurrence is reported several times (up to permutation on the set of equivalent nodes).
For instance, to search for two relations `det` with the same governor, the pattern below will return twice each solution.

```grew
pattern {
  G -[det]-> D1;
  G -[det]-> D2;
}
```

To avoid this, it is possible to give an ordering constraint on some internal identifier:

 * old_syntax: `id(D1) < id(D2)`
 * new_syntax: `D1.__id__ < D2.__id__`

The complete pattern in new syntax:

```grew
pattern {
  G -[det]-> D1;
  G -[det]-> D2;
  D1.__id__ < D2.__id__;
}
```


