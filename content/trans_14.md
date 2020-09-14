+++
Description = ""
Tags = ["Development", "golang"]
Categories = ["Development", "GoLang"]
menu = "main"
+++

# Transition to version 1.4

A new version 1.4 of **Grew** will be available in the upcoming weeks with a few changes in the syntax.

For some technical reason, the [**Grew-match**](http://match.grew.fr) online tool is already based on the upcoming version and so already uses the new syntax.
The **Grew** API for **Arborator-Grew** also uses the new syntax.

## Clustering on the label of an edge

With the pattern:

```grew
pattern { e: M -> N; N [upos=ADJ]}
```

if you want to cluster the result on the label of the edge `e`, the old syntax was `e`, the new one is `e.label` ([Try it!](http://match.grew.fr/?corpus=SUD_French-GSD@latest&custom=5efb883ea71fc&clustering=e.label)).
