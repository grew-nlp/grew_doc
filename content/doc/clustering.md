# Clustering

There is a general clustering mechanism in **Grew** which can be used in several contexts to split a set of matchings produced by a request on a corpus in a some subsets (a partition) according to some criteria.

--- 

## Where it can be used?

 * In **Grew-match**, below the main textarea where the request is written, it is possible to describe either one or two clustering items
 * With the command line argument, in `grep` ou `count` modes, clustering can be perfomed. For details and examples, see [here for `grep`](../../usage/cli#with-clustering) and [here for `count`](../../usage/cli#example-with-multi-mode-one-request-and-a-key-clustering-of-the-output)
 * With the Python library **Grewpy**, in functions [`Corpus.count`](https://grew.fr/python/grewpy.html#grewpy.corpus.Corpus.count) and [`Corpus.search`](https://grew.fr/python/grewpy.html#grewpy.corpus.Corpus.search)

--- 

## Clustering with a key

### Clustering on a node feature
With the clustering key `N.f`, the matchings are clustered following the value of the feature named `f` for the node `N` present in the (matching part of) main request.
If for some matchings, the feature is not defined, a cluster is added with the value `__undefined__`.

#### Examples
  * List lemmas of auxiliaries in **UD_Polish-LFG** {{< tryit "http://universal.grew.fr/?corpus=UD_Polish-LFG@2.12&pattern=pattern { N [upos=AUX] }&clust1_key=N.lemma">}}
  * List `VerbForm` of `VERB` without `nsubj` in **UD_German-GSD** {{< tryit "http://universal.grew.fr/?corpus=UD_German-GSD@2.12&pattern=pattern { N [upos=VERB] }%0Dwithout { N -[1=nsubj]-> M }&clust1_key=N.VerbForm">}}
  * Find the huge number of `form` associated to the lemma _saada_ in **UD_Finnish-FTB**{{< tryit "http://universal.grew.fr/?corpus=UD_Finnish-FTB@2.12&pattern=pattern { N [lemma=\"saada\"] }&clust1_key=N.form">}}

### Clustering on a edge feature
With the clustering key `e.f`, the matchings are clustered following the value of the feature named `f` for the edge `e` present in the (matching part of) main request.
If for some matchings, the feature is not defined, a cluster is added with the value `__undefined__`.

#### Example
  * List sub-relations used with `acl` relation in **UD_Swedish-Talbanken** {{< tryit "http://universal.grew.fr/?corpus=UD_Swedish-Talbanken@2.12&pattern=pattern { e: GOV -[1=acl]-> DEP }&clust1_key=e.2">}}

### Clustering on the full label of an edge
With the clustering key `e.label`, the matchings are clustered following the full label of edge `e` present in the (positive part of) main request. **NB** the way the label value is reported depends on the configuration used.

#### Example
  * List relations used for auxiliaries in **UD_Italian-ParTUT** {{< tryit "http://universal.grew.fr/?corpus=UD_Italian-ParTUT@2.12&pattern=pattern { e:M -> N; N [upos=AUX] }&clust1_key=e.label">}}


### Clustering on an edge length
The clustering key `e.length` make clusters following the length of edge `e`; the clustering key `e.delta` make clusters following the relative positions of governor and dependent of edge `e`.

#### Examples
  * Observe the length of the `amod` relation in **UD_Korean-PUD**{{< tryit "http://universal.grew.fr/?corpus=UD_Korean-PUD@2.12&pattern=pattern { e: GOV -[amod]-> DEP }&clust1_key=e.length">}}
  * Observe the relative positions of `nsubj` related tokens in **UD_Naija-NSC** {{< tryit "http://match.grew.fr/?corpus=UD_Naija-NSC@2.12&pattern=pattern { e: GOV -[nsubj]-> DEP }&clust1_key=e.delta">}}

### Clustering of continuous numeric features
As suggested in [#28](https://github.com/grew-nlp/grew/issues/28), in case of continuous numeric feature, it is sensible to cluster by value intervals.
 * `X.feat[gap=g]` will cluster the values of X.feat by packs of size g
 * `X.feat[gap=g, min=a, max=b]` will cluster the values between a and b by pack of size g, with two packs for all values < a and > b.

#### Example
There is not much examples of numerical features in the current UD version.
The following example is not linguistically pertinent but it shows the mechanism.

{{< tryit "http://universal.grew.fr/?corpus=UD_Naija-NSC@2.12&request=pattern { N [AlignBegin] }&clustering=N.AlignBegin[gap=1000, min=10000, max=20000]" >}} on `UD_Naija-NSC` with clustering key `N.AlignBegin[gap=1000, min=10000, max=20000]` and request:
```grew
pattern { N [AlignBegin] }
```

There are (up to) 12 clusters, named `]-∞, 10000[`, `[10000, 11000[`, … `[19000, 20000[` and `[20000, +∞[`.

### Clustering on successive feature names
The feature name [`ExtPos`](https://surfacesyntacticud.github.io/guidelines/u/extpos/) is used mainly when the *external POS* differs from the regular `upos`.
So it may be useful to be able to report the value of `ExtPos` if it exists and the value of `upos` else. 
This is possible with the clustering key `N.ExtPos/upos`

#### Example with `ExtPos`
On UD_French-GSD, when searching for POS of a dependent of the `case` relation with the request `pattern { H -[case]-> D }`, the clustering key `D.upos` reports 6 clusters {{< tryit "http://universal.grew.fr/?corpus=UD_French-GSD@2.12&request=pattern { H -[case]-> D }&clustering=D.upos" >}} and the clustering key `D.ExtPos/upos` reports the more regular set of 2 clusters {{< tryit "http://universal.grew.fr/?corpus=UD_French-GSD@2.12&request=pattern { H -[case]-> D }&clustering=D.ExtPos/upos" >}}.

#### Example with corrected features

This kind of clustering key can also be useful with features `Correct{feature}` ([see UD guidelines](https://universaldependencies.org/misc.html#correctfeature)).
For instance on UD_French-GSD, with the request 
```grew
pattern { N -[amod]-> A ; N.Gender <> A.Gender}
```

and the two clustering keys `N.CorrectGender/Gender` and `A.CorrectGender/Gender`
{{< tryit "http://universal.grew.fr/?corpus=UD_French-GSD@2.12&request=pattern { N -[amod]-> A ; N.Gender <> A.Gender}&clust1_key=N.CorrectGender/Gender&clust2_key=A.CorrectGender/Gender" >}}, we can observe more in details the Gender agreement between two nodes related by `amod`: most of the case are link to typos, many of the other cases are annotation errors in version 2.12.

### Clustering on relative order of nodes

With a clustering key `N1#N2#N3` where `N1`, `N2` and `N3` are nodes from the `pattern` part of the request, the occurrences are clustered according to the relative order of nodes and clusters are identified by `N1 << N2 << N3`, `N2 << N1 << N3`… This can be used with any number of nodes.

#### Example: Verb, Subject, Object ordering

On UD, with the request;

```grew
pattern {
  V[upos=VERB];
  V -[nsubj]-> S;
  V -[obj]-> O;
}
````

and with the clustering key `V#S#O`, we can observe the occurrences of the 6 possible orders SVO, SOV…
{{< tryit "http://universal.grew.fr/?corpus=UD_Latin-Perseus@2.12&request=pattern { %0A  V[upos=VERB];%0A  V -[nsubj]-> S;%0A  V -[obj]-> O;%0A }&clustering=V%23S%23O" >}} on `UD_Latin-Perseus`.


#### Example: positions of copula and adposition sharing the same head

```grew
pattern {
  H [];
  COP [upos=AUX]; H -[cop]-> COP;
  ADP [upos=ADP]; H -[case|mark]-> ADP;
}
````

{{< tryit "http://universal.grew.fr/?corpus=UD_French-GSD@2.12&request=pattern { %0A  H [];%0A  COP [upos=AUX]; H -[cop]-> COP;%0A  ADP [upos=ADP]; H -[case|mark]-> ADP;%0A}&clustering=H%23COP%23ADP" >}} on `UD_French-GSD` with the clustering key `H#COP#ADP`.

### Clustering on how two nodes are related (or not)

 * With the clustering key `N1 -> N2`, the occurrences are clustered according to the relation from `N1` to `N2`; a cluster named `__none__` gathers the cases when there is no relation from `N1` to `N2`. If there is more than one such relations, another cluster `__multi__` is added. Note that with dependency syntax, the cluster `__multi__` will never appear, but it can appear in other context like enhanced UD or semantic graphs.

 * With the clustering key `N1 <-> N2`, the occurrences are clustered according to the relation between `N1` and `N2` (whatever the direction); if the direction is from `N2` to `N1`, the relation name is prefixed with minus sign like `-nsubj` or `-mark:rel`.
 A cluster named `__none__` gathers the cases when there is no relation between `N1` and `N2`. If there is more than one such relations, another cluster `__multi__` is added.

#### Annotation of a bigram DET NOUN
With a clustering key `N2 -> N1` and the pattern:
```grew
pattern { N1 [upos=DET]; N2 [upos=NOUN]; N1 < N2 }
```

we can observe how the bigram is annotated: {{< tryit "http://universal.grew.fr/?corpus=UD_German-GSD@2.12&request=pattern { N1 [upos=DET]; N2 [upos=NOUN]; N1 < N2 }&clustering=N2 -> N1" >}} on `UD_German-GSD`.

#### Annotation of a bigram NOUN NOUN
With a clustering key `N1 <-> N2` and the pattern:
```grew
pattern { N1 [upos=NOUN]; N2 [upos=NOUN]; N1 < N2 }
```

we can observe how the bigram NOUN-NOUN is annotated: {{< tryit "http://universal.grew.fr/?corpus=UD_English-GUM@2.12&request=pattern { N1 [upos=NOUN]; N2 [upos=NOUN]; N1 < N2 }&clustering=N1 <-> N2" >}} on `UD_English-GUM` or 
{{< tryit "http://universal.grew.fr/?corpus=UD_Chinese-GSD@2.12&request=pattern { N1 [upos=NOUN]; N2 [upos=NOUN]; N1 < N2 }&clustering=N1 <-> N2" >}} on `UD_Chinese-GSD`.

--- 

## Clustering with a sub-request (`whether`)

A `whether` sub-request contains a list of clauses (as in `pattern`, `without` or `with` constructions).
The set of occurrences is split in two subsets:
  * one tagged `No` corresponds to the subset of occurrences where the `whether` sub-request cannot be fulfilled (the `whether` is interpreted like a `without`)
  * one tagged `Yes` is the complementary of the `No` subset and so, corresponds to the occurrences where the sub-request can be matched (the `whether` is interpreted like a `with`)

Note that no curly brackets are needed in the `whether` text area (see examples below).

### Examples

  * Is `advcl` left-headed in **UD_Hungarian-Szeged**? {{< tryit "http://match.grew.fr/?corpus=UD_Hungarian-Szeged@2.12&pattern=pattern { GOV -[advcl]-> DEP }&whether=GOV << DEP" >}}
  * In **UD_English-GUM**, how often the relation `expl` appear with or without an `nsubj` relation with the same head? {{< tryit "http://match.grew.fr/?corpus=UD_English-GUM@2.12&pattern=pattern { GOV -[1=expl]-> DEP }&whether=GOV -[1=nsubj]-> S" >}}
  * In **UD_French-GSD**, there are 627 left-headed `nsubj` (or subtypes):
    * How often is it in an interrogative sentences? {{< tryit "http://match.grew.fr/?corpus=UD_French-GSD@2.12&pattern=pattern { GOV -[1=nsubj]-> DEP; GOV << DEP }&whether=P [lemma=%22?%22]" >}}
    * How often is it in an relative clause? {{< tryit "http://match.grew.fr/?corpus=UD_French-GSD@2.12&pattern=pattern { GOV -[1=nsubj]-> DEP; GOV << DEP }&whether=H -[acl:relcl]-> GOV" >}}
    * How often is there an expletive subject? {{< tryit "http://match.grew.fr/?corpus=UD_French-GSD@2.12&pattern=pattern { GOV -[1=nsubj]-> DEP; GOV << DEP }&whether=GOV -[expl:subj]-> E" >}}
