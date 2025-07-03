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

    connected to port: 57097

## Access data in a corpus

```python_alt
# Access to the corpus
sentence = corpus[1]
print("A corpus is a set of graphs:", type(sentence))
```

    A corpus is a set of graphs: <class 'grewpy.graph.Graph'>

```python_alt
# Each graph is a sentence and contains all its information
print("Sentence metadata:")
sentence.meta
```

    Sentence metadata:

    {'sent_id': 'n01001013',
     'text': 'For those who follow social media transitions on Capitol Hill, this will be a little different.',
     '_filename': 'en_pud-sud-test.conllu'}

```python_alt
# Sentence order, which in this case is the same as the token's id
print(sentence.order)
```

    ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18']

```python_alt
# Token features, which make possible to access every token feature
print(sentence.features)

# e.g get all upos of the sentence
print([sentence.features[id]['upos'] for id in sentence.features if id != "0"])
```

    {'0': {'form': '__0__'}, '1': {'form': 'For', 'lemma': 'for', 'textform': 'For', 'upos': 'ADP', 'wordform': 'For', 'xpos': 'IN'}, '2': {'Number': 'Plur', 'PronType': 'Dem', 'form': 'those', 'lemma': 'those', 'textform': 'those', 'upos': 'PRON', 'wordform': 'those', 'xpos': 'DT'}, '3': {'PronType': 'Rel', 'form': 'who', 'lemma': 'who', 'textform': 'who', 'upos': 'PRON', 'wordform': 'who', 'xpos': 'WP'}, '4': {'Mood': 'Ind', 'Tense': 'Pres', 'VerbForm': 'Fin', 'form': 'follow', 'lemma': 'follow', 'textform': 'follow', 'upos': 'VERB', 'wordform': 'follow', 'xpos': 'VBP'}, '5': {'Degree': 'Pos', 'form': 'social', 'lemma': 'social', 'textform': 'social', 'upos': 'ADJ', 'wordform': 'social', 'xpos': 'JJ'}, '6': {'Number': 'Sing', 'form': 'media', 'lemma': 'media', 'textform': 'media', 'upos': 'NOUN', 'wordform': 'media', 'xpos': 'NN'}, '7': {'Number': 'Plur', 'form': 'transitions', 'lemma': 'transition', 'textform': 'transitions', 'upos': 'NOUN', 'wordform': 'transitions', 'xpos': 'NNS'}, '8': {'form': 'on', 'lemma': 'on', 'textform': 'on', 'upos': 'ADP', 'wordform': 'on', 'xpos': 'IN'}, '9': {'Number': 'Sing', 'form': 'Capitol', 'lemma': 'Capitol', 'textform': 'Capitol', 'upos': 'PROPN', 'wordform': 'Capitol', 'xpos': 'NNP'}, '10': {'Number': 'Sing', 'SpaceAfter': 'No', 'form': 'Hill', 'lemma': 'Hill', 'textform': 'Hill', 'upos': 'PROPN', 'wordform': 'Hill', 'xpos': 'NNP'}, '11': {'form': ',', 'lemma': ',', 'textform': ',', 'upos': 'PUNCT', 'wordform': ',', 'xpos': ','}, '12': {'Number': 'Sing', 'PronType': 'Dem', 'form': 'this', 'lemma': 'this', 'textform': 'this', 'upos': 'PRON', 'wordform': 'this', 'xpos': 'DT'}, '13': {'VerbForm': 'Fin', 'form': 'will', 'lemma': 'will', 'textform': 'will', 'upos': 'AUX', 'wordform': 'will', 'xpos': 'MD'}, '14': {'VerbForm': 'Inf', 'form': 'be', 'lemma': 'be', 'textform': 'be', 'upos': 'AUX', 'wordform': 'be', 'xpos': 'VB'}, '15': {'Definite': 'Ind', 'PronType': 'Art', 'form': 'a', 'lemma': 'a', 'textform': 'a', 'upos': 'DET', 'wordform': 'a', 'xpos': 'DT'}, '16': {'Degree': 'Pos', 'form': 'little', 'lemma': 'little', 'textform': 'little', 'upos': 'ADJ', 'wordform': 'little', 'xpos': 'JJ'}, '17': {'Degree': 'Pos', 'SpaceAfter': 'No', 'form': 'different', 'lemma': 'different', 'textform': 'different', 'upos': 'ADJ', 'wordform': 'different', 'xpos': 'JJ'}, '18': {'form': '.', 'lemma': '.', 'textform': '.', 'upos': 'PUNCT', 'wordform': '.', 'xpos': '.'}}
    ['ADP', 'PRON', 'PRON', 'VERB', 'ADJ', 'NOUN', 'NOUN', 'ADP', 'PROPN', 'PROPN', 'PUNCT', 'PRON', 'AUX', 'AUX', 'DET', 'ADJ', 'ADJ', 'PUNCT']

