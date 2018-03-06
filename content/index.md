+++
Tags = ["Development","golang"]
Description = ""
date = "2017-02-27T17:44:22+01:00"
title = "index"
menu = "main"
Categories = ["Development","GoLang"]

+++

# Grew: Graph Rewriting for NLP

**Grew** is a Graph Rewriting tool dedicated to applications in Natural Language Processing (NLP). It can manipulate many kinds of linguistic representation. It has been used on POS-tagged sequence, surface dependency syntax, deep dependency syntax, semantic representation (AMR, DMRS) but it can be used to represent any graph-based structure.

## News
**2017/12/14:** New release of version **0.46**. Main changes are:

 * GTK interface is proposed as a separate package and so Grew without GUI is much more easy to [install](../install)
 * Command line arguments were revisited (see [Run Grew page](../run))

## A first taste of Grew
The easiest way to try and test **Grew** is to use one of the two online interfaces.

  1. Online graph matching: [Grew-match](http://match.grew.fr) lets the user search for a given pattern in a corpus of syntactic structures (a tutorial is available to help learning pattern syntax).
  2. Online parsing: [Grew-parse](http://parse.grew.fr) returns for a input French sentence, a set of linguistic representations (syntax and semantics) which are built using Graph Rewriting.

## Some of the main features of Grew

  * Graph structures can use a build-in notion of **feature structures**.
  * The left-hand side of a rule is described by a graph called a **pattern**; injective graph morphisms are used in the pattern matching algorithm.
  * **Negative pattern** can be used for a finer control on the left-hand side of rules.
  * The right-hand side of rules is described by a sequence of **atomic commands** that describe how the graph should be modified during the rule application.
  * Subset of rules can be organized in **packages** and **strategies** define the way rules and packages are applied in graph transformation.
  * **Grew** has support both for **confluent** and **non-confluent** modules; when a non-confluent modules is used, all normal forms are returned and then ambiguity is handled in a natural way.
