+++
date = "2017-03-15T22:22:20+01:00"
title = "parsing"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""
+++

# Dependency parsing

**Grew-parse-FR** is natural language parser for French.
It is composed of a GRS (Graph Rewriting System) which can be used with the Grew software to produce dependency syntax structures from POS-tagged data.
With a POS-tagger (**MElt** is recommended), it provides a full parser with sentences as input and dependency structures as output.
The parsing GRS is described in an [IWPT 2015 publication](https://hal.inria.fr/hal-01188694).

# How to parse a sentence?

We consider the sentence:

- *"La souris a été mangée par le chat."* [*"The mouse was eaten by the cat."*].

The parsing is done in two steps:

1. POS-tagging with **MElt**
2. Building the dependency syntax structure by applying Graph Rewriting System

# Prerequisite

 * **MElt**: see [MElt download page](https://gforge.inria.fr/frs/?group_id=481)
 * **Grew**: see [Installation page](../installation)
 * **POStoSSQ**: get it with the command: `git clone https://gitlab.inria.fr/grew/POStoSSQ.git`

# More info on the parsing process

## POS-tagging
The parsing system **POStoSSQ** is waiting for a pos-tagged input.
One easy way to produce such a pos-tagged French sentence is to use [MElt](https://gforge.inria.fr/frs/?group_id=481).
It should be possible to use another tagger but this may require a few categories matching to adapt the output of the tagger.

With **MElt**, the options used `-L` and `-T` are used to tokenize the input sentence and to lemmatize the output.
For instance, the following command:

`echo "La souris a été mangée par le chat." | MElt -L -T > test.melt`

produces the file [`test.melt`](/parsing/test.melt):

{{< input file="/static/parsing/test.melt" >}}

## Parsing with the GRS

With the file [`test.melt`](/parsing/test.melt) described above, the following command produces the CoNLL code of the parsed sentence:

`grew transform -grs POStoSSQ/grs/surf_synt_main.grs -i test.melt -o test.surf.conll`

The output file is [`test.surf.conll`](/parsing/test.surf.conll):

{{< input file="/static/parsing/test.surf.conll" >}}

which encodes the syntactic structure:

![Dependency structure](/parsing/test.svg)

It is also possible to runs a GTK interface in which you can explore step by step rewriting of the input sentence:

`grew gui -grs POStoSSQ/grs/surf_synt_main.grs -i test.melt`

## Parsing a set of sentence
No explicit linking with a sentence tokenizer is provided.
We will suppose here that the input file is already split in sentences (one by line).

Suppose that the file [`tdm80_ch01.txt`](/parsing/tdm80_ch01.txt) contains the following data:

{{< input file="/static/parsing/tdm80_ch01.txt" >}}

The parsing can be done with the same two steps process:

1. POS-tagging with melt: `cat tdm80_ch01.txt | MElt -L -T > tdm80_ch01.melt`
2. Building the dependency syntax structure: `grew transform -grs POStoSSQ/grs/surf_synt_main.grs -i tdm80_ch01.melt -o tdm80_ch01.conll`

