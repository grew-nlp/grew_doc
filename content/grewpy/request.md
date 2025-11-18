---
title: "Grewpy • request"
date: 2024-04-22
---

[`grewpy` Tutorial](../tutorial)

# Grewpy tutorial: Run requests on a corpus

Download the notebook [here](../request.ipynb).

**NOTE**: this notebook requires **Grewpy** version 0.7 (see [upgrade info](../../usage/python#upgrade))

```python_alt
import grewpy
from grewpy import Corpus, Request

grewpy.set_config("sud") # ud or basic
```

    connected to port: 63629

## Import data
The `Corpus` constructor takes a `conllu` file or a directory containing `conllu` files.
A `Corpus` allows to make queries and to count occurrences.

```python_alt
treebank_path = "SUD_English-PUD"
corpus = Corpus(treebank_path)
print(type(corpus))
```

    <class 'grewpy.corpus.Corpus'>

```python_alt
n_sentencens = len(corpus)
sent_ids = corpus.get_sent_ids()

print(f"{n_sentencens = }")
print(f"{sent_ids[0] = }")
```

    n_sentencens = 1000
    sent_ids[0] = 'n01001011'

## Explore data
See the [Grew-match tutorial](https://universal.grew.fr/?tutorial=yes) to practice writing Grew requests

### Count the number of subjets in the corpus

```python_alt
req1 = Request("pattern { X-[subj]->Y }")
corpus.count(req1)
```

    1420

It is possible to extend an already existing request with the methods `pattern`, `without` and `with_` (because `with` is a Python keyword).
Hence, the request `req1bis` below is equivalent to `req1`.

```python_alt
req1bis = Request().pattern("X-[subj]->Y")
corpus.count(req1bis)
```

    1420

### Count the number of subjects such that the subject's head is not a pronoun

```python_alt
req2 = Request().pattern("X-[subj]->Y").without("Y[upos=PRON]")
corpus.count(req2)
```

    943

### Count the number of subjects with at least one dependant
Note the usage of `with_` (because `with` is a Python keyword)

```python_alt
req3 = Request().pattern("X-[subj]->Y").with_("Y->Z")
corpus.count(req3)
```

    752

### `with` and `without` items can be stacked 

```python_alt
req4 = Request().pattern("X-[subj]->Y").with_("Y->Z").without("Y[upos=PRON]").without("X[upos=VERB]")
corpus.count(req4)
```

    320

### Building a request with the Grew syntax
It is possible to build request directly from the concrete syntax used in Grew-match or in Grew rules.
The `req4` can be written:

```python_alt
req4bis = Request("""
pattern { X-[subj]->Y }
with { Y->Z }
without { Y[upos=PRON] }
without { X[upos=VERB] }
""")
corpus.count(req4bis)
```

    320

### More complex queries are allowed, with result clustering
See [Clustering](../../doc/clustering) for more documentation.
Below, we cluster the subject relation, according to the POS of the governor.

```python_alt
req5 = Request("pattern {X-[subj]->Y}")
corpus.count(req5, clustering_keys=["X.upos"])
```

    {'VERB': 826, 'SCONJ': 1, 'PART': 5, 'NOUN': 3, 'AUX': 581, 'ADP': 3, 'ADJ': 1}

### Clustering results by other requests
The clustering is done on the relative position of `X` and `Y`.
It answers to the question: _How many subjects are in a pre-verbal position?_

```python_alt
corpus.count(req5, clustering_keys=["{X << Y}"])
```

    {'Yes': 77, 'No': 1343}

This example corresponds to the `whether` clustering in Grew-match.
Note that here curly braces are required around `X << Y` to indicate that whether clustering should be performed instead of key clustering.

### Two clusterings can be applied
The behavior of this feature has changed in **Grewpy** version 0.7.
See [here](../upgrade_0.7) for more details.

```python_alt
corpus.count(req5, clustering_keys=["{X << Y}","X.upos"])
```

    {('Yes', 'VERB'): 45,
     ('Yes', 'SCONJ'): 1,
     ('Yes', 'AUX'): 30,
     ('Yes', 'ADP'): 1,
     ('No', 'VERB'): 781,
     ('No', 'PART'): 5,
     ('No', 'NOUN'): 3,
     ('No', 'AUX'): 551,
     ('No', 'ADP'): 2,
     ('No', 'ADJ'): 1}

### More than two clusterings are also possible

```python_alt
corpus.count(req5, clustering_keys=["{X << Y}","X.upos", "{X[Number=Sing]}"])
```

    {('Yes', 'VERB', 'Yes'): 16,
     ('Yes', 'VERB', 'No'): 29,
     ('Yes', 'SCONJ', 'No'): 1,
     ('Yes', 'AUX', 'Yes'): 21,
     ('Yes', 'AUX', 'No'): 9,
     ('Yes', 'ADP', 'No'): 1,
     ('No', 'VERB', 'Yes'): 167,
     ('No', 'VERB', 'No'): 614,
     ('No', 'PART', 'No'): 5,
     ('No', 'NOUN', 'Yes'): 2,
     ('No', 'NOUN', 'No'): 1,
     ('No', 'AUX', 'Yes'): 255,
     ('No', 'AUX', 'No'): 296,
     ('No', 'ADP', 'No'): 2,
     ('No', 'ADJ', 'No'): 1}

### Search occurrences
Get the list of occurrence of a given request in the corpus

```python_alt
occurrences = corpus.search(req1)
assert len(occurrences) == corpus.count(req1)
occurrences[0]
```

    {'sent_id': 'w05010027',
     'matching': {'nodes': {'Y': '8', 'X': '10'}, 'edges': {}}}

### Get occurrences including edges
The edge is named `e`, and the label of the dependency is reported in the output

```python_alt
req6 = Request().pattern("e: X->Y; X[upos=VERB]")
corpus.search(req6)[3]
```

    {'sent_id': 'w05010027',
     'matching': {'nodes': {'Y': '12', 'X': '10'},
      'edges': {'e': {'source': '10',
        'label': {'1': 'comp', '2': 'obj'},
        'target': '12'}}}}

### As with `count`, we can cluster the results of a `search`

```python_alt
result = corpus.search(req6, clustering_keys=["{X << Y}"])
result.keys()
```

    dict_keys(['Yes', 'No'])
