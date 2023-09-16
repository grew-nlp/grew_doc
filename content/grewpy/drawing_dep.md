---
title: "Grewpy • drawing dependencies"
date: 2023-09-19
---

# `grewpy` library: Drawing dependencies

The code below initializes Grewpy, load a `corpus` and a `graph` from the `corpus`.

```python_alt
from grewpy import Corpus, Request, Graph
corpus = Corpus("data/en_partut-ud-dev.conllu")
graph = corpus["en_partut-ud-1926"]
```

    connected to port: 60284

## Build the SVG picture for a graph

In the Graph module, the method `to_svg` produces the SVG code for the dependency structure picture.
The code below stores the result in a new file `1926.svg`.

```python_alt
with open("1926.svg", 'w') as f:
  f.write (graph.to_svg())
```

By default, the _anchor_ node (noted `__0__`) and the `root` link between it and the root of the sentence are not drawn.
With the option `draw_root`, the drawing of the anchor node and the `root` link is added.

```python_alt
with open("1926_with_root.svg", 'w') as f:
  f.write (graph.to_svg(draw_root=True))
```

## Drawing dep structure with highlighted matching
It is possible to create an image of a graph with highlighted matching, as in the Grew-match interface.
To do this, we should specify that we want to keep the _decoration_ of the graph when searching the corpus. The optional argument `deco=True` does exactly that.

```python_alt
request = Request.parse ("pattern { N[lemma=question] }")
matchings = corpus.search(request, deco=True)
print (matchings)
```

    [{'sent_id': 'en_partut-ud-1926', 'matching': {'nodes': {'N': '4'}, 'edges': {}}, 'deco': 2}, {'sent_id': 'en_partut-ud-1101', 'matching': {'nodes': {'N': '15'}, 'edges': {}}, 'deco': 1}]

Each item in the list has an (abstract) attribute `order` which can be used in further function calls to manage graph decoration.

Let `g1` be the first matched graph and `d1` the decoration asscioted to the matching:

```python_alt
g1 = corpus[matchings[0]["sent_id"]]
d1 = matchings[0]["deco"]
```

The decorated SVG is computed and saved in a file `question_with_deco.svg` with:

```python_alt
with open("question_with_deco.svg", 'w') as f:
  f.write (g1.to_svg (deco=d1))
```

The decoration can also be used in method `to_sentence` to produced the _highlighted_ sentence (like the text in red in Grew-match interface) using some HTML class called `highlight`.

```python_alt
g1.to_sentence (deco=d1)
```

    'that is the <span class="highlight">question</span>". '
