---
title: "Grewpy • drawing dependencies"
date: 2023-09-19
---

[`grewpy` Tutorial](../top)

# `grewpy` library: Drawing dependencies

The code below initializes Grewpy, load a `corpus` and a `graph` from the `corpus`.

```python_alt
import grewpy
from grewpy import Corpus, Request, Graph
grewpy.set_config("sud") # ud or basic
corpus = Corpus("SUD_English-PUD")
sent_id = "n01003007"
graph = corpus[sent_id]
```

    connected to port: 53999

## Build the SVG picture for a graph

In the Graph module, the method `to_svg` produces the SVG code for the dependency structure picture.
The code below stores the result in a new file `1926.svg`.

```python_alt
import os
os.makedirs("images", exist_ok = True)
with open("images/n01003007.svg", 'w') as f:
  f.write (graph.to_svg())
```

![n01003007 image](../images/n01003007.svg)

By default, the _anchor_ node (noted `__0__`) and the `root` link between it and the root of the sentence are not drawn.
With the option `draw_root`, the drawing of the anchor node and the `root` link is added.

```python_alt
with open("images/n01003007_with_root.svg", 'w') as f:
  f.write (graph.to_svg(draw_root=True))
```

![n01003007_with_root image](../images/n01003007_with_root.svg)

## Drawing dep structure with highlighted matching
It is possible to create an image of a graph with highlighted matching, as in the Grew-match interface.
To do this, we should specify that we want to keep the _decoration_ of the graph when searching the corpus. The optional argument `deco=True` does exactly that.

```python_alt
request = Request.parse ("pattern { N[lemma=question] }")
matchings = corpus.search(request, deco=True)
print (matchings)
```

    [{'sent_id': 'n03009011', 'matching': {'nodes': {'N': '13'}, 'edges': {}}, 'deco': 7}, {'sent_id': 'w01028050', 'matching': {'nodes': {'N': '9'}, 'edges': {}}, 'deco': 6}, {'sent_id': 'n01092025', 'matching': {'nodes': {'N': '21'}, 'edges': {}}, 'deco': 5}, {'sent_id': 'n01057036', 'matching': {'nodes': {'N': '5'}, 'edges': {}}, 'deco': 4}, {'sent_id': 'n01042004', 'matching': {'nodes': {'N': '22'}, 'edges': {}}, 'deco': 3}, {'sent_id': 'n01035004', 'matching': {'nodes': {'N': '17'}, 'edges': {}}, 'deco': 2}, {'sent_id': 'n01019005', 'matching': {'nodes': {'N': '6'}, 'edges': {}}, 'deco': 1}]

Each item in the list has an (abstract) attribute `order` which can be used in further function calls to manage graph decoration.

Let `g1` be the first matched graph and `d1` the decoration associated to the matching:

```python_alt
g1 = corpus[matchings[1]["sent_id"]]
d1 = matchings[1]["deco"]
```

The decorated SVG is computed and saved in a file `question_with_deco.svg` with:

```python_alt
with open("images/question_with_deco.svg", 'w') as f:
  f.write (g1.to_svg (deco=d1))
```

![question_with_deco image](../images/question_with_deco.svg)

The decoration can also be used in method `to_sentence` to produced the _highlighted_ sentence (like the text in red in Grew-match interface) using some HTML class called `highlight`.

```python_alt
g1.to_sentence (deco=d1)
```

    'At the heart of the conflict was the <span class="highlight">question</span> of whether Kansas would enter the Union as a free state or slave state. '
