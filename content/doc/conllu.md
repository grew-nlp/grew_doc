+++
Tags = ["Development","golang"]
date = "2020-05-09T16:54:18+02:00"
title = "conllu"
Description = ""
menu = "main"
Categories = ["Development","GoLang"]

+++

# CoNLL-U format

The most common way to store dependency structures is the CoNLL format.
Several extensions were proposed and we describe here the one which is used by **Grew**, known as [CoNLL-U](http://universaldependencies.org/format.html) format defined in the Universal Dependency project.
Grew also handles the CoNLL-U plus format, see [CoNLL-U plus page](../conllup)

For a sentence, some metadata are given in lines beginning by `#`.
The rest of the lines described the tokens of the structure.
Tokens lines contain 10 fields, separated by tabulations.

The file [`n01118003.conllu`](/doc/conllu/n01118003.conllu) is an example of CoNLL-U data taken form the corpus `UD_English-PUD` (version 2.8).

{{< input file="static/doc/conllu/n01118003.conllu" >}}

We explain here how **Grew** deals with the 10 fields if CoNLL-U files:

1. **ID**. This field is a number used as an internal identifier for the corresponding lexical unit (LU), it can not be accessed from directly from **Grew**.
2. **FORM**. The phonological form of the LU.
In **Grew**, the value of this field is available through a feature named `form` (see [here](../conllu#note-about-conll-feature-values) for info about older versions of **Grew**).
3. **LEMMA**. The lemma of the LU. In **Grew**, this corresponds to the feature `lemma`.
4. **UPOS**. The field `upos` (see [here](../conllu#note-about-conll-feature-values) for info about older versions of **Grew**).
5. **XPOS**. The field `xpos` (see [here](../conllu#note-about-conll-feature-values) for info about older versions of **Grew**)
6. **FEATS**. List of morphological features.
7. **HEAD**. Head of the current word, which is either a value of ID or `0` for the root node.
8. **DEPREL**. Dependency relation to the HEAD (`root` iff HEAD = `0`).
9. **DEPS**. (UD only) Enhanced dependency graph in the form of a list of head-deprel pairs. In **Grew**, these relations are encoded with the features `enhanced=yes`
10. **MISC**. Any other annotation. In **Grew**, annotation of the field are accessible like other morphological features from the **FEATS** column.

A few examples of usage in **Grew** patterns:

  * matching the word _is_ &rarr; `pattern { N [form="is"] }`
  * matching the lemma _be_ &rarr;  `pattern { N [lemma="be"] }`
  * matching the Part Of Speech _VERB_ &rarr; `pattern { N [upos=VERB] }`

Note that the same format is very often use to describes dependency syntax corpora.
In these cases, a set of sentences is described in the same file using the same convention as above and a blank line as separator between sentences.
It is also requires that the `sent_id` metadata is unique for each sentence in the file.

In practice, it may be useful to deal explicitly with the `root` relation (for instance, if some rewriting rule is designed to change the root of the structure).
To allow this, when reading CoNLL-U format **Grew** also creates a node at position `0` and link it with the `root` relation to the linguistic root node of the sentence.
The example above then produce the 5 nodes graphs below:

![Dependency structure](/doc/conllu/_build/n01118003.svg)

## Additional features `textform` and `wordform`
In order to deal with several places where text data present in the original sentence and the corresponding linguistic unit are different, a systematic use of the two features `textform` and `wordform` was proposed in [#683](https://github.com/UniversalDependencies/docs/issues/683).

The two fields are built from CoNLL-U data in the following way:

 1. If a multiword token `i-j` is declared:
   * the `textform` of the first token is the `FORM` field of the multiword token
   * the `textform` of each other token is `_`
 1. If the token is an empty node (exists only in EUD):
   * `textform=_` and `wordform=__EMPTY__`
 1. For each token without `textform` feature, the `textform` is set to the `FORM` field value
 1. For each token without `wordform` feature, the `wordform` is set to the `FORM` field value

⚠️ In places where `wordform` should be different from `FORM` field, this should be expressed in the data with an explicit `wordform` feature.
This includes:

 * lowercased form of initial word or potentially other words in the sentence
 * typographical or orthographical errors
 * token linked by a `goeswith` relation

See few examples in **SUD_French-GSD** {{< tryit "http://match.grew.fr/?corpus=SUD_French-GSD@latest&custom=5e42842249c10" >}}.

---

## Note about CoNLL feature values

In older versions of **Grew** (before the definition of the CoNLL-U format), the fields 2, 4 and 5 where accessible with the names `phon`, `cat` and `pos` respectively.
Since 1.6, these names cannot be used anymore.
If you used this features names, you have to update your old GRS with the following correspondance:

 * `phon` must be replaced by `form`
 * `cat` must be replaced by `upos`
 * `pos` must be replaced by `xpos`

Note that this applies to the examples given in the book "Application of Graph Rewriting to Natural Language Processing".