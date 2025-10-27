---
title: "Grewpy • graph"
date: 2023-08-14
---

[`grewpy` Tutorial](../tutorial)

# `grewpy` library: Graph module

Download the notebook [here](../graph.ipynb).

First, we import the `Graph` module from `grewpy`.

**NB:** The port number is different at each execution. If you don't have the message `connected to port: …`, see [here](../../usage/python/#install).

```python_alt
from grewpy import Graph
```

    connected to port: 52707

## Build a graph

A graph can be built from its JSON encoding (see [here](../../doc/json) for more information on this format).

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

A graph can also be built from CoNLL data.

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

    digraph G {
      node [shape=box];
      N_5 [label=<<TABLE BORDER="0" CELLBORDER="0" CELLSPACING="0">
    <TR><TD COLSPAN="3"><B>.</B></TD></TR>
    <TR><TD ALIGN="right">upos</TD><TD>=</TD><TD ALIGN="left">PUNCT</TD></TR>
    <TR><TD ALIGN="right">lemma</TD><TD>=</TD><TD ALIGN="left">.</TD></TR>
    <TR><TD ALIGN="right">xpos</TD><TD>=</TD><TD ALIGN="left">FS</TD></TR>
    <TR><TD ALIGN="right">textform</TD><TD>=</TD><TD ALIGN="left">.</TD></TR>
    <TR><TD ALIGN="right">wordform</TD><TD>=</TD><TD ALIGN="left">.</TD></TR>
    </TABLE>
    >]
      N_4 [label=<<TABLE BORDER="0" CELLBORDER="0" CELLSPACING="0">
    <TR><TD COLSPAN="3"><B>done</B></TD></TR>
    <TR><TD ALIGN="right">upos</TD><TD>=</TD><TD ALIGN="left">VERB</TD></TR>
    <TR><TD ALIGN="right">lemma</TD><TD>=</TD><TD ALIGN="left">do</TD></TR>
    <TR><TD ALIGN="right">xpos</TD><TD>=</TD><TD ALIGN="left">V</TD></TR>
    <TR><TD ALIGN="right">SpaceAfter</TD><TD>=</TD><TD ALIGN="left">No</TD></TR>
    <TR><TD ALIGN="right">Tense</TD><TD>=</TD><TD ALIGN="left">Past</TD></TR>
    <TR><TD ALIGN="right">VerbForm</TD><TD>=</TD><TD ALIGN="left">Part</TD></TR>
    <TR><TD ALIGN="right">textform</TD><TD>=</TD><TD ALIGN="left">done</TD></TR>
    <TR><TD ALIGN="right">wordform</TD><TD>=</TD><TD ALIGN="left">done</TD></TR>
    </TABLE>
    >]
      N_3 [label=<<TABLE BORDER="0" CELLBORDER="0" CELLSPACING="0">
    <TR><TD COLSPAN="3"><B>is</B></TD></TR>
    <TR><TD ALIGN="right">upos</TD><TD>=</TD><TD ALIGN="left">AUX</TD></TR>
    <TR><TD ALIGN="right">lemma</TD><TD>=</TD><TD ALIGN="left">be</TD></TR>
    <TR><TD ALIGN="right">xpos</TD><TD>=</TD><TD ALIGN="left">VA</TD></TR>
    <TR><TD ALIGN="right">Mood</TD><TD>=</TD><TD ALIGN="left">Ind</TD></TR>
    <TR><TD ALIGN="right">Number</TD><TD>=</TD><TD ALIGN="left">Sing</TD></TR>
    <TR><TD ALIGN="right">Person</TD><TD>=</TD><TD ALIGN="left">3</TD></TR>
    <TR><TD ALIGN="right">Tense</TD><TD>=</TD><TD ALIGN="left">Pres</TD></TR>
    <TR><TD ALIGN="right">VerbForm</TD><TD>=</TD><TD ALIGN="left">Fin</TD></TR>
    <TR><TD ALIGN="right">textform</TD><TD>=</TD><TD ALIGN="left">is</TD></TR>
    <TR><TD ALIGN="right">wordform</TD><TD>=</TD><TD ALIGN="left">is</TD></TR>
    </TABLE>
    >]
      N_2 [label=<<TABLE BORDER="0" CELLBORDER="0" CELLSPACING="0">
    <TR><TD COLSPAN="3"><B>work</B></TD></TR>
    <TR><TD ALIGN="right">upos</TD><TD>=</TD><TD ALIGN="left">NOUN</TD></TR>
    <TR><TD ALIGN="right">lemma</TD><TD>=</TD><TD ALIGN="left">work</TD></TR>
    <TR><TD ALIGN="right">xpos</TD><TD>=</TD><TD ALIGN="left">S</TD></TR>
    <TR><TD ALIGN="right">Number</TD><TD>=</TD><TD ALIGN="left">Sing</TD></TR>
    <TR><TD ALIGN="right">textform</TD><TD>=</TD><TD ALIGN="left">work</TD></TR>
    <TR><TD ALIGN="right">wordform</TD><TD>=</TD><TD ALIGN="left">work</TD></TR>
    </TABLE>
    >]
      N_1 [label=<<TABLE BORDER="0" CELLBORDER="0" CELLSPACING="0">
    <TR><TD COLSPAN="3"><B>The</B></TD></TR>
    <TR><TD ALIGN="right">upos</TD><TD>=</TD><TD ALIGN="left">DET</TD></TR>
    <TR><TD ALIGN="right">lemma</TD><TD>=</TD><TD ALIGN="left">the</TD></TR>
    <TR><TD ALIGN="right">xpos</TD><TD>=</TD><TD ALIGN="left">RD</TD></TR>
    <TR><TD ALIGN="right">Definite</TD><TD>=</TD><TD ALIGN="left">Def</TD></TR>
    <TR><TD ALIGN="right">PronType</TD><TD>=</TD><TD ALIGN="left">Art</TD></TR>
    <TR><TD ALIGN="right">textform</TD><TD>=</TD><TD ALIGN="left">The</TD></TR>
    <TR><TD ALIGN="right">wordform</TD><TD>=</TD><TD ALIGN="left">The</TD></TR>
    </TABLE>
    >]
      N_0 [label=<<TABLE BORDER="0" CELLBORDER="0" CELLSPACING="0">
    <TR><TD COLSPAN="3"><B>__0__</B></TD></TR>
    </TABLE>
    >]
      N_0 -> N_4[label="root", ];
      N_2 -> N_1[label="det", ];
      N_4 -> N_2[label="nsubj:pass", ];
      N_4 -> N_3[label="aux:pass", ];
      N_4 -> N_5[label="punct", ];
     { rank=same; N_0; N_1; }
      N_0 -> N_1 [label="SUCC", style=dotted, fontcolor=white, color=white];
     { rank=same; N_1; N_2; }
      N_1 -> N_2 [label="SUCC", style=dotted, fontcolor=white, color=white];
     { rank=same; N_2; N_3; }
      N_2 -> N_3 [label="SUCC", style=dotted, fontcolor=white, color=white];
     { rank=same; N_3; N_4; }
      N_3 -> N_4 [label="SUCC", style=dotted, fontcolor=white, color=white];
     { rank=same; N_4; N_5; }
      N_4 -> N_5 [label="SUCC", style=dotted, fontcolor=white, color=white];
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

Each node is given a list of *successors* described by pairs of the target nodes and the edges label. 
Edge labels are dictionaries (see [here](../../doc/graph/#edges) for details on edge label encoding.)

```python_alt
g1.sucs["A"]
```

    [('B', FsEdge({'1': 'X'})), ('B', FsEdge({'1': 'XX'}))]

```python_alt
g2.sucs["4"]
```

    [('5', FsEdge({'1': 'punct'})),
     ('3', FsEdge({'1': 'aux', '2': 'pass'})),
     ('2', FsEdge({'1': 'nsubj', '2': 'pass'}))]

Note that a node with no successor is not defined in the `sucs` dictionary.

```python_alt
"3" in g2.sucs
```

    False

Use the `get` function to avoid `KeyError` and safely get the successors:

```python_alt
g2.sucs.get("3", [])
```

    []