```python_alt
# It's possible to access to edges between nodes as successors
print(sentence.sucs)
```

    {'17': [('16', FsEdge({'1': 'udep', 'deep': 'npmod'}))], '16': [('15', FsEdge({'1': 'det'}))], '14': [('17', FsEdge({'1': 'comp', '2': 'pred'}))], '13': [('18', FsEdge({'1': 'punct'})), ('14', FsEdge({'1': 'comp', '2': 'aux'})), ('12', FsEdge({'1': 'subj'})), ('11', FsEdge({'1': 'punct'})), ('1', FsEdge({'1': 'udep'}))], '10': [('9', FsEdge({'1': 'compound'}))], '8': [('10', FsEdge({'1': 'comp', '2': 'obj'}))], '7': [('8', FsEdge({'1': 'udep'})), ('6', FsEdge({'1': 'compound'}))], '6': [('5', FsEdge({'1': 'mod'}))], '4': [('7', FsEdge({'1': 'comp', '2': 'obj'})), ('3', FsEdge({'1': 'subj'}))], '2': [('4', FsEdge({'1': 'mod', 'deep': 'relcl'}))], '1': [('2', FsEdge({'1': 'comp', '2': 'obj'}))], '0': [('13', FsEdge({'1': 'root'}))]}

## Modifying a corpus
`Corpus` is an abstract object which cannot be modified directly:

```python_alt
try:
	corpus[0] = corpus[1]
except TypeError as error_message:
	print (f"{error_message}")
```

    'Corpus' object does not support item assignment

`CorpusDraft` is an object similar to `Corpus` but which is mutable.
Below, we add the feature `Transitive=Yes` to all occurrences of verbs with a direct object.

1. We make the search on `corpus` (an instance of `Corpus`).
2. The modification is done on a `CorpusDraft` counterpart named `draft`.
3. The `draft` should be transformed again into a `Corpus` (names `corpus2` below) in order to use the `count` method.

```python_alt
# step 1
req7 = Request().pattern("X[upos=VERB]; Y[upos=NOUN|PROPN|PRON]; X-[comp:obj]->Y")
occurrences = corpus.search(req7)

# step 2
draft = CorpusDraft(corpus)
for occ in occurrences:
    sent_id = occ['sent_id']
    verb_node_id = occ['matching']['nodes']['X']
    draft[sent_id][verb_node_id].update({"Transitive": "Yes"})

# step 3
corpus2 = Corpus(draft)
corpus2.count(Request("pattern { X[Transitive=Yes] }"))
```

    853

It's possible to modify a whole `CorpusDraft` with a function getting a graph as input.

```python_alt
def relabel_noun(graph):
    for node in graph:
        if 'upos' in graph[node] and graph[node]['upos'] == 'NOUN':
            graph[node]['upos'] = 'N'
    return graph

draft3 = draft.map(relabel_noun)
# Note that the map function has replaced the apply function which is deprecated in 0.6

# Again, we need to turn the result into a `Corpus` before using the `count` method.
corpus3 = Corpus(draft3)
corpus3.count(Request("pattern { X[upos=N] }"))
```

    4036

## Modifying a corpus using a GRS (Graph Rewriting System)
In many cases, it is not required to uses a `CorpusDraft` and the modification of a corpus can be encoded with graph rewriting rules.

The example above (identifying transitive verbs) can be rephrased as below.
See TODO link for an explanation of the `without` clause in this example.

```python_alt
from grewpy import GRS

s = """
strat main { Onf(tv) }

rule tv {
  pattern { X[upos=VERB]; Y[upos=NOUN|PROPN|PRON]; X-[comp:obj]->Y }
  without { X[Transitive = Yes] }
  commands { X.Transitive = Yes }
}
"""
grs = GRS(s)
corpus2bis = grs.apply(corpus)
corpus2bis.count(Request("pattern { X[Transitive=Yes] }"))
```

    853

For the example, where the upos tag `NOUN` is changed to `N`, this can be done with a GRS:

```python_alt
from grewpy import GRS

grs3 = GRS("""
strat main { Onf(noun2n) }

rule noun2n {
  pattern { X[upos=NOUN] }
  commands { X.upos = N }
}
""")
corpus3bis = grs3.apply(corpus)
corpus3bis.count(Request("pattern { X[upos=N] }"))
```

    4036

Similarily to the `CorpusDraft` above, there is a module `GRSDraft` which can be inspected and which is mutable.

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

    rule='existential'

A `GRSDraft` cannot be applied to a corpus, it should be turned into a `GRS`:

```python_alt
grs = GRS(grs_draft)
corpus.apply(grs)
n_existentials = corpus.count(Request("pattern { X[Cxn=Existential] }"))
print(f"{n_existentials=}")
```

    n_existentials=26
