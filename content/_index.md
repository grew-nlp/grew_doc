+++
Tags = ["Development","golang"]
Description = ""
date = "2017-02-27T17:44:22+01:00"
title = "index"
menu = "main"
Categories = ["Development","GoLang"]
+++

<div style='width: 200pt;'>
<img src="logo/grew.svg" alt="Grew logo">
</div>

# Graph Rewriting for NLP

**Grew** is a Graph Rewriting tool for Natural Language Processing (NLP) applications. It can manipulate many types of linguistic representation. It has been used on POS-tagged sequence, surface dependency syntax, deep dependency syntax, semantic representation (AMR, DMRS), but it can be used to represent any graph-based structure.

There is a mailing list `grew@inria.fr` for announcements or discussions related to Grew.
See [here to subscribe](https://sympa.inria.fr/sympa/info/grew).

## News

 * 🆕 **2024/06/02:** Version **1.16**. See [What's new](/whats_new/) for changes.

 * **2024/01/02:** Version **1.15**.

## A first taste of Grew
The easiest way to try out **Grew** is to use one of the online interfaces.

  1. [Grew-match](https://match.grew.fr): Online graph matching to search for a given request in a corpus of syntactic structures (a [tutorial](https://universal.grew.fr/?tutorial=yes) is available to help learning request syntax).
  2. [Grew-web](https://web.grew.fr): Online graph rewriting
  2. [Arborator-Grew](https://arborator.github.io/): Tool for online corpus management (this is another tool, using Grew as backend)

## Some of the key features of Grew

  * Graph structures can use a built-in notion of **feature structures**.
  * The left-hand side of a rule is described by a graph called a **request** (or **pattern**); injective graph morphisms are used in the pattern matching algorithm.
  * **Negative patterns** can be used for a finer control on the left-hand side of rules.
  * The right-hand side of the rules is described by a sequence of **atomic commands** that describe how the graph should be modified during the rule application.
  * A subset of rules can be organised into **packages**, and **strategies** define the way in which rules and packages are applied during graph transformation.
  * **Grew** has support for both **confluent** and **non-confluent** modules; when a non-confluent module is used, all normal forms are returned and then ambiguity is handled in a natural way.

## Publications

 * [2021] Bruno **Guillaume**. [Graph Matching and Graph Rewriting: GREW tools for corpus exploration, maintenance and conversion](https://hal.inria.fr/hal-03177701). Demonstrations -- 16th Conference of the European Chapter of the Association for Computational Linguistics (EACL).

 * [2020] Gaël **Guibon**, Marine **Courtin**, Kim **Gerdes** and Bruno **Guillaume**. [When Collaborative Treebank Curation Meets Graph Grammars -- Arborator With a Grew Back-End](http://www.lrec-conf.org/proceedings/lrec2020/pdf/2020.lrec-1.651.pdf).

 * [2019] Bruno **Guillaume**. [Graph Matching for Corpora Exploration](https://hal.inria.fr/hal-02267475). JLC 2019 - 10èmes Journées Internationales de la Linguistique de corpus, Grenoble, France.

 * [2018] Guillaume **Bonfante**, Bruno **Guillaume** and Guy **Perrier**. [*Application of Graph Rewriting to Natural Language Processing*](https://www.wiley.com/en-fr/Application+of+Graph+Rewriting+to+Natural+Language+Processing-p-9781119522348).
(The chapter 1 is [available from the editor website](https://media.wiley.com/product_data/excerpt/66/17863009/1786300966-587.pdf)).

## Acknowledgements

 * Thanks to the users of **Grew** and **Grew-match** for their feedback, support and suggestions.
 * Thanks to Kim Gerdes for beautiful Grew logo.