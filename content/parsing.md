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
With a POS-tagger (MElt is a recommended), it provides a full parser with sentences as input and dependency structures as output
The parsing GRS is described in an [IWPT 2015 publication](https://hal.inria.fr/hal-01188694).

# How to parse a sentence?
Prerequisite: the Grew software, the MElt software, the POStoSSQ rewriting system (see below for installation procedures).

We consider the sentence:

- *"La souris a été mangée par le chat."* [*"The mouse was eaten by the cat."*].

The parsing is done in two steps:

1. POS-tagging with melt: `echo "La souris a été mangée par le chat." | MElt -L -T > test.melt`
2. Building the dependency syntax structure: `grew -det -grs POStoSSQ/grs/surf_synt_main.grs -seq full -i test.melt -f test.conll`


# Prerequisite

 * **MElt**: see [MElt download page](https://gforge.inria.fr/frs/?group_id=481)
 * **Grew**: see [Installation page](../installation)
 * **POStoSSQ**: get it with the command: `git clone https://gitlab.inria.fr/grew/POStoSSQ.git`

# More info on the parsing process

## POS-tagging
The parsing system **POStoSSQ** is waiting for a pos-tagged input.
One easy way to produce such a pos-tagged French sentence is to use [MElt](https://gforge.inria.fr/frs/?group_id=481).
It should be possible to use another tagger but this may require a few caterories matching to adapt the output of the tagger.

With MElt, the options used `-L` and `-T` ask MElt to tokenize the input sentence and to lemmatize the output.
For instance, the output of the following command:

`echo "La souris a été mangée par le chat." | MElt -L -T`

is:

```
La/DET/le souris/NC/souris a/V/avoir été/VPP/être mangée/VPP/manger par/P/par le/DET/le chat/NC/chat ./PONCT/.
```

## Parsing with the GRS

If we supposed that the file `test.melt` contains a POS-tagged sentence like the one given above:

```
La/DET/le souris/NC/souris a/V/avoir été/VPP/être mangée/VPP/manger par/P/par le/DET/le chat/NC/chat ./PONCT/.
```

The command to produced a Conll version of the parsed sentence:

`grew -det -grs POStoSSQ/grs/surf_synt_main.grs -seq full -i test.melt -f test.conll`

The produced file contains the Conll description:
```
1	La	le	D	DET	sentid=00000	2	det	_	_
2	souris	souris	N	NC	det=y|s=c	5	suj	_	_
3	a	avoir	V	V	m=ind	5	aux.tps	_	_
4	été	être	V	VPP	m=pastp	5	aux.pass	_	_
5	mangée	manger	V	VPP	diat=passif|m=pastp	_	_	_	_
6	par	par	P	P	_	5	p_obj.agt	_	_
7	le	le	D	DET	_	8	det	_	_
8	chat	chat	N	NC	det=y|s=c	6	obj.p	_	_
9	.	.	PONCT	PONCT	_	5	ponct	_	_
```

which encodes the syntactic structure:

![Dependency structure](/img/test.surf.svg)

It is also possible to runs a GTK interface in which you can explore step by step rewriting of the input sentence:

`grew -grs POStoSSQ/grs/surf_synt_main.grs -seq full -gr test.melt`

## Parsing a set of sentence
No explicit linking with a sentence tokenizer is provided.
We will suppose here that the input file is alredy split in sentences (one by line).

Suppose that the file [`tdm80_ch01.txt`](/examples/tdm80_ch01.txt) contains the following data:

```
En l'année 1872, la maison portant le numéro 7 de Saville-row, Burlington Gardens - maison dans laquelle Sheridan mourut en 1814 - , était habitée par Phileas Fogg, esq., l'un des membres les plus singuliers et les plus remarqués du Reform-Club de Londres, bien qu'il semblât prendre à tâche de ne rien faire qui pût attirer l'attention.
À l'un des plus grands orateurs qui honorent l'Angleterre, succédait donc ce Phileas Fogg, personnage énigmatique, dont on ne savait rien, sinon que c'était un fort galant homme et l'un des plus beaux gentlemen de la haute société anglaise.
On disait qu'il ressemblait à Byron - par la tête, car il était irréprochable quant aux pieds - , mais un Byron à moustaches et à favoris, un Byron impassible, qui aurait vécu mille ans sans vieillir.
Anglais, à coup sûr, Phileas Fogg n'était peut-être pas Londonner.
On ne l'avait jamais vu ni à la Bourse, ni à la Banque, ni dans aucun des comptoirs de la Cité.
Ni les bassins ni les docks de Londres n'avaient jamais reçu un navire ayant pour armateur Phileas Fogg.
Ce gentleman ne figurait dans aucun comité d'administration.
```

The parsing can be done with the same two steps process:

1. POS-tagging with melt: `cat tdm80_ch01.txt | MElt -L -T > tdm80_ch01.melt`
2. Building the dependency syntax structure: `grew -det -grs POStoSSQ/grs/surf_synt_main.grs -seq full -i tdm80_ch01.melt -f tdm80_ch01.conll`

