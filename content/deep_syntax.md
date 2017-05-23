+++
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""
date = "2017-05-04T21:30:18+02:00"
title = "deep_syntax"
menu = "main"
+++

# Deep syntax

The goal of the deep syntax is to give a linguistic description of the input sentence which is closer to a semantic representation.
More information about deep syntax can be found on the [Deep-sequoia project](http://deep-sequoia.inria.fr).

For the sentence:

- "*La souris a été mangée par le chat.*" ["*The mouse was eaten by the cat.*"].

the deep structure is: ![Deep dependency structure](/img/test.deep.svg)

With __grew__, this representation can be computed from the surface syntax in two steps:

1. A general representation (called __mixed__) encodes both surface and deep syntax in the same structure.
2. A projection from the __mixed__ to the __deep__ structure

## Building the mixed structure
The GRS used to build __mixed__ structure can be obtained from InriaGForge by:
```
svn co svn://scm.gforge.inria.fr/svn/semagramme/grew_resources/deep_syntax
```
The input of the GRS which produced the __mixed__ structure is the __surface__ structure.
We recall here the surface structure (see [Dependency parsing](../parsing) page) for our example sentence and we suppose that the file `test.surf.conll` contains the conll description below:

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

The mixed structure is then computed with the command:
```
grew -det -grs deep_syntax/grs/deep_synt_main.grs -i test.surf.conll -f test.mix.conll
```

which produces the file `test.mix.conll` which contains the code below corresponding the next figure
```
1	La	le	D	DET	sentid=00000	2	det	_	_
2	souris	souris	N	NC	det=y|s=c	5	suj:obj	_	_
3	a	avoir	V	V	dl=avoir|m=ind|void=y	5	S:aux.tps	_	_
4	été	être	V	VPP	dl=être|m=part|t=past|void=y	5	S:aux.pass	_	_
5	mangée	manger	V	VPP	diat=passif|dl=manger|dm=ind|m=part|t=past	_	_	_	_
6	par	par	P	P	void=y	5	S:p_obj.agt:suj	_	_
7	le	le	D	DET	_	8	det	_	_
8	chat	chat	N	NC	det=y|s=c	6|5	S:obj.p|D:p_obj.agt:suj	_	_
9	.	.	PONCT	PONCT	_	5	ponct	_	_
```
![Mixed dependency structure](/img/test.mix.svg)

## Building the deep structure
The deep structure is a projection form the mixed structure.
This projection is realized with à GRS file `sequoia_proj.grs` which can be download with the commands:

```
wget https://gitlab.inria.fr/sequoia/deep-sequoia/raw/master/tools/sequoia_decl.dom
wget https://gitlab.inria.fr/sequoia/deep-sequoia/raw/master/tools/sequoia_proj.grs
```

The deep structure is then computed with the command:
```
grew -det -grs sequoia_proj.grs -seq deep -i test.mix.conll -f test.deep.conll
```

The output is given below (code and picture):


```
1	La	le	D	DET	sentid=00000	2	det	_	_
2	souris	souris	N	NC	det=y|s=c	5	obj	_	_
3	a	avoir	V	V	dl=avoir|m=ind|void=y	0	void	_	_
4	été	être	V	VPP	dl=être|m=part|t=past|void=y	0	void	_	_
5	mangée	manger	V	VPP	diat=passif|dl=manger|dm=ind|m=part|t=past	_	_	_	_
6	par	par	P	P	void=y	0	void	_	_
7	le	le	D	DET	_	8	det	_	_
8	chat	chat	N	NC	det=y|s=c	5	suj	_	_
9	.	.	PONCT	PONCT	_	5	ponct	_	_
```

![Deep dependency structure](/img/test.deep.svg)


