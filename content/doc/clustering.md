# Clustering

There is a general clustering mechanism in **Grew** that can be used in various contexts to divide a set of matchings produced by a request on a corpus into a number of subsets (a partition) according to some criteria.

--- 

## Where it can be used?

 * In **Grew-match**, below the main textarea where the request is written, it is possible to describe either one or two clustering items
 * With the command line argument, in `grep` or `count` mode, clustering can be performed.
 Details and examples can be found [here for `grep`](../../usage/cli#with-clustering) and [here for `count`](../../usage/cli#example-with-multi-mode-one-request-and-a-key-clustering-of-the-output)
 * Using Python library **Grewpy**, in the functions [`Corpus.count`](https://grew.fr/python/grewpy.html#grewpy.corpus.Corpus.count) and [`Corpus.search`](https://grew.fr/python/grewpy.html#grewpy.corpus.Corpus.search)

--- 

## Clustering with a key

### Clustering on a node feature
With the clustering key `X.f`, the matchings are clustered following the value of the feature named `f` for the node `X` present in the (matching part of the) main request.
If the feature is not defined for some matchings, a cluster with the value `__undefined__` is added.

#### Examples
  * List lemmas of auxiliaries in **UD_Polish-LFG** {{< tryit "http://universal.grew.fr/?corpus=UD_Polish-LFG@2.14&pattern=pattern { X [upos=AUX] }&clust1_key=X.lemma">}}
  * List `VerbForm` of `VERB` without `nsubj` in **UD_German-GSD** {{< tryit "http://universal.grew.fr/?corpus=UD_German-GSD@2.14&pattern=pattern { X [upos=VERB] }%0Dwithout { X -[1=nsubj]-> Y }&clust1_key=X.VerbForm">}}
  * Find the huge number of `form` associated to the lemma _saada_ in **UD_Finnish-FTB**{{< tryit "http://universal.grew.fr/?corpus=UD_Finnish-FTB@2.14&pattern=pattern { X [lemma=\"saada\"] }&clust1_key=X.form">}}

### Clustering on a edge feature
With the clustering key `e.f`, the matchings are clustered following the value of the feature named `f` for the edge `e` present in the (matching part of) main request.
If for some matchings, the feature is not defined, a cluster is added with the value `__undefined__`.

#### Example
  * List sub-relations used with `acl` relation in **UD_Swedish-Talbanken** {{< tryit "http://universal.grew.fr/?corpus=UD_Swedish-Talbanken@2.14&pattern=pattern { e: X -[1=acl]-> Y }&clust1_key=e.2">}}

### Clustering on the full label of an edge
With the clustering key `e.label`, the matchings are clustered according to the full label of edge `e` present in the (positive part of the) main request.
**NB** the way the label value is reported depends on the configuration used.

#### Example
  * List relations used for auxiliaries in **UD_Italian-ParTUT** {{< tryit "http://universal.grew.fr/?corpus=UD_Italian-ParTUT@2.14&pattern=pattern { e:X -> Y; Y [upos=AUX] }&clust1_key=e.label">}}


### Clustering on an edge length
The clustering key `e.length` makes clusters according to the length of the edge `e`;
the clustering key `e.delta` makes clusters according to the relative positions of the governor and the dependent of the edge `e`.

#### Examples
  * Observe the length of the `amod` relation in **UD_Korean-PUD**{{< tryit "http://universal.grew.fr/?corpus=UD_Korean-PUD@2.14&pattern=pattern { e: X -[amod]-> Y }&clust1_key=e.length">}}
  * Observe the relative positions of `nsubj` related tokens in **UD_Naija-NSC** {{< tryit "http://match.grew.fr/?corpus=UD_Naija-NSC@2.14&pattern=pattern { e: X -[nsubj]-> Y }&clust1_key=e.delta">}}

### Clustering on distance between nodes
🆕 in Version 1.16. Similarly to the [new syntax for request](../request#constraints-on-distance-between-two-nodes), it is possible to cluster on the distance between two nodes:
 - `length(X,Y)` absolute distance between `X` and `Y` {{< tryit "http://universal.grew.fr/?corpus=UD_Galician-PUD@2.14&request=pattern { X -[amod]-> Y }&clustering=length(X,Y)" >}}
 - `delta(X,Y)` relative distance between `X` and `Y` {{< tryit "http://universal.grew.fr/?corpus=UD_Galician-PUD@2.14&request=pattern { X -[amod]-> Y }&clustering=delta(X,Y)" >}}

Note that this is partly redondant with the previous point (clustering on an edge length), but it can also be used on a pair of nodes that are not connected.
For example, you can cluster on the relative distance between a subject and an object that depend on the same governor: {{< tryit "http://universal.grew.fr/?corpus=UD_Galician-PUD@2.14&request=pattern { X -[nsubj]-> S; X -[obj]-> O }&clustering=delta(S,O)" >}}

### Clustering of continuous numeric features
As suggested in [#28](https://github.com/grew-nlp/grew/issues/28), in case of continuous numeric feature, it is sensible to cluster by value intervals.
 * `X.feat[gap=g]` will cluster the values of X.feat by packs of size g
 * `X.feat[gap=g, min=a, max=b]` will cluster the values between a and b by pack of size g, with two packs for all values < a and > b.

#### Example
The Naija treebank has a version with prosodic information.

{{< tryit "https://naija.grew.fr/?corpus=SUD_Naija-NSC-prosody&request=pattern { S [SylForm = \"wO~\", Duration] }&clustering=S.Duration[gap=100]" >}} on `UD_Naija-NSC` with clustering key `S.Duration[gap=100]` and request:
```grew
pattern { S [SylForm = "wO~", Duration] }
```

There are 8 clusters, named `[0, 100[`, `[100, 200[`, … `[700, 800[`.

### Clustering on successive feature names
The feature name [`ExtPos`](https://surfacesyntacticud.github.io/guidelines/u/extpos/) is mainly used when the *external POS* is different from the regular `upos`.
So it may be useful to be able to report the value of `ExtPos` if it exists and the value of `upos` otherwise. 
This is possible with the clustering key `X.ExtPos/upos`.

#### Example with `ExtPos`
On **UD_French-GSD**, when searching for POS of a dependent of the `case` relation with the request `pattern { X -[case]-> Y }`, the clustering key `Y.upos` reports 7 clusters {{< tryit "http://universal.grew.fr/?corpus=UD_French-GSD@2.14&request=pattern { X -[case]-> Y }&clustering=Y.upos" >}} (use the `Count` button to see all clusters) and the clustering key `Y.ExtPos/upos` reports the more regular set of 2 clusters {{< tryit "http://universal.grew.fr/?corpus=UD_French-GSD@2.14&request=pattern { X -[case]-> Y }&clustering=Y.ExtPos/upos" >}}.

#### Example with corrected features

This kind of clustering key can also be useful with features `Correct{feature}` ([see UD guidelines](https://universaldependencies.org/misc.html#correctfeature)).
For instance on UD_French-GSD, with the request 
```grew
pattern { X -[amod]-> Y ; X.Gender <> Y.Gender}
```

and the two clustering keys `X.CorrectGender/Gender` and `Y.CorrectGender/Gender`
{{< tryit "http://universal.grew.fr/?corpus=UD_French-GSD@2.14&request=pattern { X -[amod]-> Y ; X.Gender <> Y.Gender}&clust1_key=X.CorrectGender/Gender&clust2_key=Y.CorrectGender/Gender" >}}, we can observe in more detail the `Gender` agreement between two nodes related by `amod`.

### Clustering by relative order of nodes

With a clustering key `X1#X2#X3` where `X1`, `X2` and `X3` are nodes from the `pattern` part of the request, the occurrences are clustered according to the relative order of the nodes and clusters are identified by `X1 << X2 << X3`, `X2 << X1 << X3`… This can be used with any number of nodes.

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
{{< tryit "http://universal.grew.fr/?corpus=UD_Latin-Perseus@2.14&request=pattern { %0A  V[upos=VERB];%0A  V -[nsubj]-> S;%0A  V -[obj]-> O;%0A }&clustering=V%23S%23O" >}} on `UD_Latin-Perseus`.


#### Example: positions of copula and adposition sharing the same head

```grew
pattern {
  HEAD [];
  COP [upos=AUX]; HEAD -[cop]-> COP;
  ADP [upos=ADP]; HEAD -[case|mark]-> ADP;
}
````

{{< tryit "http://universal.grew.fr/?corpus=UD_French-GSD@2.14&request=pattern { %0A  HEAD [];%0A  COP [upos=AUX]; HEAD -[cop]-> COP;%0A  ADP [upos=ADP]; HEAD -[case|mark]-> ADP;%0A}&clustering=HEAD%23COP%23ADP" >}} on `UD_French-GSD` with the clustering key `HEAD#COP#ADP`.

### Clustering on how two nodes are related (or not)

 * With the clustering key `X -> Y`, the occurrences are clustered according to the relation from `X` to `Y`; a cluster named `__none__` collects the cases where there is no relation from `X` to `Y`. If there is more than one such relations, another cluster `__multi__` is added.
 Note that the `__multi__` cluster never appears in dependency syntax, but it may appear in other contexts such as enhanced UD or semantic graphs.

 * With the clustering key `X <-> Y`, the occurrences are clustered according to the relation between `X` and `Y` (no matter which direction); if the direction is from `Y` to `X`, the relation name is prefixed with minus sign like `-nsubj` or `-mark:rel`.
 A cluster called `__none__` contains the cases where there is no relation between `X` and `Y`. If there is more than one such relation, another cluster `__multi__` is added.

#### Annotation of a bigram DET NOUN
With a clustering key `Y -> X` and the pattern:
```grew
pattern { X [upos=DET]; Y [upos=NOUN]; X < Y }
```

we can observe how the bigram is annotated: {{< tryit "http://universal.grew.fr/?corpus=UD_German-GSD@2.14&request=pattern { X [upos=DET]; Y [upos=NOUN]; X < Y }&clustering=Y -> X" >}} on `UD_German-GSD`.

#### Annotation of a bigram NOUN NOUN
With a clustering key `X <-> Y` and the pattern:
```grew
pattern { X [upos=NOUN]; Y [upos=NOUN]; X < Y }
```

we can observe how the bigram NOUN-NOUN is annotated: {{< tryit "http://universal.grew.fr/?corpus=UD_Chinese-GSD@2.14&request=pattern { X [upos=NOUN]; Y [upos=NOUN]; X < Y }&clustering=X <-> Y" >}} on `UD_Chinese-GSD` or {{< tryit "http://universal.grew.fr/?corpus=bUD_English-GUM@2.14&request=pattern { X [upos=NOUN]; Y [upos=NOUN]; X < Y }&clustering=X <-> Y" >}} on `bUD_English-GUM` (`bUD` is the version of the treebank whitout the enhanced dependency layer).

--- 

## Clustering with a sub-request (`whether`)

A `whether` sub-request contains a list of clauses (as in `pattern`, `without` or `with` constructions).
The set of occurrences is split in two subsets:
  * one tagged `No` corresponds to the subset of occurrences where the `whether` sub-request cannot be fulfilled (the `whether` is interpreted like a `without`)
  * one tagged `Yes` is the complementary of the `No` subset and so, corresponds to the occurrences where the sub-request can be matched (the `whether` is interpreted like a `with`)

Note that no curly brackets are needed in the `whether` text area (see examples below).

### Examples

  * Is `advcl` left-headed in **UD_Hungarian-Szeged**? {{< tryit "http://match.grew.fr/?corpus=UD_Hungarian-Szeged@2.14&pattern=pattern { X -[advcl]-> Y }&whether=X << Y" >}}
  * In **UD_English-GUM**, how often does the relation `expl` appear with or without an `nsubj` relation with the same head? {{< tryit "http://match.grew.fr/?corpus=UD_English-GUM@2.14&pattern=pattern { X -[1=expl]-> Y }&whether=X -[1=nsubj]-> S" >}}
  * In **UD_French-GSD**, there are 619 left-headed `nsubj` (or subtypes):
    * How often is it in an interrogative sentences? {{< tryit "http://match.grew.fr/?corpus=UD_French-GSD@2.14&pattern=pattern { X -[1=nsubj]-> Y; X << Y }&whether=P [lemma=%22?%22]" >}} (NB: We approximate interrogative with the presence of "?")
    * How often is it in an relative clause? {{< tryit "http://match.grew.fr/?corpus=UD_French-GSD@2.14&pattern=pattern { X -[1=nsubj]-> Y; X << Y }&whether=H -[acl:relcl]-> X" >}}
    * How often is there an expletive subject? {{< tryit "http://match.grew.fr/?corpus=UD_French-GSD@2.14&pattern=pattern { X -[1=nsubj]-> Y; X << Y }&whether=X -[expl:subj]-> E" >}}
