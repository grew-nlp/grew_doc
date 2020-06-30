+++
Description = ""
Tags = ["Development", "golang"]
Categories = ["Development", "GoLang"]
menu = "main"
+++

# Transition to version 1.4

A new version 1.4 of **Grew** will be available in the upcoming weeks with a few changes in the syntax.

For some technical reason, the [**Grew-match**](http://match.grew.fr) online tool is already based on the upcoming version and so already uses the new syntax.
The `dev` version of the **Grew** API for **Arborator-Grew** also uses the new syntax.

## Clustering on the label of an edge

With the pattern:

```grew
pattern { e: M -> N; N [upos=ADJ]}
```

if you want to cluster the result on the label of the edge `e`, the old syntax was `e`, the new one is `e.label` ([Try it!](http://match.grew.fr/?corpus=SUD_French-GSD@latest&custom=5efb883ea71fc&clustering=e.label)).

## Access to the label of an edge in the pattern

|Constraint | Old syntax | New syntax |
|:-----------------:|:-----------------:|:-----------------:|
| equality of two edge labels | `label(e1) = label(e2)` |  `e1.label = e2.label` |
| inequality of two edge labels | `label(e1) <> label(e2)` |  `e1.label <> e2.label` |

## Avoiding duplicate solutions

When several nodes are equivalent in a pattern, each occurrence is reported several times (up to permutation on the set of equivalent nodes).
For instance, to search for two relations `det` with the same governor, the pattern below will return twice each solution.

```grew
pattern {
  G -[det]-> D1;
  G -[det]-> D2;
}
```

To avoid this, it is possible to give an ordering constraint on some internal identifier:

 * old_syntax: `id(D1) < id (D2)`
 * new_syntax: `D1.__id__ < D2.__id__`

The complete pattern in new syntax:

```grew
pattern {
  G -[det]-> D1;
  G -[det]-> D2;
  D1.__id__ < D2.__id__;
}
```

