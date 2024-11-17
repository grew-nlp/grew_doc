---
title: "Grewpy • Multi corpora counting"
date: 2024-10-18
---

[`grewpy` Tutorial](../tutorial)

# Grewpy tutorial: counting requests on a list of corpus

Download the notebook [here](../multi_corpora_counting.ipynb).

```python_alt
import grewpy
from grewpy import Corpus, Request

grewpy.set_config("ud")
```

    connected to port: 61380

Below, we define the list of corpora to be used.
We suppose that there is a (link to) a local folder named `ud-treebanks-v2.15` with data of the corresponding UD release.

Requests are defined by a list of pairs; each pair contains the corpus_id in the previous folder and the request code.

```python_alt
folder = "ud-treebanks-v2.15"

corpus_list = [
  "UD_Arabic-PUD",
  "UD_Chinese-PUD",
  "UD_Czech-PUD",
  "UD_English-PUD",
  "UD_Finnish-PUD",
  "UD_French-PUD",
  "UD_German-PUD",
  "UD_Hindi-PUD",
  "UD_Icelandic-PUD",
  "UD_Indonesian-PUD",
  "UD_Italian-PUD",
  "UD_Japanese-PUD",
  "UD_Korean-PUD",
  "UD_Polish-PUD",
  "UD_Portuguese-PUD",
  "UD_Russian-PUD",
  "UD_Spanish-PUD",
  "UD_Swedish-PUD",
  "UD_Thai-PUD",
  "UD_Turkish-PUD"
]
request_codes = [
  ("SV", "pattern { V -[nsubj]-> S; S << V }"),
  ("VS", "pattern { V -[nsubj]-> S; V << S }"),
]
```

The code below prints (on `stdout`) TSV data, with one lien for each corpus and one columns for each requet, with the correponding number of occurrences.

```python_alt
tab='\t'
request_list = [(request_id,Request(code)) for (request_id,code) in request_codes]
request_ids = [request_id for (request_id,code) in request_codes]
print (f'Corpus{tab}{tab.join(request_ids)}')
for corpus_id in corpus_list:
	corpus = Corpus (f'{folder}/{corpus_id}')
	occurences = [str(corpus.count(request)) for (_,request) in request_list]
	print (f'{corpus_id}{tab}{tab.join(occurences)}')
	corpus.clean()  # free unused corpus from memory
```

    Corpus	SV	VS
    UD_Arabic-PUD	545	825
    UD_Chinese-PUD	1767	5
    UD_Czech-PUD	987	258
    UD_English-PUD	1339	53
    UD_Finnish-PUD	1018	86
    UD_French-PUD	1354	63
    UD_German-PUD	1209	273
    UD_Hindi-PUD	1121	6
    UD_Icelandic-PUD	1513	282
    UD_Indonesian-PUD	1415	113
    UD_Italian-PUD	1023	103
    UD_Japanese-PUD	1446	0
    UD_Korean-PUD	1545	1
    UD_Polish-PUD	857	206
    UD_Portuguese-PUD	1227	58
    UD_Russian-PUD	1157	205
    UD_Spanish-PUD	1074	116
    UD_Swedish-PUD	1255	259
    UD_Thai-PUD	1618	1
    UD_Turkish-PUD	1233	6
