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

**Grew-match** is a one page online web application for searching graph requests in treebanks.
There are several instances, each one with each own URL.
The address [`http://match.grew.fr`](http://match.grew.fr) displays a portal with links to instances.
See [below](./#grew-match-instances) for a the list of instances

If you want to run your own instance of Grew-match, see [Local installation of Grew-match](../install).

---

## Basic usage
Once you have selected an instance,

 1. Select the corpus on which you want to search:
    * with the top navbar, select the collection (subset of corpora)
    * with the left pane, select the corpora on which the request will be executed
 1. Enter the search request in the text area (you may use some snippets on the right of the text area)
 1. Click on `Search` or `Count`

With `Search`: 
 * If the number of matches is below 1000, the number of items is displayed,
 * Else, the computation stops after the first 1000 occurences  computed (for instance, if you search for a `nsubj` relation in the **UD_French-GSD** corpus {{< tryit "http://match.grew.fr/?corpus=UD_French-GSD@2.15&pattern=pattern { X -[nsubj]-> Y }" >}}, and the amount of corpus used to find the first 1000 items is reported like in `More than 1000 results found in 5.44% of the corpus`, This means that the first 1000 items were found in 5.44% of the 16,342 sentences of the **UD_French-GSD** corpus.
)
 * Items are displayed by batches of size 10; if you want to see the next 10 items, click on `More results`.

With `count`, all the solutions are computed, but, it is not possible to visualize annotation examples.
For instance, with the same request as above, we observe 18,974 occcurences of `nsubj`.

---

## Learning syntax
A [tutorial](http://match.grew.fr/?tutorial=yes) with a progressive sequence of requests is available.
You may also explore snippets given on the right of the text area to learn with other examples.
A more comprehensive documentation is available in the [requests page](../../doc/request).

---

## Clustering the occurrences
In addition to the main request, it is possible to make some clustering on the set of occurrences returned by this request.

When a clustering key is used, the set of occurrences (or the first 1000 occurrences if `Search` is used) is split in subsets depending of the key value.
Each possible value is presented as a button with the size of the associated subset; the button gives access to the corresponding occurrences (in `Search` mode).

When a `whether` sub-request is used, matching are split in two clusters `Yes` and `No`.

See [clustering documentation page](../../doc/clustering) for syntax and examples of usage.

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
    * `shuffle` the set of sentences is shuffled before searching the request (useful to search randomly for examples in a corpus)
 * `context`: if checked, the previous and the following sentences are shown (of course, this is meaningful only on corpora where original sentences ordering is preserved)

---

## About CoNLL-U field names
The fields 2, 3, 4 and 5 of CoNLL-U files are considered as features with the following feature names.

| CoNLL-U field   | `FORM` (col 2) | `LEMMA` (col 3) | `UPOS` (col 4) | `XPOS` (col 5) |
|:---------------:|:--------------:|:---------------:|:--------------:|:--------------:|
| **Grew** syntax | `form`         | `lemma`         | `upos`         | `xpos`         |

For instance:

  * searching for the word _is_ &rarr; `pattern { X [form="is"] }`
  * searching for the lemma _be_ &rarr;  `pattern { X [lemma="be"] }`

For other features, defined in CoNLL-U fields `FEATS` (col 6) and `MISC` (col 10), the name of the feature can be used directly with exceptions:
  * for layered features: see [here](../../doc/conllu#layered-features)
  * for irregular used of `MISC` field: see [here](../../doc/conllu#how-the-misc-field-is-handled-by-grew)


---

## Enhanced dependencies
In the UD framework, a few corpora are also provided with another annotation layer ([Enhanced dependencies](https://universaldependencies.org/u/overview/enhanced-syntax.html)).
For these corpora, they are available by default with the enhanced layer and another corpora (with prefix `bUD`, for "basic" UD) is also available

If the default treebank is selected, enhanced dependencies are displayed in blue below the sentence.
In the pattern, an enhanced dependency can be searched with the prefix `E:`.
For instance, the pattern below {{< tryit "http://match.grew.fr/?corpus=UD_English-EWT@2.15&pattern=pattern { X -[E:obj]-> Y }%0Dwithout { X -[obj]-> Y }" >}} searches for an enhanced `obl` relation in **UD_English-EWT** without a non-enhanced counterpart:
:

```grew
pattern { X -[E:obj]-> Y }
without { X -[obj]-> Y }
```  


---

# Grew-match instances

## The [`http://universal.grew.fr`](http://universal.grew.fr) instance

This instance contains the version 2.15 of the [UD](http://universaldependencies.org) and the [SUD](https://surfacesyntacticud.github.io/) treebanks and a few more recent versions synchronised with GitHub data.
The top navbar gives access to:
 * **UD 2.15**: The 296 treebanks of the version 2.15 of [UD](http://universaldependencies.org)
 * **SUD 2.15**: The 300 treebanks of the version 2.15 of [SUD](https://surfacesyntacticud.github.io) (see page [SUD data](https://surfacesyntacticud.github.io/data/) for more details about SUD corpora)
 * **UD Latest**: (with suffix `@dev`) Some UD corpora in their latest version available on `dev` branch on GitHub English, French, Irish and Portuguese). If you want to access to the `dev` branch of another UD treebank, please [contact us](mailto:Bruno.Guillaume@inria.fr). These treebanks are updated in at most one hour after a new push is done on GitHub.
 * **SUD Latest**: (with suffix `@latest`) latest version available on GitHub of the native SUD corpora.
 * **UD Auto**: (with suffix `@conv`) automatic UD conversion of SUD-native treebanks
 * **SUD Auto**: automatic SUD conversion of some UD treebanks and a few other automatically built SUD treebanks

## Other instances
  * [`http://parseme.grew.fr`](http://parseme.grew.fr): MWE annotation from the [Parseme project](https://gitlab.com/parseme/corpora/wikis/home)
  * [`http://semantics.grew.fr`](http://semantics.grew.fr): a few available semantic graphbanks
    * Some freely available data in [AMR](https://amr.isi.edu/)
    * The [PMB](https://pmb.let.rug.nl/) Gold data
  * [`http://orfeo.grew.fr`](http://orfeo.grew.fr): See [Orfeo project](https://www.projet-orfeo.fr/)
  * [`http://sequoia.grew.fr`](http://sequoia.grew.fr): Different annotations layers of the [French Sequoia corpus](http://deep-sequoia.inria.fr/)
  * [`http://naija.grew.fr`](http://naija.grew.fr): See [NaijaSynCor project](http://naijasyncor.huma-num.fr/)

---

# Contact
For any remark or request, you can either contact [me](mailto:Bruno.Guillaume@loria.fr?subject=Grew-match) or open an issue on [GitHub](https://github.com/grew-nlp/grew/issues).

