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

If we define the two rules package above to convert the `V` Sequoia POS tag to SUD:

{{< grew file="/static/tutorial/05_confluence/aux_verb.grs" >}}

The two rules are incompatible, each time you find a POS `V`, both rule can be used and produces a different output!
We call this kind of system non-confluent

So, what is the output of the following commands?
```
grew transform -config sequoia -grs aux_verb.grs -strat "Onf(v)" -i frwiki_50.1000_00907.seq.conll
```

Let's try it:

{{< input file="static/tutorial/05_confluence/_build/onf_aux_verb.conll" >}}

Well, it produced exactly one graph output by choosing (in a way which cannot be controlled) one of the possible ways to rewrite.

What should we do with non-confluent system?
In fact, there are two possible situations:

 * the two rules are correct and there is a real (linguistic) ambiguity; and the different solutions must be considered.
 * there is no ambiguity, the rules must be corrected

In our example (`AUX` and `VERB`), we are clearly in the second case, but let us consider the other one anyway, just to see how to deal with really non-confluent setting.

## The `iter` strategy

Here, we suppose then that we are interested in all possible solutions.
**Grew** provides a strategy `Iter` to do this:

```
grew transform -config sequoia -grs aux_verb.grs -strat "Iter(v)" -i frwiki_50.1000_00907.seq.conll
```

This will produces 4 different graphs with all combination of `AUX` and `VERB` for the two words *sont* and *montrées*.

{{< input file="static/tutorial/05_confluence/_build/iter_aux_verb.conll" >}}

## Be stricter in rules design

Of course, in our POS tags conversion example, the correct solution is two design more carefully our two rules, in order to produce the correct output. For instance:

{{< grew file="/static/tutorial/05_confluence/aux_verb_confluent.grs" >}}

Here, the two rules are clearly incompatible: the same clause `M -[aux.pass]-> N` is used first the `pattern` part for rule `aux` and in the `without` part for the rule `verb`.
With these two new rules, the system is confluent, and there is only one possible output.
This can be tested with the `Iter` strategy which produces all possible graphs:

```
grew transform -config sequoia -grs aux_verb_confluent.grs -strat "Iter(v)" -i frwiki_50.1000_00907.seq.conll
```

{{< input file="static/tutorial/05_confluence/_build/iter_aux_verb_confluent.conll" >}}

Of course, the `Onf` produces the same output in this setting.

Note that there is two different ways to compute the final graph: first apply rule `aux` and then the rule `verb` or the other way round: rule `verb` and then rule `aux`. But the important property is that the same graph is produced in both cases.

:warning: when a package `p` is confluent, the two strategies `Onf(p)` and `Iter(p)` give the same result. In practice, the strategy `Onf(p)` must be preferred because it is much more efficient to compute.

---

[[Lesson 4] Termination](../04_terminaison) --- [[Lesson 6] More commands](../06_more_commands)
