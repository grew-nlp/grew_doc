+++
Tags = ["Development","golang"]
Description = ""
date = "2018-02-08T15:07:28+01:00"
title = "grew-match doc"
menu = "main"
Categories = ["Development","GoLang"]

+++

# Grew-match: Online Graph Matching

**Grew-match** is a one page online web application for searching graph patterns in treebanks.
Treebanks available are in several linguistic formats:

 * In UD format ([Universal Dependencies](http://universaldependencies.org))
   * The 163 treebanks of the version 2.6;
   * 4 treebanks converted form the SUD format;
   * 6 French treebanks corresponding to the `dev` branch of the corresponding [github](https://github.com/UniversalDependencies) projects (if you want to access to the `dev` branch of another UD treebank, please [contact us](mailto:Bruno.Guillaume@inria.fr))
   * A few older versions of treebanks (that we use to observe the treebank evolution)
 * In SUD format ([Surface Syntactic Universal Dependencies](https://surfacesyntacticud.github.io/))
   * The current GitHub branch of the 4 native SUD treebanks (https://github.com/surfacesyntacticud)
   * The 163 treebanks automatically converted from the version 2.6 of Universal Dependencies (see https://surfacesyntacticud.github.io/data/)
 * Different annotations of the [French Sequoia corpus](http://deep-sequoia.inria.fr/)
 * 3 available corpora in [AMR](https://amr.isi.edu/)
 * Data of the [Parseme project](https://gitlab.com/parseme/corpora/wikis/home)
 * Data of [Orfeo project](https://www.projet-orfeo.fr/)

If you want to use it on some other corpora, you can run your own Grew-match following the instructions on [Local installation of Grew-match](../install).

## Basic usage

 1. Select the corpus on which you want to search (first chose the format in the top navbar and then the corpus in the left pane)
 1. Enter the search pattern in the text area (you may use some snippets on the right of the text area)
 1. Click on `Search`

The number of items is displayed and the first 10 items can be explored.
If you want to see the next 10 items, click on `Get more results`.

To limit server usage, only the first 1000 items are computed.
If the searched pattern is found more then 1000 times, the amount of corpus used to find the first 1000 items is reported.
For instance, if you search for a `nsubj` relation in the **UD_French-GSD** corpus (see [output](http://match.grew.fr/?corpus=UD_French-GSD@2.6&custom=5bf2dfc6824c1)), the message is `More than 1000 results found in 5.16% of the corpus`.
This means that the first 1000 items were found in 5.16% of the 16,342 sentences of the **UD_French-GSD** corpus.

## Learning syntax
A [tutorial](http://match.grew.fr/?tutorial=yes) with a progressive sequence of patterns is available.
You may also explore snippets given on the right of the text area to learn with other examples.
A more comprehensive documentation is available in the [patterns page](../../doc/pattern).

## About CoNLL-U field names
The fields 2, 3, 4 and 5 of CoNLL-U structure are considered as features with the following feature names.

| CoNLL-U field     |    2   |    3    |    4   |    5   |
|-----------------|:------:|:-------:|:------:|:------:|
| Name            | `form` | `lemma` | `upos` | `xpos` |

For instance, if you want to search:

  * for the word _is_, you write: `pattern { N [form="is"] }`
  * for the lemma _be_, you write:  `pattern { N [lemma="be"] }`

## Display options
Below the textarea, a few options are available:

 * `lemma`: if checked, the lemma (CoNLL-U column 3) is shown in output
 * `upos`: if checked, the upos (CoNLL-U column 4) is shown in output
 * `xpos`: if checked, the xpos (CoNLL-U column 5) is shown in output
 * `features`: if checked, other features (CoNLL-U column 6 and column 10) are shown
 * `textform/wordform`: if checked, additional features `textform` and `wordform` (see [CoNLL-U doc](../../conllu#additional-features-textform-and-wordform)) are shown
 * `sentence order`: 3 value are available
    * `initial`: the sentence are scanned in the order they are present in the original corpus
    * `by length`: the shortest sentences (in term of tokens number) are scanned first
    * `shuffle` the set of sentences is shuffled before searching the pattern (useful to search randomly for examples in a corpus)
 * `context`: if checked, the previous and the following sentences are shown (of course, this is useful only on corpora where original sentences ordering is preserved)


## Enhanced dependencies
In the UD framework, a few corpora are also provided with another annotation EUD layer ([Enhanced dependencies](https://universaldependencies.org/u/overview/enhanced-syntax.html)).
For these corpora, a switch button is available (above the textarea) where the user can chose between UD and EUD

If EUD is selected, enhanced dependencies are displayed in blue below the sentence.
In the pattern, an enhanced dependency can be searched with the prefix `E:`.
For instance, the pattern below searches for an enhanced `obl` relation in **UD_English-EWT** without a non-enhanced counterpart (see [output](http://match.grew.fr/?corpus=UD_English-EWT@2.5&custom=5e42806ae3a71&eud=yes)):
```grew
pattern { N -[E:obj]-> M }
without { N -[obj]-> M }
```  

## Contact
For any remark or request, you can either contact [us](mailto:Bruno.Guillaume@loria.fr?subject=Grew-match) or open an issue on the [GitLab project](http://gitlab.inria.fr/grew/grew_match/issues) (you will have to register).

---

## Deprecated `_MISC_` and `_UD_` prefixes
In older versions, features declared in column 10 were accessible with the `_MISC_` prefix.
Since 1.4, no prefix is required.

Multiword tokens or empty nodes were identified with the `_UD_` prefix.
This prefix is not used anymore; it is replaced by features `textform` and `wordform` (see [CoNLL-U doc](../../doc/conllu#additional-features-textform-and-wordform)).

