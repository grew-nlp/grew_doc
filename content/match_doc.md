+++
Tags = ["Development","golang"]
Description = ""
date = "2018-02-08T15:07:28+01:00"
title = "ogm doc"
menu = "main"
Categories = ["Development","GoLang"]

+++

# Grew-match: Online Graph Matching

**Grew-match** is a one page online web application for searching graph pattern in a TreeBanks.
In the current version, the TreeBanks available are:

 * The 102 TreeBanks of the version 2.1 of [Universal Dependencies](http://universaldependencies.org)
 * Some other versions of French Universal Dependencies
 * The French Sequoia corpus (with and without deep syntactic annotations)

## Basic usage

 1. Select the corpus on which you want to search (Click on `Show corpora list` if needed)
 1. Enter the search pattern in the text area (you may use some snippets on the right of the text area)
 1. Click on `Search`

The number of items is displayed and the first 10 items can be explored.
If you want to see more the next 10 items, click on `Get more results`.

To limit server usage, only the first 1000 items are computed.
It the searched pattern is found more then 1000 times, the amount of corpora used to find the first 1000 items is reported.
For instance, if you search for a `nsubj` relation, the output message is `More than 1000 results found in 6.01% of the corpus`.
This means that the first 1000 items were found in 6.01% of the 16,622 sentences of the UD_English corpus.

## Learning syntax
A [tutorial](http://match.grew.fr/?tutorial=yes) with a progressive sequence of patterns is available.
You may also explore snippets given on the right of the text area to learn with other examples.

## About CoNLL field names
The fields 2, 3, 4 and 5 of CoNLL structure are named differently in UD and in Sequoia

| CoNLL field     |    2   |    3    |    4   |    5   |
|-----------------|:------:|:-------:|:------:|:------:|
| Name in UD      | `form` | `lemma` | `upos` | `xpos` |
| Name in Sequoia | `phon` | `lemma` |  `cat` |  `pos` |

For instance, if you want to search for the word _maison_, you write:

 * in UD: `pattern { N [form="maison"] }`
 * in Sequoia: `pattern { N [phon="maison"] }`

## Access to CoNNL-U specificities
Additional information available in the CoNNL-U format can be accesses through special features:

  * Enhanced dependencies are written with the prefix `E:`
  * Features of column 10 (MISC) are shown with the prefix `_MISC_`
  * Empty nodes have a feature `_UD_empty=Yes`
  * Multiword tokens are described on the first element with features `_UD_mw_fusion` and `_UD_mw_span`

## Contact
For any remark or request, you can either contact [us](mailto:Bruno.Guillaume@loria.fr?subjectGrew-match) or open an issue on the [GitLab project](http://gitlab.inria.fr/grew/grew_web/issues) (you will have to register).
