---
title: "Grewpy • drawing dependencies"
date: 2023-09-19
---

[`grewpy` Tutorial](../tutorial)

# `grewpy` library: Drawing dependencies

Download the notebook [here](../drawing_dep.ipynb).

The code below initializes Grewpy, load a `corpus` and a `graph` from the `corpus`.

```python_alt
import grewpy
from grewpy import Corpus, Request, Graph
grewpy.set_config("sud") # ud or basic
corpus = Corpus("SUD_English-PUD")
sent_id = "n01003007"
graph = corpus[sent_id]
```

    connected to port: 57056

```python_alt
graph.to_svg()
```

    '<?xml version="1.0" standalone="no"?>\n<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"\n"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">\n<!-- Created with dep2pict -->\n<svg xmlns:svg="http://www.w3.org/2000/svg" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="1252.49414" height="321.72461">\n<rect x="0" y="0" width="1252.49414" height="321.72461" style="fill:white;fill-opacity:0;" />\n<g  transform="translate(0,159.36719) scale(2,2)">\n<text id="word__N_1" x="33.6455" y="-14.4062" font-style="normal" font-weight="normal" fill="black" font-size="12" font-family="Arial" text-anchor="middle" text-align="center">\n<tspan   x="33.6455" dy="12.8633">$</tspan>\n</text>\n<text id="subword__N_1" x="33.6455" y="-1.54297" fill="black" font-size="7" font-family="Arial" text-anchor="middle" text-align="center">\n<tspan   x="33.6455" dy="8.33691">upos=SYM</tspan>\n<tspan   x="33.6455" dy="8.33691">lemma=$</tspan>\n<tspan   x="33.6455" dy="8.33691">xpos=$</tspan>\n<tspan   x="33.6455" dy="8.33691">SpaceAfter=No</tspan>\n<tspan   x="33.6455" dy="8.33691">textform=$</tspan>\n<tspan   x="33.6455" dy="8.33691">wordform=$</tspan>\n</text>\n<text id="word__N_2" x="102.591" y="-14.4062" font-style="normal" font-weight="normal" fill="black" font-size="12" font-family="Arial" text-anchor="middle" text-align="center">\n<tspan   x="102.591" dy="12.8633">5,000</tspan>\n</text>\n<text id="subword__N_2" x="102.591" y="-1.54297" fill="black" font-size="7" font-family="Arial" text-anchor="middle" text-align="center">\n<tspan   x="102.591" dy="8.33691">upos=NUM</tspan>\n<tspan   x="102.591" dy="8.33691">lemma=5,000</tspan>\n<tspan   x="102.591" dy="8.33691">xpos=CD</tspan>\n<tspan   x="102.591" dy="8.33691">NumForm=Digit</tspan>\n<tspan   x="102.591" dy="8.33691">NumType=Card</tspan>\n<tspan   x="102.591" dy="8.33691">textform=5,000</tspan>\n<tspan   x="102.591" dy="8.33691">wordform=5,000</tspan>\n</text>\n<text id="word__N_3" x="169.706" y="-14.4062" font-style="normal" font-weight="normal" fill="black" font-size="12" font-family="Arial" text-anchor="middle" text-align="center">\n<tspan   x="169.706" dy="12.8633">per</tspan>\n</text>\n<text id="subword__N_3" x="169.706" y="-1.54297" fill="black" font-size="7" font-family="Arial" text-anchor="middle" text-align="center">\n<tspan   x="169.706" dy="8.33691">upos=ADP</tspan>\n<tspan   x="169.706" dy="8.33691">lemma=per</tspan>\n<tspan   x="169.706" dy="8.33691">xpos=IN</tspan>\n<tspan   x="169.706" dy="8.33691">textform=per</tspan>\n<tspan   x="169.706" dy="8.33691">wordform=per</tspan>\n</text>\n<text id="word__N_4" x="238.69" y="-14.4062" font-style="normal" font-weight="normal" fill="black" font-size="12" font-family="Arial" text-anchor="middle" text-align="center">\n<tspan   x="238.69" dy="12.8633">person</tspan>\n</text>\n<text id="subword__N_4" x="238.69" y="-1.54297" fill="black" font-size="7" font-family="Arial" text-anchor="middle" text-align="center">\n<tspan   x="238.69" dy="8.33691">upos=NOUN</tspan>\n<tspan   x="238.69" dy="8.33691">lemma=person</tspan>\n<tspan   x="238.69" dy="8.33691">xpos=NN</tspan>\n<tspan   x="238.69" dy="8.33691">Number=Sing</tspan>\n<tspan   x="238.69" dy="8.33691">SpaceAfter=No</tspan>\n<tspan   x="238.69" dy="8.33691">textform=person</tspan>\n<tspan   x="238.69" dy="8.33691">wordform=person</tspan>\n</text>\n<text id="word__N_5" x="307.255" y="-14.4062" font-style="normal" font-weight="normal" fill="black" font-size="12" font-family="Arial" text-anchor="middle" text-align="center">\n<tspan   x="307.255" dy="12.8633">,</tspan>\n</text>\n<text id="subword__N_5" x="307.255" y="-1.54297" fill="black" font-size="7" font-family="Arial" text-anchor="middle" text-align="center">\n<tspan   x="307.255" dy="8.33691">upos=PUNCT</tspan>\n<tspan   x="307.255" dy="8.33691">lemma=,</tspan>\n<tspan   x="307.255" dy="8.33691">xpos=,</tspan>\n<tspan   x="307.255" dy="8.33691">textform=,</tspan>\n<tspan   x="307.255" dy="8.33691">wordform=,</tspan>\n</text>\n<text id="word__N_6" x="370.078" y="-14.4062" font-style="normal" font-weight="normal" fill="black" font-size="12" font-family="Arial" text-anchor="middle" text-align="center">\n<tspan   x="370.078" dy="12.8633">the</tspan>\n</text>\n<text id="subword__N_6" x="370.078" y="-1.54297" fill="black" font-size="7" font-family="Arial" text-anchor="middle" text-align="center">\n<tspan   x="370.078" dy="8.33691">upos=DET</tspan>\n<tspan   x="370.078" dy="8.33691">lemma=the</tspan>\n<tspan   x="370.078" dy="8.33691">xpos=DT</tspan>\n<tspan   x="370.078" dy="8.33691">Definite=Def</tspan>\n<tspan   x="370.078" dy="8.33691">PronType=Art</tspan>\n<tspan   x="370.078" dy="8.33691">textform=the</tspan>\n<tspan   x="370.078" dy="8.33691">wordform=the</tspan>\n</text>\n<text id="word__N_7" x="443.158" y="-14.4062" font-style="normal" font-weight="normal" fill="black" font-size="12" font-family="Arial" text-anchor="middle" text-align="center">\n<tspan   x="443.158" dy="12.8633">maximum</tspan>\n</text>\n<text id="subword__N_7" x="443.158" y="-1.54297" fill="black" font-size="7" font-family="Arial" text-anchor="middle" text-align="center">\n<tspan   x="443.158" dy="8.33691">upos=NOUN</tspan>\n<tspan   x="443.158" dy="8.33691">lemma=maximum</tspan>\n<tspan   x="443.158" dy="8.33691">xpos=NN</tspan>\n<tspan   x="443.158" dy="8.33691">Number=Sing</tspan>\n<tspan   x="443.158" dy="8.33691">textform=maximum</tspan>\n<tspan   x="443.158" dy="8.33691">wordform=maximum</tspan>\n</text>\n<text id="word__N_8" x="523.133" y="-14.4062" font-style="normal" font-weight="normal" fill="black" font-size="12" font-family="Arial" text-anchor="middle" text-align="center">\n<tspan   x="523.133" dy="12.8633">allowed</tspan>\n</text>\n<text id="subword__N_8" x="523.133" y="-1.54297" fill="black" font-size="7" font-family="Arial" text-anchor="middle" text-align="center">\n<tspan   x="523.133" dy="8.33691">upos=VERB</tspan>\n<tspan   x="523.133" dy="8.33691">lemma=allow</tspan>\n<tspan   x="523.133" dy="8.33691">xpos=VBN</tspan>\n<tspan   x="523.133" dy="8.33691">SpaceAfter=No</tspan>\n<tspan   x="523.133" dy="8.33691">Tense=Past</tspan>\n<tspan   x="523.133" dy="8.33691">VerbForm=Part</tspan>\n<tspan   x="523.133" dy="8.33691">textform=allowed</tspan>\n<tspan   x="523.133" dy="8.33691">wordform=allowed</tspan>\n</text>\n<text id="word__N_9" x="592.852" y="-14.4062" font-style="normal" font-weight="normal" fill="black" font-size="12" font-family="Arial" text-anchor="middle" text-align="center">\n<tspan   x="592.852" dy="12.8633">.</tspan>\n</text>\n<text id="subword__N_9" x="592.852" y="-1.54297" fill="black" font-size="7" font-family="Arial" text-anchor="middle" text-align="center">\n<tspan   x="592.852" dy="8.33691">upos=PUNCT</tspan>\n<tspan   x="592.852" dy="8.33691">lemma=.</tspan>\n<tspan   x="592.852" dy="8.33691">xpos=.</tspan>\n<tspan   x="592.852" dy="8.33691">textform=.</tspan>\n<tspan   x="592.852" dy="8.33691">wordform=.</tspan>\n</text>\n\n<marker id="markerendword_0" markerWidth="5" markerHeight="5" markerUnits="userSpaceOnUse" orient="auto" refX="2" refY="2">\n<path d="M0,0 l4,2 l-4,2 z" style="fill:black;"/>\n</marker>\n<text id="label__N_1__N_2__mod" x="72.64551" y="-24.40625" style="fill:black;font-size:7px;font-family:Arial;text-anchor:middle;text-align:center" >mod</text>\n<path style="marker-end:url(#markerendword_0);" stroke="black" fill="none" d="M 43.64551,-13.40625 43.64551,-18.40625 A 3 3 0 0 1 46.64551,-21.40625 L 99.59082,-21.40625 A 3 3 0 0 1 102.59082,-18.40625 L 102.59082,-13.40625" ></path>\n<marker id="markerendword_5" markerWidth="5" markerHeight="5" markerUnits="userSpaceOnUse" orient="auto" refX="2" refY="2">\n<path d="M0,0 l4,2 l-4,2 z" style="fill:black;"/>\n</marker>\n<text id="label__N_3__N_4__comp:obj" x="205.20581" y="-24.40625" style="fill:black;font-size:7px;font-family:Arial;text-anchor:middle;text-align:center" >comp:obj</text>\n<path style="marker-end:url(#markerendword_5);" stroke="black" fill="none" d="M 172.20581,-13.40625 172.20581,-18.40625 A 3 3 0 0 1 175.20581,-21.40625 L 235.69043,-21.40625 A 3 3 0 0 1 238.69043,-18.40625 L 238.69043,-13.40625" ></path>\n<marker id="markerendword_6" markerWidth="5" markerHeight="5" markerUnits="userSpaceOnUse" orient="auto" refX="2" refY="2">\n<path d="M0,0 l4,2 l-4,2 z" style="fill:black;"/>\n</marker>\n<text id="label__N_7__N_6__det" x="404.07837" y="-24.40625" style="fill:black;font-size:7px;font-family:Arial;text-anchor:middle;text-align:center" >det</text>\n<path style="marker-end:url(#markerendword_6);" stroke="black" fill="none" d="M 438.15771,-13.40625 438.15771,-18.40625 A 3 3 0 0 0 435.15771,-21.40625 L 373.07837,-21.40625 A 3 3 0 0 0 370.07837,-18.40625 L 370.07837,-13.40625" ></path>\n<marker id="markerendword_7" markerWidth="5" markerHeight="5" markerUnits="userSpaceOnUse" orient="auto" refX="2" refY="2">\n<path d="M0,0 l4,2 l-4,2 z" style="fill:black;"/>\n</marker>\n<text id="label__N_7__N_8__mod" x="485.15771" y="-24.40625" style="fill:black;font-size:7px;font-family:Arial;text-anchor:middle;text-align:center" >mod</text>\n<path style="marker-end:url(#markerendword_7);" stroke="black" fill="none" d="M 448.15771,-13.40625 448.15771,-18.40625 A 3 3 0 0 1 451.15771,-21.40625 L 520.13281,-21.40625 A 3 3 0 0 1 523.13281,-18.40625 L 523.13281,-13.40625" ></path>\n<marker id="markerendword_1" markerWidth="5" markerHeight="5" markerUnits="userSpaceOnUse" orient="auto" refX="2" refY="2">\n<path d="M0,0 l4,2 l-4,2 z" style="fill:black;"/>\n</marker>\n<text id="label__N_1__N_3__udep" x="102.64551" y="-34.40625" style="fill:black;font-size:7px;font-family:Arial;text-anchor:middle;text-align:center" >udep</text>\n<path style="marker-end:url(#markerendword_1);" stroke="black" fill="none" d="M 38.64551,-13.40625 38.64551,-28.40625 A 3 3 0 0 1 41.64551,-31.40625 L 164.20581,-31.40625 A 3 3 0 0 1 167.20581,-28.40625 L 167.20581,-13.40625" ></path>\n<marker id="markerendword_2" markerWidth="5" markerHeight="5" markerUnits="userSpaceOnUse" orient="auto" refX="2" refY="2">\n<path d="M0,0 l4,2 l-4,2 z" style="fill:black;"/>\n</marker>\n<text id="label__N_1__N_5__punct" x="170.14551" y="-44.40625" style="fill:black;font-size:7px;font-family:Arial;text-anchor:middle;text-align:center" >punct</text>\n<path style="marker-end:url(#markerendword_2);" stroke="black" fill="none" d="M 33.64551,-13.40625 33.64551,-38.40625 A 3 3 0 0 1 36.64551,-41.40625 L 304.25464,-41.40625 A 3 3 0 0 1 307.25464,-38.40625 L 307.25464,-13.40625" ></path>\n<marker id="markerendword_3" markerWidth="5" markerHeight="5" markerUnits="userSpaceOnUse" orient="auto" refX="2" refY="2">\n<path d="M0,0 l4,2 l-4,2 z" style="fill:black;"/>\n</marker>\n<text id="label__N_1__N_7__appos" x="235.64551" y="-54.40625" style="fill:black;font-size:7px;font-family:Arial;text-anchor:middle;text-align:center" >appos</text>\n<path style="marker-end:url(#markerendword_3);" stroke="black" fill="none" d="M 28.64551,-13.40625 28.64551,-48.40625 A 3 3 0 0 1 31.64551,-51.40625 L 440.15771,-51.40625 A 3 3 0 0 1 443.15771,-48.40625 L 443.15771,-13.40625" ></path>\n<marker id="markerendword_4" markerWidth="5" markerHeight="5" markerUnits="userSpaceOnUse" orient="auto" refX="2" refY="2">\n<path d="M0,0 l4,2 l-4,2 z" style="fill:black;"/>\n</marker>\n<text id="label__N_1__N_9__punct" x="308.14551" y="-64.40625" style="fill:black;font-size:7px;font-family:Arial;text-anchor:middle;text-align:center" >punct</text>\n<path style="marker-end:url(#markerendword_4);" stroke="black" fill="none" d="M 23.64551,-13.40625 23.64551,-58.40625 A 3 3 0 0 1 26.64551,-61.40625 L 589.85229,-61.40625 A 3 3 0 0 1 592.85229,-58.40625 L 592.85229,-13.40625" ></path>\n\n\n</g>\n</svg>\n'

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
request = Request("pattern { N[lemma=question] }")
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
