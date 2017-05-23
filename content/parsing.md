+++
date = "2017-03-15T22:22:20+01:00"
title = "parsing"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""
+++

# Dependency parsing
The parsing GRS is described in [IWPT 2015](https://hal.inria.fr/hal-01188694).

It takes as input the POS-tagged representation of a French sentence and returns a surface dependency syntax tree following the FTB/Sequoia format.

## Downloading the GRS system
The GRS can be obtained from InriaGForge with the command:

`svn co svn://scm.gforge.inria.fr/svn/semagramme/grew_resources/parsing`

## Input data for the system
The parsing system is waiting for a pos-tagged input.
One easy way to produce such a pos-tagged French sentence is to use [MElt](https://gforge.inria.fr/frs/?group_id=481).
We consider the sentence:

- "*La souris a été mangée par le chat.*" ["*The mouse was eaten by the cat.*"].

One way to tag the sentence is to use the following command:

`echo "La souris a été mangée par le chat." | MElt -L -T > test.melt`

This produces a file `test.melt` which contains:

```
La/DET/le souris/NC/souris a/V/avoir été/VPP/être mangée/VPP/manger par/P/par le/DET/le chat/NC/chat ./PONCT/.
```

## Running the GR parser in GUI
The following command runs a GTK interface in which you can explore step by step rewriting of the input sentence:

`grew -grs parsing/grs/surf_synt_main.grs -seq full -gr test.melt`



## Running the GR parser from command line
The command to produced a Conll version of the parsed sentence:

`grew -det -grs parsing/grs/surf_synt_main.grs -seq full -i test.melt -f test.surf.conll`

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

