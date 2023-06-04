+++
Tags = ["Development","golang"]
Description = ""
date = "2017-02-27T17:44:22+01:00"
title = "index"
menu = "main"
Categories = ["Development","GoLang"]
+++

<div style='width: 200pt;'>
<img src="logo/grew.svg">
</div>

# Graph Rewriting for NLP

**Grew** is a Graph Rewriting tool dedicated to applications in Natural Language Processing (NLP). It can manipulate many kinds of linguistic representation. It has been used on POS-tagged sequence, surface dependency syntax, deep dependency syntax, semantic representation (AMR, DMRS) but it can be used to represent any graph-based structure.

There is a mailing list `grew@inria.fr` for announcement or discussion related to Grew.
See [here to subscribe](https://sympa.inria.fr/sympa/info/grew).

## News
 * 🆕 **2023/03/24:** Version **1.12**. See [What's new](/whats_new/) for changes.

 * **2023/01/22:** Version **1.11**.

 * **2022/11/23:** Version **1.10**.
 
## A first taste of Grew
The easiest way to try and test **Grew** is to use one of the online interfaces.

  1. [Grew-match](http://match.grew.fr): Online graph matching to search for a given request in a corpus of syntactic structures (a [tutorial](http://match.grew.fr/?tutorial=yes) is available to help learning request syntax).
  2. [Grew-web](https://web.grew.fr): Online graph rewriting
  2. [Arborator-Grew](https://arborator.github.io/): Tool for online corpus management (this is another tool, using Grew as backend)

## Some of the main features of Grew

  * Graph structures can use a built-in notion of **feature structures**.
  * The left-hand side of a rule is described by a graph called a **request** (or **patterns**); injective graph morphisms are used in the pattern matching algorithm.
  * **Negative pattern** can be used for a finer control on the left-hand side of rules.
  * The right-hand side of rules is described by a sequence of **atomic commands** that describe how the graph should be modified during the rule application.
  * Subset of rules can be organised in **packages** and **strategies** define the way rules and packages are applied in graph transformation.
  * **Grew** has support both for **confluent** and **non-confluent** modules; when a non-confluent modules is used, all normal forms are returned and then ambiguity is handled in a natural way.

## Publications

 * [2021] Bruno **Guillaume**. [Graph Matching and Graph Rewriting: GREW tools for corpus exploration, maintenance and conversion](https://hal.inria.fr/hal-03177701). Demonstrations -- 16th Conference of the European Chapter of the Association for Computational Linguistics (EACL).

 * [2020] Gaël **Guibon**, Marine **Courtin**, Kim **Gerdes** and Bruno **Guillaume**. [When Collaborative Treebank Curation Meets Graph Grammars -- Arborator With a Grew Back-End](http://www.lrec-conf.org/proceedings/lrec2020/pdf/2020.lrec-1.651.pdf).

 * [2019] Bruno **Guillaume**. [Graph Matching for Corpora Exploration](https://hal.inria.fr/hal-02267475). JLC 2019 - 10èmes Journées Internationales de la Linguistique de corpus, Grenoble, France.

 * [2018] Guillaume **Bonfante**, Bruno **Guillaume** and Guy **Perrier**. [*Application of Graph Rewriting to Natural Language Processing*](https://www.wiley.com/en-fr/Application+of+Graph+Rewriting+to+Natural+Language+Processing-p-9781119522348).
(The chapter 1 is [available from the editor website](https://media.wiley.com/product_data/excerpt/66/17863009/1786300966-587.pdf)).

## Acknowledgements

 * Thanks to **Grew** and **Grew-match** users for their feedback, their support and their suggestions
 * Thanks to Kim Gerdes for nice Grew logo