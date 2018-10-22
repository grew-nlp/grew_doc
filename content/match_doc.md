+++
Tags = ["Development","golang"]
Description = ""
date = "2018-02-08T15:07:28+01:00"
title = "ogm doc"
menu = "main"
Categories = ["Development","GoLang"]

+++

# Grew-match: Online Graph Matching

**Grew-match** is a one page online web application for searching graph patterns in treebanks.
In the current version, the treebanks available are:

 * The 122 treebanks of the version 2.2 of [Universal Dependencies](http://universaldependencies.org)
 * The 122 treebanks of the version 2.1 of Universal Dependencies
 * Some other versions of French Universal Dependencies
 * The French Sequoia corpus (with and without deep syntactic annotations)

If you want to use it on some other corpora, you can run your own Grew-match following the instructions on [Local installation of Grew-match](../install_match).

## Basic usage

 1. Select the corpus on which you want to search (Click on `Show corpora list` if needed)
 1. Enter the search pattern in the text area (you may use some snippets on the right of the text area)
 1. Click on `Search`

The number of items is displayed and the first 10 items can be explored.
If you want to see the next 10 items, click on `Get more results`.

To limit server usage, only the first 1000 items are computed.
If the searched pattern is found more then 1000 times, the amount of corpus used to find the first 1000 items is reported.
For instance, if you search for a `nsubj` relation in the UD_English corpus, the output message is `More than 1000 results found in 6.01% of the corpus`.
This means that the first 1000 items were found in 6.01% of the 16,622 sentences of the UD_English corpus.

## Learning syntax
A [tutorial](http://match.grew.fr/?tutorial=yes) with a progressive sequence of patterns is available.
You may also explore snippets given on the right of the text area to learn with other examples.

## About CoNLL field names
The fields 2, 3, 4 and 5 of CoNLL structure are considered as features with the following feature names.

| CoNLL field     |    2   |    3    |    4   |    5   |
|-----------------|:------:|:-------:|:------:|:------:|
| Name            | `form` | `lemma` | `upos` | `xpos` |

For instance, if you want to search:

  * for the word _is_, you write: `pattern { N [form="is"] }`
  * for the lemma _be_, you write:  `pattern { N [lemma="be"] }`

**NB** In former version of the Grew code, columns were associated to feature names according to the table below.

| CoNLL field     |    2   |    3    |    4   |    5   |
|-----------------|:------:|:-------:|:------:|:------:|
| Name            | `phon` | `lemma` | `cat` | `pos` |

In order to keep backward compatibility, the features names `phon`, `cat` and `pos` are automatically replaced by `form`, `upos` and `xpos` respectively.
As a consequence, it is not recommended to use the 3 names `phon`, `cat` and `pos` in new GRS.


## Display options
Below the textarea, a few checkboxes are available to choose the information to be displayed

 * `lemma`: display lemma (CoNLL column 3)
 * `upos`: display upos (CoNLL column 4)
 * `xpos`: display xpos (CoNLL column 5)
 * `features`: display other features (CoNLL column 6)
 * `CoNNL-U`: Access to CoNNL-U specificities (see below)
 * `shuffle`: Shuffle the set of sentences before searching the pattern (useful to search randomly for examples in a corpus)
 * `context`: Show the previous and the following sentences (of course, this is useful only on corpora where original sentences ordering is preserved)

## Access to CoNNL-U specificities
Additional information available in the CoNNL-U format can be shown or accessed through special features:

  * Features of column 10 (MISC) are shown with the prefix `_MISC_`
  * Empty nodes have a feature `_UD_empty=Yes`
  * Multiword tokens are described on the first element with features `_UD_mw_fusion` and `_UD_mw_span`

These special features can be used in patterns.
For instance, searching for an empty node which is a verb:
```grew
pattern { N[upos=VERB, _UD_empty=Yes] }
```

Enhanced dependencies are displayed in blue below the sentence.
In pattern, a enhanced dependency can be searched with the prefix `E:`.
Searching for a enhanced `obl` relation in UD_English without a non-enhanced counterpart (see [output](http://match.grew.fr/?custom=5a9e6ac179d73&corpus=UD_English) in UD_English):
```grew
pattern { N -[E:obj]-> M }
without { N -[obj]-> M }
```  

## Contact
For any remark or request, you can either contact [us](mailto:Bruno.Guillaume@loria.fr?subject=Grew-match) or open an issue on the [GitLab project](http://gitlab.inria.fr/grew/grew_match/issues) (you will have to register).
