+++
Description = "About version 0.7"
title = "Grewpy"
+++

# ⚠️ How to to upgrade to grewpy 0.7

Version 0.7 introduced some changes, which are described here.
Feel free to [post an issue here](https://github.com/grew-nlp/grewpy/issues) if you need help with the new version.

The modules `Matchings` and `Observations` are removed.

## Clustering parameters in `search` and `count` (module `Corpus`)

The clustering mechanim for the functions `search` and `count` were previously accessible with two arguments named `clustering_parameter` and `clustering_keys`.
The first is removed and only `clustering_keys` is now available.

### Example

We look at the relation `comp:cleft` in `SUD_French-GSD@2.17` and want to observe the POS of the governor and dependent of this relation.
We suppose that a local folder named `SUD_French-GSD@2.17` is available in the current directory (data can be downloaded from [GitHub](https://github.com/surfacesyntacticud/SUD_French-GSD/archive/refs/tags/r2.17.zip)).

```python_alt
from grewpy import Corpus, Request
corpus = Corpus("SUD_French-GSD@2.17")
request = Request ("pattern { X -[comp:cleft]-> Y }")
print (corpus.count (request, clustering_keys=["X.upos", "Y.upos"]))
```

returns

```
{('AUX', 'VERB'): 71, ('AUX', 'SCONJ'): 117, ('AUX', 'AUX'): 24}
```

The output is a "flat" dictionary where keys are pair for each possible value of the two feature `X.upos` and `Y.upos`.
More generally, if `clustering_keys` is a *n*-tuple, the output dictionary contains *n*-tuple keys.

It is possible to get a recursive dictionary with the `flat=False` argument.
This corresponds to the default behavior before grewpy version 0.7 and with `grew grep` (see [doc](../../usage/cli/#with-clustering)).

```python_alt
from grewpy import Corpus, Request
corpus = Corpus("SUD_French-GSD@2.17")
request = Request ("pattern { X -[comp:cleft]-> Y }")
print (corpus.count (request, flat=False, clustering_keys=["X.upos", "Y.upos"]))
```

```
{'AUX': {'VERB': 71, 'SCONJ': 117, 'AUX': 24}}
```
