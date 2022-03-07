+++
Tags = ["Development","golang"]
Description = ""
date = "2018-02-08T15:07:28+01:00"
title = "grew-match doc"
menu = "main"
Categories = ["Development","GoLang"]

+++

# Grew-match: Online Graph Matching

---

**Grew-match** is a one page online web application for searching graph patterns in treebanks.
Since March 2022, **Grew-match** was split into several instances, each one with each own url.
The address http://match.grew.fr now displays a portal with links to instances.

## The http://universal.grew.fr instance

It contains the last version of the [UD](http://universaldependencies.org) and the [SUD](https://surfacesyntacticud.github.io/) treebanks and a few more recent version synchronised with GitHub data.
The tok navbar gives access to 
 * **UD 2.9**: The 217 treebanks of the version 2.9 of [UD](http://universaldependencies.org)
 * **SUD 2.9**: The 217 treebanks of the version 2.9 of [SUD](https://surfacesyntacticud.github.io)
 * **UD Latest**: 
   * suffix `@dev`: corpora in their latest version available on `dev` branch on GitHub (English, French, Irish and Portuguese). If you want to access to the `dev` branch of another UD treebank, please [contact us](mailto:Bruno.Guillaume@inria.fr)
   * suffix `@conv`: the automatic conversion of the native SUD treebanks into UD
 * **SUD Latest**:
   * suffix `@latest`: latest version available on GitHub of the native SUD corpora

## Other instances
  * http://parseme.grew.fr: MWE annotation from the [Parseme project](https://gitlab.com/parseme/corpora/wikis/home)
  * http://semanitcs.grew.fr: a few available semantic available graphbanks
    * Some freely available data in [AMR](https://amr.isi.edu/)
    * The [PMB](https://pmb.let.rug.nl/) Gold data
  * http://orfeo.grew.fr: See [Orfeo project](https://www.projet-orfeo.fr/)
  * http://sequoia.grew.fr: Different annotations layers of the [French Sequoia corpus](http://deep-sequoia.inria.fr/)
  * http://naija.grew.frm See [NaijaSynCor project](http://naijasyncor.huma-num.fr/)

There is currently no documentation for a local installation of Grew-match. Sorry for this.

The page [Local installation of Grew-match](../install) describes how you can run your own old (unmaintenained) version of Grew-match.

---

## Basic usage

 1. Select the instance and then the corpus on which you want to search.
 1. Enter the search pattern in the text area (you may use some snippets on the right of the text area)
 1. Click on `Search`

The number of items is displayed and the first 10 items can be explored.
If you want to see the next 10 items, click on `More results`.

To limit server usage, only the first 1000 items are computed.
If the searched pattern is found more then 1000 times, the amount of corpus used to find the first 1000 items is reported.
For instance, if you search for a `nsubj` relation in the **UD_French-GSD** corpus {{< tryit "http://match.grew.fr/?corpus=UD_French-GSD@2.9&custom=5bf2dfc6824c1" >}}, the message is `More than 1000 results found in 4.90% of the corpus`.
This means that the first 1000 items were found in 4.90% of the 16,341 sentences of the **UD_French-GSD** corpus.

### Learning syntax
A [tutorial](http://match.grew.fr/?tutorial=yes) with a progressive sequence of patterns is available.
You may also explore snippets given on the right of the text area to learn with other examples.
A more comprehensive documentation is available in the [patterns page](../../doc/pattern).

---

## Clustering the occurrences
In addition to the main request, it is possible to make some clustering on the set of occurrences given by this request.

### Use a clustering key
When a clustering key is used, the set of occurrences (or the first 1000 occurrences) is split in subsets depending of the key value.
Each possible value is presented as a button with the size of the associated subset; the button gives access to the corresponding occurrences.
The clustering key can be:

 * `N.f`: cluster following the feature named `f` for the node `N` present in the (positive part of) main request
    * List lemmas of auxiliaries in **UD_Polish-LFG** {{< tryit "http://match.grew.fr/?corpus=UD_Polish-LFG@2.9&custom=60152e0ba13f6&clustering=N.lemma">}}
    * List `VerbForm` of verb without `nsubj` in **UD_German-GSD** {{< tryit "http://match.grew.fr/?corpus=UD_German-GSD@2.9&custom=60152edd7f2c4&clustering=N.VerbForm">}}
    * Find the huge number of `form` associated to the lemma _saada_ in **UD_Finnish-FTB**{{< tryit "http://match.grew.fr/?corpus=UD_Finnish-FTB@2.9&custom=60152facde7f8&clustering=N.form">}}
 * `e.label`: cluster following the full label of edge `e` present in the (positive part of) main request
    * List relations used for auxiliaries in **UD_Italian-ParTUT** {{< tryit "http://match.grew.fr/?corpus=UD_Italian-ParTUT@2.9&custom=60153229b2aef&clustering=e.label">}}
 * `e.f`: cluster following the edge feature name `f` for a named edge `e` present in the (positive part of) main request
    * List subtypes used with `acl` relation in **UD_Swedish-Talbanken** {{< tryit "http://match.grew.fr/?corpus=UD_Swedish-Talbanken@2.9&custom=6015313b22029&clustering=e.2&eud=yes">}}
 * `e.length`: cluster following the length of edge `e` present in the (positive part of) main request
    * Observe the length of the `amod` relation in **UD_Korean-PUD**{{< tryit "http://match.grew.fr/?corpus=UD_Korean-PUD@2.9&custom=601532b351acf&clustering=e.length">}}
 * `e.delta`: cluster following the relative position of governor and dependent of edge `e` present in the (positive part of) main request
    * Observe the relative positions of `nsubj` related tokens in **UD_Naija-NSC** {{< tryit "http://match.grew.fr/?corpus=UD_Naija-NSC@2.9&custom=601533bb21b33&clustering=e.delta">}}

### Use a "whether" sub pattern
A "whether" sub pattern contains a list of clauses (as in `pattern` or `without` constructions).
The set of occurrences (or the first 1000 occurrences) is split in two subsets:

  * one tagged `No` corresponds to the subset of occurrences where the "whether" sub pattern cannot not be fulfilled (the "whether" is interpreted like a `without`)
  * one tagged `Yes` is the complementary of the `No` subset and so, corresponds to the occurrences where the sub pattern can be found.

Note that no curly brackets are needed in the "whether" text area (see examples below).

#### Examples

  * Is `advcl` left-headed in **UD_Hungarian-Szeged**? {{< tryit "http://match.grew.fr/?corpus=UD_Hungarian-Szeged@2.9&custom=6015370720eb7&whether=GOV%20%3C%3C%20DEP" >}}
  * In **UD_English-GUM**, how often the relation `expl` appear with or without `nsubj`? {{< tryit "http://match.grew.fr/?corpus=UD_English-GUM@2.9&custom=60165de555639&whether=GOV%20-[1=nsubj]-%3E%20S" >}}
  * In **UD_French-GSD**, there are 629 left-headed `nsubj` (or subtypes):
    * How often is it in an interrogative sentences? {{< tryit "http://match.grew.fr/?corpus=UD_French-GSD@2.9&custom=60166851cea61&whether=P%20[lemma=%22?%22]" >}}
    * How often is it in an relative clause? {{< tryit "http://match.grew.fr/?corpus=UD_French-GSD@2.9&custom=6016696566dc4&whether=H%20-[acl:relcl]-%3E%20GOV" >}}
    * How often is there an expletive subject? {{< tryit "http://match.grew.fr/?corpus=UD_French-GSD@2.9&custom=601669ff3f884&whether=GOV%20-[expl:subj]-%3E%20E" >}}

---

## About CoNLL-U field names
The fields 2, 3, 4 and 5 of CoNLL-U files are considered as features with the following feature names.

| CoNLL-U field   |    2   |    3    |    4   |    5   |
|-----------------|:------:|:-------:|:------:|:------:|
| Name            | `form` | `lemma` | `upos` | `xpos` |

For instance:

  * searching for the word _is_ &rarr; `pattern { N [form="is"] }`
  * searching for the lemma _be_ &rarr;  `pattern { N [lemma="be"] }`

---

## Display options
Below the text area, a few options are available:

 * `lemma`: if checked, the lemma (CoNLL-U column 3) is shown in output
 * `upos`: if checked, the upos (CoNLL-U column 4) is shown in output
 * `xpos`: if checked, the xpos (CoNLL-U column 5) is shown in output
 * `features`: if checked, other features (CoNLL-U column 6 and column 10) are shown
 * `textform/wordform`: if checked, additional features `textform` and `wordform` (see [CoNLL-U doc](../../doc/conllu#additional-features-textform-and-wordform)) are shown
 * `sentence order`: 3 values are available
    * `initial`: the sentence are scanned in the order they are present in the original corpus
    * `by length`: the shortest sentences (in term of tokens number) are scanned first
    * `shuffle` the set of sentences is shuffled before searching the pattern (useful to search randomly for examples in a corpus)
 * `context`: if checked, the previous and the following sentences are shown (of course, this is useful only on corpora where original sentences ordering is preserved)

---

## Enhanced dependencies
In the UD framework, a few corpora are also provided with another annotation EUD layer ([Enhanced dependencies](https://universaldependencies.org/u/overview/enhanced-syntax.html)).
For these corpora, a switch button is available (above the text area) where the user can chose between UD and EUD.

If EUD is selected, enhanced dependencies are displayed in blue below the sentence.
In the pattern, an enhanced dependency can be searched with the prefix `E:`.
For instance, the pattern below searches for an enhanced `obl` relation in **UD_English-EWT** without a non-enhanced counterpart
:

```grew
pattern { N -[E:obj]-> M }
without { N -[obj]-> M }
```  

{{< tryit "http://match.grew.fr/?corpus=UD_English-EWT@2.9&custom=5e42806ae3a71&eud=yes" >}}
---

## Contact
For any remark or request, you can either contact [us](mailto:Bruno.Guillaume@loria.fr?subject=Grew-match) or open an issue on [GitHub](https://github.com/grew-nlp/grew/issues).

