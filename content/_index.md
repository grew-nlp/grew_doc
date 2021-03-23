+++
Tags = ["Development","golang"]
Description = ""
date = "2017-02-27T17:44:22+01:00"
title = "index"
menu = "main"
Categories = ["Development","GoLang"]
+++

<div style='width: 200pt;'>
<img src="logo/grew.svg"/>
</div>

# Graph Rewriting for NLP

**Grew** is a Graph Rewriting tool dedicated to applications in Natural Language Processing (NLP). It can manipulate many kinds of linguistic representation. It has been used on POS-tagged sequence, surface dependency syntax, deep dependency syntax, semantic representation (AMR, DMRS) but it can be used to represent any graph-based structure.

## News

 * **2021/03/23:** Some new pages in the documentation: follow ⭐ in the menu on the right!


 * **2021/03/15:** New release of version **1.5**. See [What's new](/whats_new/) for changes.

 * **2020** Grew matching is available in the [Arborator-Grew](https://arborator.github.io/) tool.


## A first taste of Grew
The easiest way to try and test **Grew** is to use one of the two online interfaces.

  1. Online graph matching: [Grew-match](http://match.grew.fr) lets the user search for a given pattern in a corpus of syntactic structures (a tutorial is available to help learning pattern syntax).
  2. Online parsing: [Grew-parse](http://parse.grew.fr) returns for a input French sentence, a set of linguistic representations (syntax and semantics) which are built using Graph Rewriting.

## Some of the main features of Grew

  * Graph structures can use a built-in notion of **feature structures**.
  * The left-hand side of a rule is described by a graph called a **pattern**; injective graph morphisms are used in the pattern matching algorithm.
  * **Negative pattern** can be used for a finer control on the left-hand side of rules.
  * The right-hand side of rules is described by a sequence of **atomic commands** that describe how the graph should be modified during the rule application.
  * Subset of rules can be organized in **packages** and **strategies** define the way rules and packages are applied in graph transformation.
  * **Grew** has support both for **confluent** and **non-confluent** modules; when a non-confluent modules is used, all normal forms are returned and then ambiguity is handled in a natural way.

## Publications

 * [2020] Gaël **Guibon**, Marine **Courtin**, Kim **Gerdes** and Bruno **Guillaume**. [When Collaborative Treebank Curation Meets Graph Grammars -- Arborator With a Grew Back-End](http://www.lrec-conf.org/proceedings/lrec2020/pdf/2020.lrec-1.651.pdf).

 * [2019] Bruno **Guillaume**. [Graph Matching for Corpora Exploration](https://hal.inria.fr/hal-02267475). JLC 2019 - 10èmes Journées Internationales de la Linguistique de corpus, Nov 2019, Grenoble, France.

 * [2018] Guillaume **Bonfante**, Bruno **Guillaume** and Guy **Perrier**. [*Application of Graph Rewriting to Natural Language Processing*](https://www.wiley.com/en-fr/Application+of+Graph+Rewriting+to+Natural+Language+Processing-p-9781119522348).
(The chapter 1 is [available from the editor website](https://media.wiley.com/product_data/excerpt/66/17863009/1786300966-587.pdf)).

## Acknowledgements

 * Thanks to **Grew** and **Grew-match** users for their feedback, their support and their suggestions
 * Thanks to Kim Gerdes for nice Grew logo