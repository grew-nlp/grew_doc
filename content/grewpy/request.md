---
title: "Grewpy • request"
date: 2023-08-14
---

# `grewpy` library: Request module

First, we import the `Corpus` and `Request` module from `grewpy`.

```python_alt
from grewpy import Corpus, Request, Graph
```

    connected to port: 56378

We first load a corpus to run requests on:

```python_alt
corpus = Corpus("data/en_partut-ud-dev.conllu")
```

In `grewpy`, there are two kind of requests:
 - Abstract requests, built from astring representation
 - Concrete requests, built from explicit clause in `pattern`, `without`… parts

# Concrete requests

A concrete request can be built directly with the `Request` constructor:

```python_alt
x = Request('e: N -[nsubj]-> M')
corpus.count (x)
```

    212

```python_alt
x = Request('e: N -[nsubj]-> M', 'N[upos=VERB]')
y = Request('e: N -[nsubj]-> M', 'N[upos=VERB]')
corpus.count (x), corpus.count (y)
```

    (154, 154)

```python_alt
x = Request('e: N -[nsubj]-> M')
corpus.count (x)
```

    212

```python_alt
x = Request('e: N -[nsubj]-> M;').without("N[upos=VERB]")
```

```python_alt
len (corpus.search (x))
```

    **************************
    False

    58

```python_alt
y = Request.parse ("pattern { e: N -[1=nsubj]-> M}")
```

    ---------------------------------------------------------------------------

    AttributeError                            Traceback (most recent call last)

    /Users/guillaum/gitlab/grew/grew_doc/content/grewpy/request.ipynb Cell 14 line 1
    ----> <a href='vscode-notebook-cell:/Users/guillaum/gitlab/grew/grew_doc/content/grewpy/request.ipynb#X16sZmlsZQ%3D%3D?line=0'>1</a> y = Request.parse ("pattern { e: N -[1=nsubj]-> M}")

    AttributeError: type object 'Request' has no attribute 'parse'

```python_alt
y.json_data()
```

    [{'pattern': ['e: N -[nsubj]-> M']}, {'pattern': ['N[upos=VERB]']}]

