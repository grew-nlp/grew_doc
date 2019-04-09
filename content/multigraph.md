+++
date = "2019-04-08T18:48:36+02:00"
title = "multigraph"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""

+++

# Multigraph representation

A multigraph is used to encode in the same structure several alternative annotations of the same sentence.
All the annotated graphs are put in the same graph and a special copy of the graph (called the *skeleton*) is added.
The skeleton encodes the parallelism between subgraphs.

With the two annotations of the sentence *Je suis une licorne*:

| `kim` | `marine` |
|:---:|:---:|
| ![kim.svg](/multigraph/kim.svg) | ![marine.svg](/multigraph/marine.svg) |

The figure below shows the multigraph encoding these two annotations:

| `mutligraph` |
|:---:|
| ![mugraph.svg](/multigraph/multigraph.png) |

# Searching in multigraphs

## Parallel nodes with different upos

```grew
pattern {
	NS -[user=*]-> N1; NS -[user=*]-> N2; % N1 and N2 are parallel
	N1.upos <> N2.upos;                   % N1 and N2 have ≠ upos features
	id(N1) < id(N2);                      % force internal identifiers ordering to avoid duplicates
}
```

output:

```json
{ "nodes": { "NS": "_2_", "N2": "marine_2", "N1": "kim_2" }, "edges": {} }
```

## Parallel edges with different labels

```grew
pattern {
	NS -[user=*]-> N1; NS -[user=*]-> N2; % N1 and N2 are parallel
	MS -[user=*]-> M1; MS -[user=*]-> M2; % M1 and M2 are parallel
	e1: M1 -> N1; e2: M2 -> N2;           % M and N are linked by parallel edges
	label(e1) <> label(e2);               % labels must be different
	id(N1) < id(N2);                      % avoid duplicates (1/2 switching)
}
```

output:

```json
{
  "nodes": {
    "NS": "_3_",
    "N2": "marine_3",
    "N1": "kim_3",
    "MS": "_4_",
    "M2": "marine_4",
    "M1": "kim_4"
  },
  "edges": {
    "e1": { "source": "kim_4", "label": "case", "target": "kim_3" },
    "e2": { "source": "marine_4", "label": "det", "target": "marine_3" }
  }
}
```

## Parallel nodes with different governors

```grew
pattern {
	NS -[user=*]-> N1; NS -[user=*]-> N2; % N1 and N2 are parallel
	e1: G1 -> N1;                         % G1 is the governor of N1
	e2: G2 -> N2;                         % G2 is the governor of N2
	id(G1) < id(G2);                      % avoid duplicates (1/2 switching)
}
without {
	GS -> G1; GS -> G2                    % G1 and G2 are not parallel
}
```

outputs 2 solutions:

```json
{
  "nodes": {
    "NS": "_4_",
    "N2": "marine_4",
    "N1": "kim_4",
    "G2": "marine_2",
    "G1": "kim_ROOT"
  },
  "edges": {
    "e1": { "source": "kim_ROOT", "label": "root", "target": "kim_4" },
    "e2": { "source": "marine_2", "label": "obj", "target": "marine_4" }
  }
}
```

```json
{
  "nodes": {
    "NS": "_2_",
    "N2": "marine_2",
    "N1": "kim_2",
    "G2": "marine_ROOT",
    "G1": "kim_4"
  },
  "edges": {
    "e1": { "source": "kim_4", "label": "cop", "target": "kim_2" },
    "e2": { "source": "marine_ROOT", "label": "root", "target": "marine_2" }
  }
}
```

## Usual patterns

If a usual pattern is searched in a multigraph, the results is the union of matchings in underlying graphs.

```grew
pattern { N[upos=NOUN]; e: N -> M; }
```

outputs 3 solutions:
```json
{
  "nodes": { "N": "marine_4", "M": "marine_3" },
  "edges": { "e": { "source": "marine_4", "label": "det", "target": "marine_3" } }
}
```

```json
{
  "nodes": { "N": "kim_4", "M": "kim_3" },
  "edges": { "e": { "source": "kim_4", "label": "case", "target": "kim_3" } }
}
```

```json
{
  "nodes": { "N": "kim_4", "M": "kim_2" },
  "edges": { "e": { "source": "kim_4", "label": "cop", "target": "kim_2" } }
}
```



