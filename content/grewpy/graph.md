---
title: "Grewpy • graph"
date: 2023-08-14
---

# `grewpy` library: Graph module

First, we import the `Graph` module from `grewpy`.

**NB:** The port number is different at each execution. If you don't have this kind of output, see [here](http://localhost:1313/usage/python/#install).

```python_alt
from grewpy import Graph
```

    connected to port: 60202

## Build a graph

A graph can be built from its JSON encoding (see [here](../../doc/json) for more info about this format)

```python_alt
g1_str = """
{
  "nodes": {
    "A": "A",
    "B": "B",
    "C": "C"
  },
  "edges": [
    { "src": "A", "label": "X", "tar": "B"},
    { "src": "A", "label": "XX", "tar": "B"},
    { "src": "B", "label": "Y", "tar": "C"},
    { "src": "C", "label": "Z", "tar": "A"}
  ],
  "order": [ "A", "B" ]
}
"""
g1 = Graph(g1_str)
```

A graph can be built from its CoNLL data.

```python_alt
g2_conll = """# sent_id = en_partut-ud-202
# text = The work is done.
1	The	the	DET	RD	Definite=Def|PronType=Art	2	det	_	_
2	work	work	NOUN	S	Number=Sing	4	nsubj:pass	_	_
3	is	be	AUX	VA	Mood=Ind|Number=Sing|Person=3|Tense=Pres|VerbForm=Fin	4	aux:pass	_	_
4	done	do	VERB	V	Tense=Past|VerbForm=Part	0	root	_	SpaceAfter=No
5	.	.	PUNCT	FS	_	4	punct	_	_

"""
g2 = Graph(g2_conll)
```

## Functions on graphs

The length (`len`) of a graph is the number of nodes.
Note that when a graph is built from CoNLL data an *anchor* node is added at position 0, that's why `len(g2)` is 6 and not 5.

```python_alt
len (g1), len(g2)
```

    (3, 6)

```python_alt
print (g2.to_conll())
```

    # sent_id = en_partut-ud-202
    # text = The work is done.
    1	The	the	DET	RD	Definite=Def|PronType=Art	2	det	_	_
    2	work	work	NOUN	S	Number=Sing	4	nsubj:pass	_	_
    3	is	be	AUX	VA	Mood=Ind|Number=Sing|Person=3|Tense=Pres|VerbForm=Fin	4	aux:pass	_	_
    4	done	do	VERB	V	Tense=Past|VerbForm=Part	0	root	_	SpaceAfter=No
    5	.	.	PUNCT	FS	_	4	punct	_	_
    

```python_alt
print (g2.to_dot())
```

    digraph G{
    0[label="form:__0__"];
    1[label="Definite:Def,PronType:Art,form:The,lemma:the,textform:The,upos:DET,wordform:The,xpos:RD"];
    2[label="Number:Sing,form:work,lemma:work,textform:work,upos:NOUN,wordform:work,xpos:S"];
    3[label="Mood:Ind,Number:Sing,Person:3,Tense:Pres,VerbForm:Fin,form:is,lemma:be,textform:is,upos:AUX,wordform:is,xpos:VA"];
    4[label="SpaceAfter:No,Tense:Past,VerbForm:Part,form:done,lemma:do,textform:done,upos:VERB,wordform:done,xpos:V"];
    5[label="form:.,lemma:.,textform:.,upos:PUNCT,wordform:.,xpos:FS"];
    4 -> {'1': 'punct'}[label="5"];
    4 -> {'1': 'aux', '2': 'pass'}[label="3"];
    4 -> {'1': 'nsubj', '2': 'pass'}[label="2"];
    2 -> {'1': 'det'}[label="1"];
    0 -> {'1': 'root'}[label="4"];
    }

```python_alt
import json
print (json.dumps(g1.json_data(), indent=2))

```

    {
      "nodes": {
        "A": "A",
        "B": "B",
        "C": "C"
      },
      "edges": [
        {
          "src": "A",
          "label": "X",
          "tar": "B"
        },
        {
          "src": "A",
          "label": "XX",
          "tar": "B"
        },
        {
          "src": "B",
          "label": "Y",
          "tar": "C"
        },
        {
          "src": "C",
          "label": "Z",
          "tar": "A"
        }
      ],
      "order": [
        "A",
        "B"
      ],
      "meta": {}
    }

## Internal representation of graphs

Internally a graph is encoded with four elements:
 - a dict `features` which maps each node identifier to either a string or a dictionary encoding the feature structure of the node
 - a dict `sucs` which maps each node indentifier to a list of outgoing edges, each edge is a pair with the target node and the edge label
 - a list named `order` which describes the list of strictly ordered nodes
 - a dict `meta` which describes the meta data of the graphs (keys and values are strings)

### `features`
The `features` dictionary is the one get by default when accessing a graph.
The two expressions above are equal:

```python_alt
g1["A"], g1.features["A"]
```

    ('A', 'A')

For simple graphs as above, a *feature* is a only a string but when there is a more complex feature structure, it is a dict:

```python_alt
g2["2"]
```

    {'Number': 'Sing',
     'form': 'work',
     'lemma': 'work',
     'textform': 'work',
     'upos': 'NOUN',
     'wordform': 'work',
     'xpos': 'S'}

### `sucs`

Each node is given a list of *successors* decribed by pairs of the target node and the edge label. 
Edga label are dictionaries (see [here](../../doc/graph/#edges) for details about edge label encoding.)

```python_alt
g1.sucs["A"]
```

    [('B', {'1': 'X'}), ('B', {'1': 'XX'})]

```python_alt
g2.sucs["4"]
```

    [('5', {'1': 'punct'}),
     ('3', {'1': 'aux', '2': 'pass'}),
     ('2', {'1': 'nsubj', '2': 'pass'})]

Note that a node without successors is not defined the `sucs` dictionary.

```python_alt
"3" in g2.sucs
```

    False

Use `get` function to avoid `KeyError` and safely get the successors:

```python_alt
g2.sucs.get("3", [])
```

    []