```python_alt
corpus.search (y, deco=True)
```

    **************************
    True

    [{'sent_id': 'en_partut-ud-2090',
      'matching': {'nodes': {'N': '10', 'M': '8'},
       'edges': {'e': {'source': '10', 'label': 'nsubj', 'target': '8'}}}},
     {'sent_id': 'en_partut-ud-2090',
      'matching': {'nodes': {'N': '23', 'M': '22'},
       'edges': {'e': {'source': '23', 'label': 'nsubj', 'target': '22'}}}},
     {'sent_id': 'en_partut-ud-2079',
      'matching': {'nodes': {'N': '5', 'M': '4'},
       'edges': {'e': {'source': '5', 'label': 'nsubj', 'target': '4'}}}},
     {'sent_id': 'en_partut-ud-2065',
      'matching': {'nodes': {'N': '12', 'M': '7'},
       'edges': {'e': {'source': '12', 'label': 'nsubj', 'target': '7'}}}},
     {'sent_id': 'en_partut-ud-2065',
      'matching': {'nodes': {'N': '15', 'M': '24'},
       'edges': {'e': {'source': '15', 'label': 'nsubj', 'target': '24'}}}},
     {'sent_id': 'en_partut-ud-2035',
      'matching': {'nodes': {'N': '14', 'M': '7'},
       'edges': {'e': {'source': '14', 'label': 'nsubj', 'target': '7'}}}},
     {'sent_id': 'en_partut-ud-2035',
      'matching': {'nodes': {'N': '17', 'M': '16'},
       'edges': {'e': {'source': '17', 'label': 'nsubj', 'target': '16'}}}},
     {'sent_id': 'en_partut-ud-2035',
      'matching': {'nodes': {'N': '25', 'M': '22'},
       'edges': {'e': {'source': '25', 'label': 'nsubj', 'target': '22'}}}},
     {'sent_id': 'en_partut-ud-2031',
      'matching': {'nodes': {'N': '2', 'M': '1'},
       'edges': {'e': {'source': '2', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-2031',
      'matching': {'nodes': {'N': '16', 'M': '15'},
       'edges': {'e': {'source': '16', 'label': 'nsubj', 'target': '15'}}}},
     {'sent_id': 'en_partut-ud-1967',
      'matching': {'nodes': {'N': '2', 'M': '1'},
       'edges': {'e': {'source': '2', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-1958',
      'matching': {'nodes': {'N': '2', 'M': '1'},
       'edges': {'e': {'source': '2', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-1955',
      'matching': {'nodes': {'N': '7', 'M': '4'},
       'edges': {'e': {'source': '7', 'label': 'nsubj', 'target': '4'}}}},
     {'sent_id': 'en_partut-ud-1887',
      'matching': {'nodes': {'N': '14', 'M': '13'},
       'edges': {'e': {'source': '14', 'label': 'nsubj', 'target': '13'}}}},
     {'sent_id': 'en_partut-ud-1875',
      'matching': {'nodes': {'N': '3', 'M': '2'},
       'edges': {'e': {'source': '3', 'label': 'nsubj', 'target': '2'}}}},
     {'sent_id': 'en_partut-ud-1874',
      'matching': {'nodes': {'N': '6', 'M': '4'},
       'edges': {'e': {'source': '6', 'label': 'nsubj', 'target': '4'}}}},
     {'sent_id': 'en_partut-ud-1861',
      'matching': {'nodes': {'N': '9', 'M': '1'},
       'edges': {'e': {'source': '9', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-1861',
      'matching': {'nodes': {'N': '13', 'M': '12'},
       'edges': {'e': {'source': '13', 'label': 'nsubj', 'target': '12'}}}},
     {'sent_id': 'en_partut-ud-1859',
      'matching': {'nodes': {'N': '9', 'M': '5'},
       'edges': {'e': {'source': '9', 'label': 'nsubj', 'target': '5'}}}},
     {'sent_id': 'en_partut-ud-1859',
      'matching': {'nodes': {'N': '24', 'M': '23'},
       'edges': {'e': {'source': '24', 'label': 'nsubj', 'target': '23'}}}},
     {'sent_id': 'en_partut-ud-1826',
      'matching': {'nodes': {'N': '6', 'M': '3'},
       'edges': {'e': {'source': '6', 'label': 'nsubj', 'target': '3'}}}},
     {'sent_id': 'en_partut-ud-1808',
      'matching': {'nodes': {'N': '8', 'M': '7'},
       'edges': {'e': {'source': '8', 'label': 'nsubj', 'target': '7'}}}},
     {'sent_id': 'en_partut-ud-1808',
      'matching': {'nodes': {'N': '15', 'M': '14'},
       'edges': {'e': {'source': '15', 'label': 'nsubj', 'target': '14'}}}},
     {'sent_id': 'en_partut-ud-1765',
      'matching': {'nodes': {'N': '22', 'M': '21'},
       'edges': {'e': {'source': '22', 'label': 'nsubj', 'target': '21'}}}},
     {'sent_id': 'en_partut-ud-1746',
      'matching': {'nodes': {'N': '9', 'M': '8'},
       'edges': {'e': {'source': '9', 'label': 'nsubj', 'target': '8'}}}},
     {'sent_id': 'en_partut-ud-1738',
      'matching': {'nodes': {'N': '3', 'M': '2'},
       'edges': {'e': {'source': '3', 'label': 'nsubj', 'target': '2'}}}},
     {'sent_id': 'en_partut-ud-1738',
      'matching': {'nodes': {'N': '21', 'M': '20'},
       'edges': {'e': {'source': '21', 'label': 'nsubj', 'target': '20'}}}},
     {'sent_id': 'en_partut-ud-1734',
      'matching': {'nodes': {'N': '3', 'M': '2'},
       'edges': {'e': {'source': '3', 'label': 'nsubj', 'target': '2'}}}},
     {'sent_id': 'en_partut-ud-1734',
      'matching': {'nodes': {'N': '5', 'M': '17'},
       'edges': {'e': {'source': '5', 'label': 'nsubj', 'target': '17'}}}},
     {'sent_id': 'en_partut-ud-1706',
      'matching': {'nodes': {'N': '3', 'M': '2'},
       'edges': {'e': {'source': '3', 'label': 'nsubj', 'target': '2'}}}},
     {'sent_id': 'en_partut-ud-1677',
      'matching': {'nodes': {'N': '14', 'M': '1'},
       'edges': {'e': {'source': '14', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-1634',
      'matching': {'nodes': {'N': '5', 'M': '4'},
       'edges': {'e': {'source': '5', 'label': 'nsubj', 'target': '4'}}}},
     {'sent_id': 'en_partut-ud-1634',
      'matching': {'nodes': {'N': '8', 'M': '7'},
       'edges': {'e': {'source': '8', 'label': 'nsubj', 'target': '7'}}}},
     {'sent_id': 'en_partut-ud-1575',
      'matching': {'nodes': {'N': '2', 'M': '1'},
       'edges': {'e': {'source': '2', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-1521',
      'matching': {'nodes': {'N': '12', 'M': '11'},
       'edges': {'e': {'source': '12', 'label': 'nsubj', 'target': '11'}}}},
     {'sent_id': 'en_partut-ud-1499',
      'matching': {'nodes': {'N': '3', 'M': '7'},
       'edges': {'e': {'source': '3', 'label': 'nsubj', 'target': '7'}}}},
     {'sent_id': 'en_partut-ud-1460',
      'matching': {'nodes': {'N': '9', 'M': '6'},
       'edges': {'e': {'source': '9', 'label': 'nsubj', 'target': '6'}}}},
     {'sent_id': 'en_partut-ud-1404',
      'matching': {'nodes': {'N': '10', 'M': '9'},
       'edges': {'e': {'source': '10', 'label': 'nsubj', 'target': '9'}}}},
     {'sent_id': 'en_partut-ud-1343',
      'matching': {'nodes': {'N': '16', 'M': '7'},
       'edges': {'e': {'source': '16', 'label': 'nsubj', 'target': '7'}}}},
     {'sent_id': 'en_partut-ud-1337',
      'matching': {'nodes': {'N': '4', 'M': '2'},
       'edges': {'e': {'source': '4', 'label': 'nsubj', 'target': '2'}}}},
     {'sent_id': 'en_partut-ud-1276',
      'matching': {'nodes': {'N': '4', 'M': '3'},
       'edges': {'e': {'source': '4', 'label': 'nsubj', 'target': '3'}}}},
     {'sent_id': 'en_partut-ud-1276',
      'matching': {'nodes': {'N': '12', 'M': '11'},
       'edges': {'e': {'source': '12', 'label': 'nsubj', 'target': '11'}}}},
     {'sent_id': 'en_partut-ud-1239',
      'matching': {'nodes': {'N': '6', 'M': '4'},
       'edges': {'e': {'source': '6', 'label': 'nsubj', 'target': '4'}}}},
     {'sent_id': 'en_partut-ud-1203',
      'matching': {'nodes': {'N': '3', 'M': '1'},
       'edges': {'e': {'source': '3', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-1135',
      'matching': {'nodes': {'N': '2', 'M': '1'},
       'edges': {'e': {'source': '2', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-1135',
      'matching': {'nodes': {'N': '7', 'M': '5'},
       'edges': {'e': {'source': '7', 'label': 'nsubj', 'target': '5'}}}},
     {'sent_id': 'en_partut-ud-1127',
      'matching': {'nodes': {'N': '4', 'M': '3'},
       'edges': {'e': {'source': '4', 'label': 'nsubj', 'target': '3'}}}},
     {'sent_id': 'en_partut-ud-1127',
      'matching': {'nodes': {'N': '19', 'M': '22'},
       'edges': {'e': {'source': '19', 'label': 'nsubj', 'target': '22'}}}},
     {'sent_id': 'en_partut-ud-1117',
      'matching': {'nodes': {'N': '3', 'M': '2'},
       'edges': {'e': {'source': '3', 'label': 'nsubj', 'target': '2'}}}},
     {'sent_id': 'en_partut-ud-1117',
      'matching': {'nodes': {'N': '14', 'M': '12'},
       'edges': {'e': {'source': '14', 'label': 'nsubj', 'target': '12'}}}},
     {'sent_id': 'en_partut-ud-1101',
      'matching': {'nodes': {'N': '9', 'M': '8'},
       'edges': {'e': {'source': '9', 'label': 'nsubj', 'target': '8'}}}},
     {'sent_id': 'en_partut-ud-1101',
      'matching': {'nodes': {'N': '15', 'M': '1'},
       'edges': {'e': {'source': '15', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-1085',
      'matching': {'nodes': {'N': '16', 'M': '14'},
       'edges': {'e': {'source': '16', 'label': 'nsubj', 'target': '14'}}}},
     {'sent_id': 'en_partut-ud-1063',
      'matching': {'nodes': {'N': '6', 'M': '5'},
       'edges': {'e': {'source': '6', 'label': 'nsubj', 'target': '5'}}}},
     {'sent_id': 'en_partut-ud-1025',
      'matching': {'nodes': {'N': '12', 'M': '1'},
       'edges': {'e': {'source': '12', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-945',
      'matching': {'nodes': {'N': '5', 'M': '2'},
       'edges': {'e': {'source': '5', 'label': 'nsubj', 'target': '2'}}}},
     {'sent_id': 'en_partut-ud-944',
      'matching': {'nodes': {'N': '3', 'M': '1'},
       'edges': {'e': {'source': '3', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-942',
      'matching': {'nodes': {'N': '9', 'M': '2'},
       'edges': {'e': {'source': '9', 'label': 'nsubj', 'target': '2'}}}},
     {'sent_id': 'en_partut-ud-942',
      'matching': {'nodes': {'N': '14', 'M': '13'},
       'edges': {'e': {'source': '14', 'label': 'nsubj', 'target': '13'}}}},
     {'sent_id': 'en_partut-ud-942',
      'matching': {'nodes': {'N': '22', 'M': '20'},
       'edges': {'e': {'source': '22', 'label': 'nsubj', 'target': '20'}}}},
     {'sent_id': 'en_partut-ud-937',
      'matching': {'nodes': {'N': '14', 'M': '13'},
       'edges': {'e': {'source': '14', 'label': 'nsubj', 'target': '13'}}}},
     {'sent_id': 'en_partut-ud-936',
      'matching': {'nodes': {'N': '4', 'M': '3'},
       'edges': {'e': {'source': '4', 'label': 'nsubj', 'target': '3'}}}},
     {'sent_id': 'en_partut-ud-936',
      'matching': {'nodes': {'N': '14', 'M': '11'},
       'edges': {'e': {'source': '14', 'label': 'nsubj', 'target': '11'}}}},
     {'sent_id': 'en_partut-ud-935',
      'matching': {'nodes': {'N': '8', 'M': '7'},
       'edges': {'e': {'source': '8', 'label': 'nsubj', 'target': '7'}}}},
     {'sent_id': 'en_partut-ud-933',
      'matching': {'nodes': {'N': '3', 'M': '2'},
       'edges': {'e': {'source': '3', 'label': 'nsubj', 'target': '2'}}}},
     {'sent_id': 'en_partut-ud-927',
      'matching': {'nodes': {'N': '8', 'M': '7'},
       'edges': {'e': {'source': '8', 'label': 'nsubj', 'target': '7'}}}},
     {'sent_id': 'en_partut-ud-923',
      'matching': {'nodes': {'N': '9', 'M': '2'},
       'edges': {'e': {'source': '9', 'label': 'nsubj', 'target': '2'}}}},
     {'sent_id': 'en_partut-ud-922',
      'matching': {'nodes': {'N': '6', 'M': '3'},
       'edges': {'e': {'source': '6', 'label': 'nsubj', 'target': '3'}}}},
     {'sent_id': 'en_partut-ud-918',
      'matching': {'nodes': {'N': '2', 'M': '1'},
       'edges': {'e': {'source': '2', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-918',
      'matching': {'nodes': {'N': '12', 'M': '11'},
       'edges': {'e': {'source': '12', 'label': 'nsubj', 'target': '11'}}}},
     {'sent_id': 'en_partut-ud-917',
      'matching': {'nodes': {'N': '6', 'M': '1'},
       'edges': {'e': {'source': '6', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-916',
      'matching': {'nodes': {'N': '8', 'M': '7'},
       'edges': {'e': {'source': '8', 'label': 'nsubj', 'target': '7'}}}},
     {'sent_id': 'en_partut-ud-915',
      'matching': {'nodes': {'N': '7', 'M': '6'},
       'edges': {'e': {'source': '7', 'label': 'nsubj', 'target': '6'}}}},
     {'sent_id': 'en_partut-ud-914',
      'matching': {'nodes': {'N': '4', 'M': '3'},
       'edges': {'e': {'source': '4', 'label': 'nsubj', 'target': '3'}}}},
     {'sent_id': 'en_partut-ud-913',
      'matching': {'nodes': {'N': '3', 'M': '2'},
       'edges': {'e': {'source': '3', 'label': 'nsubj', 'target': '2'}}}},
     {'sent_id': 'en_partut-ud-913',
      'matching': {'nodes': {'N': '8', 'M': '7'},
       'edges': {'e': {'source': '8', 'label': 'nsubj', 'target': '7'}}}},
     {'sent_id': 'en_partut-ud-912',
      'matching': {'nodes': {'N': '2', 'M': '1'},
       'edges': {'e': {'source': '2', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-910',
      'matching': {'nodes': {'N': '3', 'M': '2'},
       'edges': {'e': {'source': '3', 'label': 'nsubj', 'target': '2'}}}},
     {'sent_id': 'en_partut-ud-910',
      'matching': {'nodes': {'N': '11', 'M': '8'},
       'edges': {'e': {'source': '11', 'label': 'nsubj', 'target': '8'}}}},
     {'sent_id': 'en_partut-ud-909',
      'matching': {'nodes': {'N': '3', 'M': '1'},
       'edges': {'e': {'source': '3', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-908',
      'matching': {'nodes': {'N': '9', 'M': '8'},
       'edges': {'e': {'source': '9', 'label': 'nsubj', 'target': '8'}}}},
     {'sent_id': 'en_partut-ud-906',
      'matching': {'nodes': {'N': '15', 'M': '14'},
       'edges': {'e': {'source': '15', 'label': 'nsubj', 'target': '14'}}}},
     {'sent_id': 'en_partut-ud-906',
      'matching': {'nodes': {'N': '19', 'M': '18'},
       'edges': {'e': {'source': '19', 'label': 'nsubj', 'target': '18'}}}},
     {'sent_id': 'en_partut-ud-905',
      'matching': {'nodes': {'N': '3', 'M': '2'},
       'edges': {'e': {'source': '3', 'label': 'nsubj', 'target': '2'}}}},
     {'sent_id': 'en_partut-ud-903',
      'matching': {'nodes': {'N': '2', 'M': '1'},
       'edges': {'e': {'source': '2', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-903',
      'matching': {'nodes': {'N': '8', 'M': '7'},
       'edges': {'e': {'source': '8', 'label': 'nsubj', 'target': '7'}}}},
     {'sent_id': 'en_partut-ud-902',
      'matching': {'nodes': {'N': '2', 'M': '1'},
       'edges': {'e': {'source': '2', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-901',
      'matching': {'nodes': {'N': '7', 'M': '6'},
       'edges': {'e': {'source': '7', 'label': 'nsubj', 'target': '6'}}}},
     {'sent_id': 'en_partut-ud-901',
      'matching': {'nodes': {'N': '10', 'M': '9'},
       'edges': {'e': {'source': '10', 'label': 'nsubj', 'target': '9'}}}},
     {'sent_id': 'en_partut-ud-901',
      'matching': {'nodes': {'N': '15', 'M': '14'},
       'edges': {'e': {'source': '15', 'label': 'nsubj', 'target': '14'}}}},
     {'sent_id': 'en_partut-ud-899',
      'matching': {'nodes': {'N': '4', 'M': '2'},
       'edges': {'e': {'source': '4', 'label': 'nsubj', 'target': '2'}}}},
     {'sent_id': 'en_partut-ud-898',
      'matching': {'nodes': {'N': '11', 'M': '15'},
       'edges': {'e': {'source': '11', 'label': 'nsubj', 'target': '15'}}}},
     {'sent_id': 'en_partut-ud-897',
      'matching': {'nodes': {'N': '5', 'M': '3'},
       'edges': {'e': {'source': '5', 'label': 'nsubj', 'target': '3'}}}},
     {'sent_id': 'en_partut-ud-897',
      'matching': {'nodes': {'N': '10', 'M': '9'},
       'edges': {'e': {'source': '10', 'label': 'nsubj', 'target': '9'}}}},
     {'sent_id': 'en_partut-ud-896',
      'matching': {'nodes': {'N': '4', 'M': '3'},
       'edges': {'e': {'source': '4', 'label': 'nsubj', 'target': '3'}}}},
     {'sent_id': 'en_partut-ud-895',
      'matching': {'nodes': {'N': '2', 'M': '1'},
       'edges': {'e': {'source': '2', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-895',
      'matching': {'nodes': {'N': '9', 'M': '8'},
       'edges': {'e': {'source': '9', 'label': 'nsubj', 'target': '8'}}}},
     {'sent_id': 'en_partut-ud-895',
      'matching': {'nodes': {'N': '14', 'M': '13'},
       'edges': {'e': {'source': '14', 'label': 'nsubj', 'target': '13'}}}},
     {'sent_id': 'en_partut-ud-894',
      'matching': {'nodes': {'N': '3', 'M': '2'},
       'edges': {'e': {'source': '3', 'label': 'nsubj', 'target': '2'}}}},
     {'sent_id': 'en_partut-ud-894',
      'matching': {'nodes': {'N': '12', 'M': '11'},
       'edges': {'e': {'source': '12', 'label': 'nsubj', 'target': '11'}}}},
     {'sent_id': 'en_partut-ud-893',
      'matching': {'nodes': {'N': '7', 'M': '5'},
       'edges': {'e': {'source': '7', 'label': 'nsubj', 'target': '5'}}}},
     {'sent_id': 'en_partut-ud-892',
      'matching': {'nodes': {'N': '3', 'M': '5'},
       'edges': {'e': {'source': '3', 'label': 'nsubj', 'target': '5'}}}},
     {'sent_id': 'en_partut-ud-891',
      'matching': {'nodes': {'N': '4', 'M': '1'},
       'edges': {'e': {'source': '4', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-891',
      'matching': {'nodes': {'N': '15', 'M': '14'},
       'edges': {'e': {'source': '15', 'label': 'nsubj', 'target': '14'}}}},
     {'sent_id': 'en_partut-ud-890',
      'matching': {'nodes': {'N': '2', 'M': '1'},
       'edges': {'e': {'source': '2', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-889',
      'matching': {'nodes': {'N': '8', 'M': '4'},
       'edges': {'e': {'source': '8', 'label': 'nsubj', 'target': '4'}}}},
     {'sent_id': 'en_partut-ud-889',
      'matching': {'nodes': {'N': '13', 'M': '12'},
       'edges': {'e': {'source': '13', 'label': 'nsubj', 'target': '12'}}}},
     {'sent_id': 'en_partut-ud-886',
      'matching': {'nodes': {'N': '2', 'M': '1'},
       'edges': {'e': {'source': '2', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-886',
      'matching': {'nodes': {'N': '15', 'M': '14'},
       'edges': {'e': {'source': '15', 'label': 'nsubj', 'target': '14'}}}},
     {'sent_id': 'en_partut-ud-885',
      'matching': {'nodes': {'N': '4', 'M': '3'},
       'edges': {'e': {'source': '4', 'label': 'nsubj', 'target': '3'}}}},
     {'sent_id': 'en_partut-ud-884',
      'matching': {'nodes': {'N': '5', 'M': '4'},
       'edges': {'e': {'source': '5', 'label': 'nsubj', 'target': '4'}}}},
     {'sent_id': 'en_partut-ud-882',
      'matching': {'nodes': {'N': '20', 'M': '19'},
       'edges': {'e': {'source': '20', 'label': 'nsubj', 'target': '19'}}}},
     {'sent_id': 'en_partut-ud-881',
      'matching': {'nodes': {'N': '6', 'M': '5'},
       'edges': {'e': {'source': '6', 'label': 'nsubj', 'target': '5'}}}},
     {'sent_id': 'en_partut-ud-881',
      'matching': {'nodes': {'N': '14', 'M': '13'},
       'edges': {'e': {'source': '14', 'label': 'nsubj', 'target': '13'}}}},
     {'sent_id': 'en_partut-ud-881',
      'matching': {'nodes': {'N': '17', 'M': '16'},
       'edges': {'e': {'source': '17', 'label': 'nsubj', 'target': '16'}}}},
     {'sent_id': 'en_partut-ud-880',
      'matching': {'nodes': {'N': '2', 'M': '1'},
       'edges': {'e': {'source': '2', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-878',
      'matching': {'nodes': {'N': '2', 'M': '1'},
       'edges': {'e': {'source': '2', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-877',
      'matching': {'nodes': {'N': '3', 'M': '2'},
       'edges': {'e': {'source': '3', 'label': 'nsubj', 'target': '2'}}}},
     {'sent_id': 'en_partut-ud-877',
      'matching': {'nodes': {'N': '8', 'M': '7'},
       'edges': {'e': {'source': '8', 'label': 'nsubj', 'target': '7'}}}},
     {'sent_id': 'en_partut-ud-876',
      'matching': {'nodes': {'N': '2', 'M': '1'},
       'edges': {'e': {'source': '2', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-875',
      'matching': {'nodes': {'N': '2', 'M': '1'},
       'edges': {'e': {'source': '2', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-875',
      'matching': {'nodes': {'N': '6', 'M': '4'},
       'edges': {'e': {'source': '6', 'label': 'nsubj', 'target': '4'}}}},
     {'sent_id': 'en_partut-ud-873',
      'matching': {'nodes': {'N': '4', 'M': '1'},
       'edges': {'e': {'source': '4', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-872',
      'matching': {'nodes': {'N': '3', 'M': '1'},
       'edges': {'e': {'source': '3', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-871',
      'matching': {'nodes': {'N': '2', 'M': '1'},
       'edges': {'e': {'source': '2', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-771',
      'matching': {'nodes': {'N': '5', 'M': '4'},
       'edges': {'e': {'source': '5', 'label': 'nsubj', 'target': '4'}}}},
     {'sent_id': 'en_partut-ud-724',
      'matching': {'nodes': {'N': '6', 'M': '2'},
       'edges': {'e': {'source': '6', 'label': 'nsubj', 'target': '2'}}}},
     {'sent_id': 'en_partut-ud-610',
      'matching': {'nodes': {'N': '19', 'M': '4'},
       'edges': {'e': {'source': '19', 'label': 'nsubj', 'target': '4'}}}},
     {'sent_id': 'en_partut-ud-465',
      'matching': {'nodes': {'N': '6', 'M': '5'},
       'edges': {'e': {'source': '6', 'label': 'nsubj', 'target': '5'}}}},
     {'sent_id': 'en_partut-ud-434',
      'matching': {'nodes': {'N': '4', 'M': '3'},
       'edges': {'e': {'source': '4', 'label': 'nsubj', 'target': '3'}}}},
     {'sent_id': 'en_partut-ud-434',
      'matching': {'nodes': {'N': '8', 'M': '7'},
       'edges': {'e': {'source': '8', 'label': 'nsubj', 'target': '7'}}}},
     {'sent_id': 'en_partut-ud-409',
      'matching': {'nodes': {'N': '5', 'M': '3'},
       'edges': {'e': {'source': '5', 'label': 'nsubj', 'target': '3'}}}},
     {'sent_id': 'en_partut-ud-382',
      'matching': {'nodes': {'N': '2', 'M': '1'},
       'edges': {'e': {'source': '2', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-382',
      'matching': {'nodes': {'N': '16', 'M': '8'},
       'edges': {'e': {'source': '16', 'label': 'nsubj', 'target': '8'}}}},
     {'sent_id': 'en_partut-ud-382',
      'matching': {'nodes': {'N': '20', 'M': '18'},
       'edges': {'e': {'source': '20', 'label': 'nsubj', 'target': '18'}}}},
     {'sent_id': 'en_partut-ud-382',
      'matching': {'nodes': {'N': '29', 'M': '27'},
       'edges': {'e': {'source': '29', 'label': 'nsubj', 'target': '27'}}}},
     {'sent_id': 'en_partut-ud-341',
      'matching': {'nodes': {'N': '2', 'M': '1'},
       'edges': {'e': {'source': '2', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-341',
      'matching': {'nodes': {'N': '8', 'M': '7'},
       'edges': {'e': {'source': '8', 'label': 'nsubj', 'target': '7'}}}},
     {'sent_id': 'en_partut-ud-294',
      'matching': {'nodes': {'N': '8', 'M': '4'},
       'edges': {'e': {'source': '8', 'label': 'nsubj', 'target': '4'}}}},
     {'sent_id': 'en_partut-ud-294',
      'matching': {'nodes': {'N': '26', 'M': '22'},
       'edges': {'e': {'source': '26', 'label': 'nsubj', 'target': '22'}}}},
     {'sent_id': 'en_partut-ud-294',
      'matching': {'nodes': {'N': '31', 'M': '30'},
       'edges': {'e': {'source': '31', 'label': 'nsubj', 'target': '30'}}}},
     {'sent_id': 'en_partut-ud-291',
      'matching': {'nodes': {'N': '5', 'M': '3'},
       'edges': {'e': {'source': '5', 'label': 'nsubj', 'target': '3'}}}},
     {'sent_id': 'en_partut-ud-291',
      'matching': {'nodes': {'N': '9', 'M': '2'},
       'edges': {'e': {'source': '9', 'label': 'nsubj', 'target': '2'}}}},
     {'sent_id': 'en_partut-ud-291',
      'matching': {'nodes': {'N': '24', 'M': '12'},
       'edges': {'e': {'source': '24', 'label': 'nsubj', 'target': '12'}}}},
     {'sent_id': 'en_partut-ud-285',
      'matching': {'nodes': {'N': '7', 'M': '6'},
       'edges': {'e': {'source': '7', 'label': 'nsubj', 'target': '6'}}}},
     {'sent_id': 'en_partut-ud-266',
      'matching': {'nodes': {'N': '3', 'M': '1'},
       'edges': {'e': {'source': '3', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-266',
      'matching': {'nodes': {'N': '32', 'M': '30'},
       'edges': {'e': {'source': '32', 'label': 'nsubj', 'target': '30'}}}},
     {'sent_id': 'en_partut-ud-264',
      'matching': {'nodes': {'N': '3', 'M': '1'},
       'edges': {'e': {'source': '3', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-264',
      'matching': {'nodes': {'N': '19', 'M': '17'},
       'edges': {'e': {'source': '19', 'label': 'nsubj', 'target': '17'}}}},
     {'sent_id': 'en_partut-ud-179',
      'matching': {'nodes': {'N': '3', 'M': '1'},
       'edges': {'e': {'source': '3', 'label': 'nsubj', 'target': '1'}}}},
     {'sent_id': 'en_partut-ud-118',
      'matching': {'nodes': {'N': '7', 'M': '5'},
       'edges': {'e': {'source': '7', 'label': 'nsubj', 'target': '5'}}}},
     {'sent_id': 'en_partut-ud-85',
      'matching': {'nodes': {'N': '8', 'M': '3'},
       'edges': {'e': {'source': '8', 'label': 'nsubj', 'target': '3'}}}},
     {'sent_id': 'en_partut-ud-85',
      'matching': {'nodes': {'N': '32', 'M': '31'},
       'edges': {'e': {'source': '32', 'label': 'nsubj', 'target': '31'}}}},
     {'sent_id': 'en_partut-ud-72',
      'matching': {'nodes': {'N': '3', 'M': '1'},
       'edges': {'e': {'source': '3', 'label': 'nsubj', 'target': '1'}}}}]

```python_alt
r = Request.from_json([{'pattern': 'e: N -[1=nsubj]-> M'}])
print (corpus.count(r))

r = Request.from_json('pattern { e: N -[1=nsubj]-> M}')
print (corpus.count(r))

r = Request.from_json(['pattern {',  'e: N -[1=nsubj]-> M', '}'])
print (corpus.count(r))

```

    ---------------------------------------------------------------------------

    GrewError                                 Traceback (most recent call last)

    /Users/guillaum/gitlab/grew/grew_doc/content/grewpy/request.ipynb Cell 17 line 2
          <a href='vscode-notebook-cell:/Users/guillaum/gitlab/grew/grew_doc/content/grewpy/request.ipynb#X22sZmlsZQ%3D%3D?line=0'>1</a> r = Request.from_json([{'pattern': 'e: N -[1=nsubj]-> M'}])
    ----> <a href='vscode-notebook-cell:/Users/guillaum/gitlab/grew/grew_doc/content/grewpy/request.ipynb#X22sZmlsZQ%3D%3D?line=1'>2</a> print (corpus.count(r))
          <a href='vscode-notebook-cell:/Users/guillaum/gitlab/grew/grew_doc/content/grewpy/request.ipynb#X22sZmlsZQ%3D%3D?line=3'>4</a> r = Request.from_json('pattern { e: N -[1=nsubj]-> M}')
          <a href='vscode-notebook-cell:/Users/guillaum/gitlab/grew/grew_doc/content/grewpy/request.ipynb#X22sZmlsZQ%3D%3D?line=4'>5</a> print (corpus.count(r))

    File ~/gitlab/grew/grew_doc/content/grewpy/grewpy/corpus.py:228, in Corpus.count(self, request, clustering_parameter, clustering_keys, flat)
        221 def count(self, request, clustering_parameter=[], clustering_keys=[], flat=False):
        222     """
        223     Count for [request] into [corpus_index]
        224     :param request: a string request
        225     :param corpus_index: an integer given by the [corpus] function
        226     :return: the number of matching of [request] into the corpus
        227     """
    --> 228     res = network.send_and_receive({
        229         "command": "corpus_count",
        230         "corpus_index": self._id,
        231         "request": request.json_data(),
        232         "clustering_keys": clustering_parameter + clustering_keys,
        233     })
        234     if not flat:
        235         return res

    File ~/gitlab/grew/grew_doc/content/grewpy/grewpy/network.py:97, in send_and_receive(msg)
         95             return None
         96     elif reply["status"] == "ERROR":
    ---> 97         raise GrewError({"function": msg["command"], "message": reply["message"]})
         98 except socket.error:
         99     raise GrewError({"function": msg["command"], "message" : 'Socket error'})

    GrewError: 
    --------------------------------------------------------------------------------
    {
      "function": "corpus_count",
      "message": "grewlib error: [line: 1] [Grew_loader.Parser.request], Parsing error: ;"
    }
    --------------------------------------------------------------------------------

```python_alt
y.without("N[upos=VERB]")
```

    ---------------------------------------------------------------------------

    ValueError                                Traceback (most recent call last)

    /Users/guillaum/gitlab/grew/grew_doc/content/grewpy/request.ipynb Cell 12 in 1
    ----> <a href='vscode-notebook-cell:/Users/guillaum/gitlab/grew/grew_doc/content/grewpy/request.ipynb#X50sZmlsZQ%3D%3D?line=0'>1</a> y.without("N[upos=VERB]")

    File ~/gitlab/grew/grew_doc/content/grewpy/grewpy/grs.py:81, in Request.without(self, *L)
         79     return self
         80 else:
    ---> 81     raise ValueError("Abstract request")

    ValueError: Abstract request
