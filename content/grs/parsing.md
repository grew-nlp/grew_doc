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
With a POS-tagger (**Talismane** is recommended), it provides a full parser with sentences as input and dependency structures as output.
The parsing GRS is described in an [IWPT 2015 publication](https://hal.inria.fr/hal-01188694).

# How to parse a sentence?

We consider the sentence:

- *"La souris a été mangée par le chat."* [*"The mouse was eaten by the cat."*].

The parsing is done in three steps:

1. POS-tagging with **Talismane**
2. Convert **Talismane** into a format usable by **Grew** (a **sed** script)
3. Building the dependency syntax structure by applying Graph Rewriting System

# Prerequisite

 * **Talismane**:
  * Download from [Talismane github page](https://github.com/joliciel-informatique/talismane/releases), the 3 files: `talismane-distribution-5.2.0-bin.zip`, `frenchLanguagePack-5.2.0.zip` and `talismane-fr-5.2.0.conf`.
  * Unzip `talismane-distribution-5.2.0-bin.zip` (and not the other zip file).
 * **Grew**: see [Installation page](../installation)
 * **POStoSSQ**: get it with the command: `git clone https://gitlab.inria.fr/grew/POStoSSQ.git`
 * Download sed script [`tal2grew.sed`](/parsing/tal2grew.sed)


# More info on the parsing process

## Step 0: Get the text to parse

Put the input text in the file `data.txt`

`echo "La souris a été mangée par le chat." > data.txt`


## Step 1: POS-tagging
The parsing system **POStoSSQ** is waiting for a pos-tagged input.
One easy way to produce such a pos-tagged French sentence is to use [Talismane](http://redac.univ-tlse2.fr/applications/talismane.html).

Call **Talismane** for tokenisation and POS-tagging with the command:

```
java -Xmx1G -Dconfig.file=talismane-fr-5.2.0.conf -jar talismane-core-5.2.0.jar \
  --analyse \
  --endModule=posTagger \
  --sessionId=fr \
  --encoding=UTF8 \
  --inFile=data.txt \
  --outFile=data.tal
```

This should produce the file [`data.tal`](/parsing/data.tal):

{{< input file="static/parsing/data.tal" >}}

## Step 2: Convert output
Apply the sed script:

`sed -f tal2grew.sed data.tal > data.pos.conll`

This produces the file [`data.pos.conll`](/parsing/data.pos.conll):

{{< input file="static/parsing/data.pos.conll" >}}

## Step 3: Parsing with the GRS

With the file [`data.pos.conll`](/parsing/data.pos.conll) described above, the following command produces the CoNLL-U code of the parsed sentence:

`grew transform -grs POStoSSQ/grs/surf_synt_main.grs -i data.pos.conll -o data.surf.conll`

The output file is [`data.surf.conll`](/parsing/data.surf.conll):

{{< input file="static/parsing/data.surf.conll" >}}

which encodes the syntactic structure:

![Dependency structure](/parsing/data.surf.svg)

It is also possible to run a GTK interface in which you can explore step by step rewriting of the input sentence:

`grew gui -grs POStoSSQ/grs/surf_synt_main.grs -i data.pos.conll`

# In case of trouble

## Conversion of Talismane output
**Talismane** outputs features with disjunction of values in case of ambiguities.
These disjunction can not be handle with the current parsing system.
The sed script [`tal2grew.sed`](/parsing/tal2grew.sed) rewrites or removes the disjunction we have discovered so far but this may not be exhaustive.

If there is an error in the **Grew** output, you may have to adapt the Step 3.1 in the sed file (please inform [us](mailto:Bruno.Guillaume@inria.fr) if this is the case, we will update the sed file for other users!).

## Use MElt instead of Talismane

If you didn't manage to use **Talismane**, MElt is an alternative.
See [Dependency parsing with MElt](../parsing_melt) if you want to use [MElt](https://gforge.inria.fr/frs/?group_id=481)).


