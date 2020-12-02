+++
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""
menu = "main"
date = "2020-12-02T08:31:07+01:00"
title = "04_terminaison"

+++

[[Lesson 3] Rules set](../03_rules_set) --- [[Lesson 5] Confluence](../05_confluence)

---

# Grew Tutorial • Lesson 4 • Termination

One key problem that may arise when using rewriting is the non-termination of the process.
Let us look at a few examples and how we can deal with it in **Grew**.

In previous lessons, we have considered the conversion of Sequoia POS tags to SUD POS tags for some tags (adjectives, nouns and prepositions).

## A stupid looping rule

Consider now adverbs: the same tag `ADV` is used in both annotation setting.
We can then imagine the (somehow stupid) rule [`adverb.grs`](/tutorial/04_termination/adverb.grs) :

{{< grew file="/static/tutorial/04_termination/adverb.grs" >}}

Then apply it to our input graph, first alone and then with the `Onf` strategy:

```
grew transform -config sequoia -grs adverb.grs -strat "adv" -i frwiki_50.1000_00907.seq.conll
grew transform -config sequoia -grs adverb.grs -strat "Onf(adv)" -i frwiki_50.1000_00907.seq.conll
```

The fist command returns a graph which is identical to the input one: there is exactly one `ADV` in the input graph, the rule is applied to it and replaces `ADV` by `ADV`!

Now, the second command tries to apply the rule iteratively and stops when no more rule can be applied… but the rule can always be applied again and again at the same place. The computation is not terminating.
Fortunately, **Grew** tries to help us and provide the following error:

{{< error file="static/tutorial/04_termination/_build/loop.log" >}}

**Grew** tries to track the non termination problem with a bound on the number of rule applications (by default 10000) and stop the computation when the bound is reached. The error message also give the name of the last ten rules applied before the bound is reached to help us understand the problem.

The solution here, is of course to remove this rule which is useless, but more complicated case may occur!

## Another looping rule

Let us come back to our input graph:

![sequoia](/tutorial/02_first_rule/_build/frwiki_50.1000_00907.seq.svg)

and consider the conversion of the Sequoia POS `V`.
In SUD (like in UD), this tag should be converted to `AUX` or to `VERB`.
One way to decide that the new POS must be `AUX` is the presence of the relation `aux.pass`.
We can propose the rule:

{{< grew file="/static/tutorial/04_termination/aux_1.grs" >}}

but this rule will also produce an error if it is iterated: after the first application, the pattern `{ M -[aux.pass]-> N }` is still present in the graph and the rules can be applied again and again.

### Solution 1: make a stricter pattern

With the rule `aux_2`, the pattern can not be found after the first application and there will be no loop.

{{< grew file="/static/tutorial/04_termination/aux_2.grs" >}}


### Solution 2: use a without clause

The rule `aux_3` shows a more general trick which can be used in similar cases: add a `without` clause which explicitly contradicts the `commands` part.

{{< grew file="/static/tutorial/04_termination/aux_3.grs" >}}

## Termination in general

Of course, in a more general setting, we can have loops which imply more than one rule and which are more difficult to manage.
Unfortunately, it is not possible to decide algorithmically if some rewriting system is terminating or not.

Anyway, in NLP applications like conversions from format **A** to format **B**, it is often easy to ensure termination as we have a kind of measure which stands for the fact that we are closer to the **B** format after each rule application.
For instance, in all the non-looping rules below, if we count the number of Sequoia POS tag in the graph, it is strictly decreasing at each rule application.

---

 [[Lesson 3] Rules set](../03_rules_set) --- [[Lesson 5] Confluence](../05_confluence)
