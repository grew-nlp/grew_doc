---
title: "Grewpy • request"
date: 2024-04-22
---

[`grewpy` Tutorial](../tutorial)

# Grewpy tutorial: Modify data

Download the notebook [here](../modify_data.ipynb).

```python_alt
import grewpy
from grewpy import Corpus, CorpusDraft, Request
grewpy.set_config("sud") # ud or basic
corpus = Corpus("SUD_English-PUD")
```

## Access data in a corpus

```python_alt
# Access to the corpus
sentence = corpus[1]
print("A corpus is a set of graphs:", type(sentence))
```

```python_alt
# Each graph is a sentence and contains all its information
print("Sentence metadata:")
sentence.meta
```

```python_alt
# Sentence order, which in this case is the same as the token's id
print(sentence.order)
```

```python_alt
# Token features, which make possible to access every token feature
print(sentence.features)

# e.g get all upos of the sentence
print([sentence.features[id]['upos'] for id in sentence.features if id != "0"])
```

```python_alt
# It's possible to access to edges between nodes as successors
print(sentence.sucs)
```

## Modifying a corpus
`Corpus` is an abstract object which cannot be modified directly:

```python_alt
try:
	corpus[0] = corpus[1]
except TypeError as error_message:
	print (f"{error_message}")
```

`CorpusDraft` is an object similar to `Corpus` (all methods above can be applied to `CorpusDraft`) but which is mutable.
Below, we add the feature `Transitive=Yes` to all occurrences of verbs with a direct object.

The `CorpusDraft` named `draft` should be transformed again into a `Corpus` (names `corpus2` below) in order to use the `count` method.

```python_alt
draft = CorpusDraft(corpus)
req7 = Request().pattern("X[upos=VERB]; Y[upos=NOUN]; X-[comp:obj]->Y")
occurrences = corpus.search(req7)
for occ in occurrences:
    sent_id = occ['sent_id']
    verb_node_id = occ['matching']['nodes']['X']
    draft[sent_id][verb_node_id].update({"Transitive": "Yes"})

corpus2 = Corpus(draft)
corpus2.count(Request("pattern { X[Transitive=Yes] }"))
```

It's possible to modify a whole corpus with a function getting a graph as input.

```python_alt
def relabel_noun(graph):
    for node in graph:
        if 'upos' in graph[node] and graph[node]['upos'] == 'NOUN':
            graph[node]['upos'] = 'N'
    return graph

draft3 = draft.apply(relabel_noun)
corpus3 = Corpus(draft3)
corpus3.count(Request("X[upos=N]"))
```

## Modifying a corpus using a GRS (Graph Rewriting System)
In many cases, it is not required to uses a `CorpusDraft` and the modification of a corpus can be encoded with graph rewriting rules.

The example above (identifying transitive verbs) can be rephrased as below.
See TODO link for an explanation of the `without` clause in this example.

```python_alt
from grewpy import GRS

s = """
strat main { Onf(tv) }

rule tv {
  pattern { X[upos=VERB]; Y[upos=NOUN]; X-[comp:obj]->Y }
  without { X[Transitive = Yes] }
  commands { X.Transitive = Yes }
}
"""
grs = GRS(s)
corpus2bis = grs.apply(corpus)
corpus2bis.count(Request("pattern { X[Transitive=Yes] }"))
```

For the example, where the upos tag `NOUN` is changed to `N`, this can be done with a GRS:

```python_alt
grs3 = GRS("""
strat main { Onf(noun2n) }

rule noun2n {
  pattern { X[upos=NOUN] }
  commands { X.upos = N }
}
""")
corpus3bis = grs3.apply(corpus)
corpus3bis.count(Request("X[upos=N]"))
```

Similarily to the `CorpusDraft` above, there is a mmodule `GRSDraft` which can be inspected and which is mutable.

```python_alt
from grewpy import GRSDraft

s = """
strat main {Onf(cxns)}
package cxns {
    rule existential {
        pattern {X-[comp@expl]->Y; X[lemma=be]}
        without {X[Cxn=Existential]}
        commands {X.Cxn=Existential}
    }
}
"""

grs_draft = GRSDraft(s)

for rule in grs_draft['cxns'].rules():
    print(f"{rule=}")
```

A `GRSDraft` cannot be applied to a corpus, it should be turned into a `GRS`:

```python_alt
grs = GRS(grs_draft)
corpus.apply(grs)
n_existentials = corpus.count(Request("pattern { X[Cxn=Existential] }"))
print(f"{n_existentials=}")
```
