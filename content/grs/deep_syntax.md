+++
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""
date = "2017-05-04T21:30:18+02:00"
title = "deep_syntax"
menu = "main"
+++

# Deep syntax

The goal of the deep syntax is to give a linguistic description of sentences which is closer to a semantic representation.
More information about deep syntax can be found on the [Deep-sequoia project](http://deep-sequoia.inria.fr).

For the sentence:

- "*La souris a été mangée par le chat.*" ["*The mouse was eaten by the cat.*"].

the deep structure (following Deep-sequoia guidelines) is: ![Deep dependency structure](/deep_syntax/test.deep.svg)

With **Grew**, this representation can be computed from the surface syntax in two steps:

1. A general representation (called **deep_and_surf**) encodes both surface and deep syntax in the same structure.
2. A projection from the **deep_and_surf** to the **deep** structure

## Building the mixed structure
The GRS used to build the mixed **deep_and_surf** structure can be obtained by:

`git clone https://gitlab.inria.fr/grew/SSQtoDSQ.git`

The input of the GRS which produced the **deep_and_surf** structure is the **surf** structure.
We recall here the surface structure (see [Dependency parsing](../parsing) page) for our example sentence and we suppose that the file [`test.surf.conll`](test.surf.conll) contains the CoNLL-U description below:

{{< input file="/static/grs/deep_syntax/test.surf.conll" >}}

The mixed structure is then computed with the command:

`grew transform -grs SSQtoDSQ/grs/main_dsq.grs -i test.surf.conll -o test.deep_and_surf.conll`

which produces the file [`test.deep_and_surf.conll`](_build/test.deep_and_surf.conll) which contains the code below corresponding the next figure

{{< input file="/static/grs/deep_syntax/_build/test.deep_and_surf.conll" >}}

![Mixed dependency structure](/grs/deep_syntax/_build/test.deep_and_surf.svg)

## Building the deep structure
The deep structure is a projection form the mixed structure.
This projection is realised with a GRS file [`sequoia_proj.grs`](_build/sequoia_proj.grs) which can be download with the commands:

```
wget https://gitlab.inria.fr/sequoia/deep-sequoia/raw/master/tools/sequoia_proj.grs
```

The deep structure is then computed with the command:

`grew transform -grs sequoia_proj.grs -strat deep -i test.deep_and_surf.conll -o test.deep.conll`

The output [`test.deep.conll`](_build/test.deep.conll) is given below (code and picture):

{{< input file="/static/grs/deep_syntax/_build/test.deep.conll" >}}

![Deep dependency structure](/grs/deep_syntax/_build/test.deep.svg)


