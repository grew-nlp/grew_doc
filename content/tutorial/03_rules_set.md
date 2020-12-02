+++
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""
menu = "main"
date = "2020-12-02T08:31:07+01:00"
title = "03_rules_set"

+++

[[Lesson 2] First rule](../02_first_rule) --- [[Lesson 4] Termination](../04_terminaison)

---

# Grew Tutorial • Lesson 3 • Rules set

In the previous lesson, we have seen 3 rules dealing with several POS.
We will learn how to make these rules working together.

## Packages

A solution to use several rules in the same rewriting process is to put them in the same `package` construction.

{{< grew file="/static/tutorial/03_rules_set/pos_rules.grs" >}}

The package name `POS` can be used as strategy name for rewriting.
Applying the package `POS` corresponds to the application of one of the rule of the package.

With the input graph used in the previous lesson:

![sequoia](/tutorial/02_first_rule/_build/frwiki_50.1000_00907.seq.svg)

The command below produces 3 graphs obtained either by the application of the rule `adj` or by the two possible applications of the rule `noun`.

```
grew transform -config sequoia -grs pos_rules.grs -strat "POS" -i frwiki_50.1000_00907.seq.conll
```

In order to iterate the package, we need the strategy `Onf (POS)`:

```
grew transform -config sequoia -grs pos_rules.grs -strat "Onf(POS)" -i frwiki_50.1000_00907.seq.conll
```

As usual with `Onf`, exactly one graph is produced obtained with the successive applications of the rules:

![onf_pos](/tutorial/03_rules_set/_build/onf_pos.svg)

---

[[Lesson 2] First rule](../02_first_rule) --- [[Lesson 4] Termination](../04_terminaison)
