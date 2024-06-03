+++
Tags = ["Development","golang"]
date = "2020-05-09T16:54:18+02:00"
title = "conllu"
Description = ""
menu = "main"
Categories = ["Development","GoLang"]

+++

# CoNLL-U format

**NB:** The doc given here correspond to **Grew** version 1.16 (linked to **conll** version 1.18.1).
You can check your versions with `opam list | grep grew` and `opam list | grep conll`.

The most common way to store dependency structures is the CoNLL format.
Several extensions were proposed and we describe here the one which is used by **Grew**, known as [CoNLL-U](http://universaldependencies.org/format.html) format defined in the UD (Universal Dependencies) project.
Grew also handles the CoNLL-U plus format, see [CoNLL-U plus page](../conllup).

For a sentence, some metadata are given in lines beginning by `#`.
The rest of the lines described the tokens of the structure.
Token lines contain 10 fields, separated by tabulations.

The file [`n01118003.conllu`](/doc/conllu/n01118003.conllu) is an example of CoNLL-U data taken form the corpus `UD_English-PUD` (version 2.14).

{{< input file="static/doc/conllu/n01118003.conllu" >}}

We explain here how **Grew** deals with the 10 fields of CoNLL-U files:

1. `ID`: This field is a number used as an internal identifier for the corresponding lexical unit (LU), it can not be accessed from directly from **Grew**.
2. `FORM`: The phonological form of the LU; in **Grew**, the value of this field is available through a feature named `form`
3. `LEMMA`: The lemma of the LU; in **Grew**, this corresponds to the feature named `lemma`
4. `UPOS`: The universal POS; in **Grew**, it is encoded as feature named `upos`
5. `XPOS`: A language-specific part-of-speech tag; in **Grew**, it is encoded as feature named `xpos`
6. `FEATS`: List of morphological features; each feature is turned into a **Grew** node feature.
7. `HEAD`: Head of the current word, which is either a value of ID or `0` for the root node.
8. `DEPREL`: Dependency relation to the HEAD (`root` iff HEAD = `0`).
9. `DEPS`: (UD only) Enhanced dependency graph in the form of a list of head-deprel pairs. In **Grew**, these relations are encoded with the edge feature `enhanced=yes`.
10. `MISC`: Any other annotation. See below for the way **Grew** parses this field.

A few examples of usage in **Grew** requests:

  * matching the word form _is_ &rarr; `pattern { X [form="is"] }`
  * matching the lemma _be_ &rarr;  `pattern { X [lemma="be"] }`
  * matching the Part Of Speech _VERB_ &rarr; `pattern { X [upos=VERB] }`

Note that the CoNLL-U format is very often used to describe dependency syntax corpora.
In these cases, a set of sentences is described in the same file using the same convention as above and a blank line as separator between sentences.
It is also requires that each sentence is give a `sent_id` metadata which is unique in the corpus.

## The anchor node at position 0

In order to be able to request or to manipulate the `root` relation (for instance, if some rewriting rule is designed to change the root of the structure), we need to add a special node at position 0 (called the "anchor" node) which is the source of the `root` relation.

Hence, the 4 tokens example above produces the 5 nodes graph below:

![Dependency structure](/doc/conllu/_build/n01118003.svg)

This special node has only the `form` feature defined to be `__0__` and no other feature. In a **Grew** request, to avoid the special node the be matched, one can add a `upos` contraint.
For instance, with the request `pattern { X [] }` all the 5 nodes of the above graph can be matched, whereas with the request `pattern { X [upos] }` only the 4 nodes associated with real tokens can be matched.

## Layered features

Universal Dependency proposes a notion of [layered features](https://universaldependencies.org/u/overview/feat-layers.html) when the same feature can be marked more than once.
For instance the French word *votre*  is a possessive determiner, introducing a singular entity but referencing to a plural possessor. 
In CoNLL feats, this is encoded as `Number=Sing|Number[psor]=Plur`.

Unfortunately, the bracket notation in the feature value name is in conflict with other usages of brackets in **Grew** syntax.
In **Grew**, the bracket notation is replaced by an alternative one with a double underscore: The (S)UD feature name `Number[psor]` is written `Number__psor`.
For instance:

 * to match a feature `Number[psor]=Plur` in a **Grew** request: `pattern { X [Number__psor=Plur] }` {{< tryit "http://universal.grew.fr/?corpus=UD_French-GSD@2.14&pattern=pattern{X [Number__psor=Plur] }" >}}
 * to udate the feature `Gender[psor]` to `Fem` on node `X`, use the command `X.Gender__psor = Fem`

## How the `MISC` field is handled by **Grew**?

There are two main problems to deal with the `MISC` field in the existing (S)UD data.

 1. The content of the `MISC` field is not fully specified and in the UD data, it is used in many different ways and our objective is both:
   * to be able to access to the content of `MISC` and to change it through rules when it is a regular feature structure
   * to keep it unchanged in the other cases
 2. When a **Grew** node contains a feature like `Case=Gen`, there is no canonical way to decide if it must be output in the `FEATS` or in the `MISC` field.

To deal with the first problem, at parsing time, **Grew** tries to split the `MISC` field into a set of *(feature, value)* pairs.
If this is not possible, the raw content is kept in a special feature named `__RAW_MISC__`
({{< tryit "http://universal.grew.fr/?corpus=UD_Old_East_Slavic-Birchbark@2.14&pattern=pattern { X [__RAW_MISC__] }" >}}).
Doing this, it is possible to keep the `MISC` field unchanged during rewriting.

For the second problem, the handling of the `MISC` features depends on the config used (option `-config` on Grew CLI).

 * If the config is `basic` or `sequoia`, all features are written in the `FEATS` field (and the `MISC` field is always `_`);
 * If the config is `ud` or `sud`, there is a fixed list of features used in the `FEATS` field (list given at the bottom of this page).

Unfortunately, in practice, the same feature may be used in both fields `FEATS` and `MISC`.
For instance, in the sentence `test-12` from `UD_Polish-LFG` (below), the feature `Case` appear in `FEATS` in tokens 2, 5, 6 and in `MISC` in token 4!
In order to be able to correctly output the features in the right field, **Grew** adds a prefix `__MISC__` to the feature which is is given the `MISC` if it is in the list given at the end of this page.

{{< input file="static/doc/conllu/test-12.conllu" >}}

Requests for `Case` in FEATS: {{< tryit "http://universal.grew.fr/?corpus=UD_Polish-PUD@2.14&custom=62cc09453ad04" >}} and for `Case` in MISC: {{< tryit "http://universal.grew.fr/?corpus=UD_Polish-PUD@2.14&custom=62cc074a7ebf5" >}}.

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

## Naming of CoNLL columns **FORM**, **UPOS** and **XPOS** in older **Grew** versions

In older versions of **Grew** (before the definition of the CoNLL-U format), the fields 2 (`FORM`), 4 (`UPOS`) and 5 (`XPOS`) where accessible with the names `phon`, `cat` and `pos` respectively.
Since 1.6, these names cannot be used anymore.
If you used this features names, you have to update your old GRS with the following correspondance:

 * `phon` must be replaced by `form`
 * `cat` must be replaced by `upos`
 * `pos` must be replaced by `xpos`

Note that this applies to the examples given in the book "Application of Graph Rewriting to Natural Language Processing".

---

## List of features put in the `FEATS` field

This list in defined in the `conll` library (version 1.18.1).

If the config is `ud` or `sud`, the following list of features is used to decide which features should be written into the `FEATS` field.
The list is based on the data available in UD 2.14 (plus the `Shared` feature specific to SUD):

  - `Abbr`
  - `Accomp`
  - `AdjType`
  - `AdpType`
  - `AdvType`
  - `Advlz`
  - `Agglutination`
  - `Also`
  - `Analyt`
  - `Animacy`
  - `Animacy[gram]`
  - `Animacy[obj]`
  - `Aspect`
  - `Case`
  - `Caus`
  - `Cfm`
  - `Clas`
  - `Class`
  - `Clitic`
  - `Clusivity`
  - `Clusivity[obj]`
  - `Clusivity[psor]`
  - `Clusivity[subj]`
  - `Compound`
  - `Comt`
  - `Conces`
  - `ConjType`
  - `Connegative`
  - `Contrast`
  - `Contv`
  - `Corf`
  - `Decl`
  - `Definite`
  - `Definitizer`
  - `Degree`
  - `Deixis`
  - `DeixisRef`
  - `Deixis[psor]`
  - `Delib`
  - `Deo`
  - `Derivation`
  - `Determ`
  - `Detrans`
  - `Dev`
  - `Dialect`
  - `Dist`
  - `Dyn`
  - `Echo`
  - `Ego`
  - `Emph`
  - `Emphatic`
  - `Evident`
  - `Excl`
  - `ExtPos`
  - `Fact`
  - `False`
  - `Foc`
  - `Focus`
  - `FocusType`
  - `Foreign`
  - `Form`
  - `Gender`
  - `Gender[abs]`
  - `Gender[dat]`
  - `Gender[erg]`
  - `Gender[io]`
  - `Gender[obj]`
  - `Gender[psor]`
  - `Gender[subj]`
  - `Gnq`
  - `HebBinyan`
  - `HebExistential`
  - `Hon`
  - `Htp`
  - `Hum`
  - `Hyph`
  - `Imprs`
  - `Incorp`
  - `InfForm`
  - `InflClass`
  - `InflClass[nominal]`
  - `Int`
  - `Intens`
  - `Intense`
  - `Intension`
  - `LangId`
  - `Language`
  - `Link`
  - `Mood`
  - `Morph`
  - `Movement`
  - `Mutation`
  - `NCount`
  - `NameType`
  - `NegationType`
  - `Neutral`
  - `Nmzr`
  - `Nomzr`
  - `NonFoc`
  - `NounBase`
  - `NounClass`
  - `NounType`
  - `NumForm`
  - `NumType`
  - `NumValue`
  - `Number`
  - `Number[abs]`
  - `Number[cs]`
  - `Number[dat]`
  - `Number[erg]`
  - `Number[grnd]`
  - `Number[io]`
  - `Number[lo]`
  - `Number[obj]`
  - `Number[po]`
  - `Number[psed]`
  - `Number[psor]`
  - `Number[refl]`
  - `Number[ro]`
  - `Number[subj]`
  - `Obl`
  - `Orth`
  - `PartForm`
  - `PartType`
  - `PartTypeQpm`
  - `Pcl`
  - `Person`
  - `Person[abs]`
  - `Person[cs]`
  - `Person[dat]`
  - `Person[erg]`
  - `Person[grnd]`
  - `Person[io]`
  - `Person[lo]`
  - `Person[obj]`
  - `Person[po]`
  - `Person[psor]`
  - `Person[refl]`
  - `Person[ro]`
  - `Person[subj]`
  - `Polarity`
  - `Polite`
  - `Polite[abs]`
  - `Polite[dat]`
  - `Polite[erg]`
  - `Position`
  - `Poss`
  - `Possessed`
  - `Pred`
  - `Prefix`
  - `PrepCase`
  - `PrepForm`
  - `Priv`
  - `PronClass`
  - `PronType`
  - `Proper`
  - `Prp`
  - `PunctSide`
  - `PunctType`
  - `Purp`
  - `RcpType`
  - `Recip`
  - `Red`
  - `Redup`
  - `Reflex`
  - `Reflex[obj]`
  - `Reflex[subj]`
  - `Rel`
  - `RelType`
  - `Reln`
  - `Report`
  - `Shared` (Specific to SUD)
  - `Speech`
  - `Strength`
  - `Style`
  - `SubGender`
  - `Subcat`
  - `Subord`
  - `Subordinative`
  - `Tense`
  - `Top`
  - `Trans`
  - `Tv`
  - `Typo`
  - `Uninflect`
  - `Valency`
  - `Variant`
  - `Ventive`
  - `VerbClass`
  - `VerbForm`
  - `VerbStem`
  - `VerbType`
  - `Voice`
