+++
title = "02_first_rule"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""
menu = "main"
date = "2020-12-01T13:14:46+01:00"

+++

[Matching :arrow_left:](../01_matching) • [:arrow_up:](../top) • [:arrow_right: Rules set](../03_rules_set)

---

# Grew Tutorial • Lesson 2 • First rule

In this lesson, we write a rule and learn how to apply it to some graph.

The conversion between different formats is one of the common usages of Grew.
We will use the example of the conversion from one dependency annotation format (used in the Sequoia project) to Surface Syntactic Universal Dependencies (SUD).

## Data

We consider the sentence `frwiki_50.1000_00907` *Deux autres photos sont également montrées du doigt* [en: *Two other photos are also pointed out*].
The two annotations (Sequoia and SUD) are:

| Format | `frwiki_50.1000_00907` |
|:---:|:---:|
| Sequoia [:link:CoNLL](/tutorial/02_first_rule/frwiki_50.1000_00907.seq.conll) | ![sequoia](/tutorial/02_first_rule/_build/frwiki_50.1000_00907.seq.svg) |
| SUD [:link:CoNLL](/tutorial/02_first_rule/frwiki_50.1000_00907.sud.conllu) | ![sud](/tutorial/02_first_rule/_build/frwiki_50.1000_00907.sud.svg) |

## The adjective rule

The whole transformation is decomposed into small steps which are described by rules.
In our example, we need a rule to change the POS for adjectives: `A` is used in Sequoia and `ADJ` in SUD.

The following **Grew** rule [`adjective.grs`](/tutorial/02_first_rule/adjective.grs) can do this transformation:

{{< grew file="/static/tutorial/02_first_rule/adjective.grs" >}}

The command used to apply the rule to the input graph is:

```
grew transform -config sequoia -grs adjective.grs -strat "adj" -i frwiki_50.1000_00907.seq.conll
```

and it produces:

{{< input file="static/tutorial/02_first_rule/_build/one_step_adj.conll" >}}

which correspond to the graph below where the POS of *autres* is now `ADJ`:

![one_step_adj](/tutorial/02_first_rule/_build/one_step_adj.svg)

## Some other rules

Let us consider two other similar rules ([`preposition.grs`](/tutorial/02_first_rule/preposition.grs), [`noun.grs`](/tutorial/02_first_rule/noun.grs)) needed for the conversion:

{{< grew file="/static/tutorial/02_first_rule/preposition.grs" >}}
{{< grew file="/static/tutorial/02_first_rule/noun.grs" >}}

With the command:

```
grew transform -config sequoia -grs preposition.grs -strat "prep" -i frwiki_50.1000_00907.seq.conll
```

the output is the empty set:

{{< input file="static/tutorial/02_first_rule/_build/one_step_prep.conll" >}}

With the command:

```
grew transform -config sequoia -grs noun.grs -strat "noun" -i frwiki_50.1000_00907.seq.conll
```

the output contains two graphs, one with the first noun *photos* with the new tag `NOUN` and the other with the second noun *doigt* with the new tag `NOUN`:

{{< input file="static/tutorial/02_first_rule/_build/one_step_noun.conll" >}}

In fact, the result of the application of a rule on a graph is a set of graphs, one for each occurence of the request found in the input graph. This set is then empty if the the request is not found (like `pattern { X [upos=P] }`) or contains two graphs if the request is found twice (like `pattern { X [upos=N] }`).
To iterate the application of a rule, one has to use the strategy `Onf`.

## The strategy `Onf`

If we use the strategy `Onf (noun)` instead of `noun` in the last command above, the rule `noun` is iterated as much as possible.
In our examples:

```
grew transform -config sequoia -grs noun.grs -strat "Onf (noun)" -i frwiki_50.1000_00907.seq.conll
```

produces the graph where the two nouns have the new tag `NOUN`:

{{< input file="static/tutorial/02_first_rule/_build/onf_noun.conll" >}}

Note that `Onf` always outputs exactly one graph.
With the strategy `Onf(prep)` for instance, the rewriting process will output one graph, identical to the input graph, obtained after 0 application of the `prep` rule.

**NB** : `Onf` stands for "one normal form"; it will be explained more in detail later with other strategies.

---

[Matching :arrow_left:](../01_matching) • [:arrow_up:](../top) • [:arrow_right: Rules set](../03_rules_set)
