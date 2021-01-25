+++
date = "2020-12-02T20:33:52+01:00"
title = "05_confluence"
Tags = ["Development","golang"]
Description = ""
menu = "main"
Categories = ["Development","GoLang"]

+++

[[Lesson 4] Termination](../04_terminaison) --- [[Lesson 6] More commands](../06_more_commands)

---

# Grew Tutorial • Lesson 5 • Confluence

Another well-known issue with rewriting is the problem of confluence.

## Two concurrent rules

As said earlier, the Sequoia tag `V` may be converted to `AUX` or `VERB`.
A naive way to encode this in rules is to write the package:


{{< grew file="/static/tutorial/05_confluence/aux_verb.grs" >}}

The two rules overlap: each time a POS `V` is found, both rules can be used and produce a different output!
We call this kind of system non-confluent.

So, what is the output of the following commands?
```
grew transform -config sequoia -grs aux_verb.grs -strat "Onf(v)" -i frwiki_50.1000_00907.seq.conll
```

Let's try it:

{{< input file="static/tutorial/05_confluence/_build/onf_aux_verb.conll" >}}

Well, it produced exactly one graph output by choosing (in a way which cannot be controlled) one of the possible ways to rewrite.

What should we do with non-confluent system?
In fact, there are two possible situations:

 * The two rules are correct and there is a real (linguistic) ambiguity; and the different solutions must be considered.
 * There is no ambiguity, the rules must be corrected.

In our example (`AUX` and `VERB`), we are clearly in the second case, but let us consider the other one anyway, just to see how to deal with really non-confluent setting.

## The `Iter` strategy

Here, we suppose then that we are interested in all possible solutions.
**Grew** provides a strategy `Iter` to do this:

```
grew transform -config sequoia -grs aux_verb.grs -strat "Iter(v)" -i frwiki_50.1000_00907.seq.conll
```

This will produces 4 different graphs with all combination of `AUX` and `VERB` for the two words *sont* and *montrées*.

{{< input file="static/tutorial/05_confluence/_build/iter_aux_verb.conll" >}}

## Be stricter in rules design

Of course, in our POS tags conversion example, the correct solution is to design more carefully our two rules, in order to produce the correct output. For instance:

{{< grew file="/static/tutorial/05_confluence/aux_verb_confluent.grs" >}}

Here, the two rules are clearly separated: the same clause `M -[aux.pass]-> N` is used first the `pattern` part for rule `aux` and in the `without` part for the rule `verb`.
For each occurence of `V` in the sentence, exactly one of the two rules can be used.

With these two new rules, the system is confluent, and there is only one possible output.
This can be tested with the `Iter` strategy which produces all possible graphs:

```
grew transform -config sequoia -grs aux_verb_confluent.grs -strat "Iter(v)" -i frwiki_50.1000_00907.seq.conll
```

{{< input file="static/tutorial/05_confluence/_build/iter_aux_verb_confluent.conll" >}}

Of course, the `Onf` produces the same output in this setting.

Note that there are two different ways to compute the final graph: first apply rule `aux` and then the rule `verb` or the other way round: rule `verb` and then rule `aux`. But the important consequence of the confluence property is that the same graph is produced in both cases.

## :warning: user `Iter` carefully

When a package `p` is confluent, the two strategies `Onf(p)` and `Iter(p)` give the same result.
In practice, the strategy `Onf(p)` must be preferred because it is much more efficient to compute.

The `Iter(p)` strategy computes the set of all graphs which can be obtained with the package `p` from the input graph and then, returns the subset of normal forms.

If the rule applies in several places in the graph, the number of graphs can be huge.
For instance, with the rule `del_xpos` below, if the graph *G* contains *n* nodes with an `xpos` feature, the number of graphs in the produced set is 2<sup>n</sup> (each one of the *n* nodes can appear with or without `xpos` feature).

{{< grew file="/static/tutorial/05_confluence/del_xpos.grs" >}}

We have seen in the previous lesson that **Grew** stops the computation when a bound in the number of rule applications is reached.
By default, the bound is 10,000; so, if we try to apply the strategy `Iter(del_xpos)` to the 14 nodes graph:

{{< input file="static/tutorial/05_confluence/14_nodes.conllu" >}}

There are 2<sup>14</sup> = 16,384 graphs to compute and necessarily at least the same number of rule applications.

Hence, even if there is no loop in this case, there is a huge number of rule applications, this explain why **Grew** wrongly detects a loop and output the message:

{{< error file="static/tutorial/05_confluence/_build/wrong_loop.log" >}}





---

[[Lesson 4] Termination](../04_terminaison) --- [[Lesson 6] More commands](../06_more_commands)
