+++
title = "Work in progress"
+++

# New clustering keys

⚠️ This page describes work in progress. The features mentioned here may change. ⚠️

In the current online version of Grew-match a few new clustering keys are available.
The syntax used both in the way the keys are written and how the clusters are named is subject to change.
There is a discussion [in this GitHub issue](https://github.com/grew-nlp/grew/issues/32) where you can give your opinion about these choices.

--- 

## Clustering of continuous numeric features
As suggested in [#28](https://github.com/grew-nlp/grew/issues/28), in case of continuous numeric feature, it is sensible to cluster by value intervals.
 * `X.feat[gap=g]` will cluster the values of X.feat by packs of size g
 * `X.feat[gap=g, min=a, max=b]` will cluster the values between a and b by pack of size g, with two packs for all values < a and > b.

### Example
There is not much examples of numerical features in the current UD version.
The following example is not linguistically pertinent buy shows the mechanism.

{{< tryit "http://universal.grew.fr/?corpus=UD_Naija-NSC@2.11&request=pattern { N [AlignBegin] }&clustering=N.AlignBegin[gap=1000, min=10000, max=20000]" >}} on `UD_Naija-NSC` with clustering key `N.AlignBegin[gap=1000, min=10000, max=20000]` and request:
```grew
pattern { N [AlignBegin] }
```

There are (up to) 12 clusters, named `]-∞, 10000[`, `[10000, 11000[`, … `[19000, 20000[` and `[20000, +∞[`.

--- 

## Clustering on successive feature names
The feature name [`ExtPos`](https://surfacesyntacticud.github.io/guidelines/u/extpos/) is used mainly when the *external POS* differs from the regular `upos`.
So it may be useful to be able to report the value of `ExtPos` if it exists and the value of `upos` else. 
This is possible with the clustering key `N.ExtPos/upos`

### Example with `ExtPos`
On UD_French-GSD, when searching for POS of a dependent of the `case` relation with the request `pattern { H -[case]-> D }`, the clustering key `D.upos` reports 6 clusters {{< tryit "http://universal.grew.fr/?corpus=UD_French-GSD@2.11&request=pattern { H -[case]-> D }&clustering=D.upos" >}} and the clustering key `D.ExtPos/upos` reports the more regular set of 2 clusters {{< tryit "http://universal.grew.fr/?corpus=UD_French-GSD@2.11&request=pattern { H -[case]-> D }&clustering=D.ExtPos/upos" >}}.

### Example with corrected features

This kind of clustering key can also be useful with features `Correct{feature}` ([see UD guidelines](https://universaldependencies.org/misc.html#correctfeature)).
For instance on UD_French-GSD, with the request 
```grew
pattern { N -[amod]-> A ; N.Gender <> A.Gender}
```

and the two clustering keys `N.CorrectGender/Gender` and `A.CorrectGender/Gender`
{{< tryit "http://universal.grew.fr/?corpus=UD_French-GSD@2.11&request=pattern { N -[amod]-> A ; N.Gender <> A.Gender}&clust1_key=N.CorrectGender/Gender&clust2_key=A.CorrectGender/Gender" >}}, we can observe more in details the Gender agreement between two nodes related by `amod`: most of the case are link to typos, many of the other cases are annotation errors in version 2.11.

--- 

## Clustering on relative order of nodes

With a clustering key `N1#N2#N3` where `N1`, `N2` and `N3` are nodes from the `pattern` part of the request, the occurrences are clustered according to the relative order of nodes and clusters are identified by `N1 << N2 << N3`, `N2 << N1 << N3`… This can be used with any number of nodes.

### Example: Verb, Subject, Object ordering

On UD, with the request;

```grew
pattern {
  V[upos=VERB];
  V -[nsubj]-> S;
  V -[obj]-> O;
}
````

and with the clustering key `V#S#O`, we can observe the occurrences of the 6 possible orders SVO, SOV…
{{< tryit "http://universal.grew.fr/?corpus=UD_Latin-Perseus@2.11&request=pattern { %0A  V[upos=VERB];%0A  V -[nsubj]-> S;%0A  V -[obj]-> O;%0A }&clustering=V%23S%23O" >}} on `UD_Latin-Perseus`.


### Example: positions of copula and adposition sharing the same head

```grew
pattern {
  H [];
  COP [upos=AUX]; H -[cop]-> COP;
  ADP [upos=ADP]; H -[case|mark]-> ADP;
}
````

{{< tryit "http://universal.grew.fr/?corpus=UD_French-GSD@2.11&request=pattern { %0A  H [];%0A  COP [upos=AUX]; H -[cop]-> COP;%0A  ADP [upos=ADP]; H -[case|mark]-> ADP;%0A}&clustering=H%23COP%23ADP" >}} on `UD_French-GSD` with the clustering key `H#COP#ADP`.

--- 

## Clustering on how two nodes are related (or not)

 * With the clustering key `N1 -> N2`, the occurrences are clustered according to the relation from `N1` to `N2`; a cluster named `__none__` gathers the cases when there is no relation from `N1` to `N2`. If there is more than one such relations, another cluster `__multi__` is added. Note that with dependency syntax, the cluster `__multi__` will never appear, but it can appear in other context like enhanced UD or semantic graphs.

 * With the clustering key `N1 <-> N2`, the occurrences are clustered according to the relation between `N1` and `N2` (whatever the direction); if the direction is from `N2` to `N1`, the relation name is prefixed with minus sign like `-nsubj` or `-mark:rel`.
 A cluster named `__none__` gathers the cases when there is no relation between `N1` and `N2`. If there is more than one such relations, another cluster `__multi__` is added.

### Annotation of a bigram DET NOUN
With a clutering key `N2 -> N1` and the pattern:
```grew
pattern { N1 [upos=DET]; N2 [upos=NOUN]; N1 < N2 }
```

we can observe how the bigram is annotated: {{< tryit "http://universal.grew.fr/?corpus=UD_German-GSD@2.11&request=pattern { N1 [upos=DET]; N2 [upos=NOUN]; N1 < N2 }&clustering=N2 -> N1" >}} on `UD_German-GSD`.

### Annotation of a bigram NOUN NOUN
With a clutering key `N1 <-> N2` and the pattern:
```grew
pattern { N1 [upos=NOUN]; N2 [upos=NOUN]; N1 < N2 }
```

we can observe how the bigram NOUN-NOUN is annotated: {{< tryit "http://universal.grew.fr/?corpus=UD_English-GUM@2.11&request=pattern { N1 [upos=NOUN]; N2 [upos=NOUN]; N1 < N2 }&clustering=N1 <-> N2" >}} in `UD_English-GUM` or 
{{< tryit "http://universal.grew.fr/?corpus=UD_Chinese-GSD@2.11&request=pattern { N1 [upos=NOUN]; N2 [upos=NOUN]; N1 < N2 }&clustering=N1 <-> N2" >}} in `UD_Chinese-GSD`.
