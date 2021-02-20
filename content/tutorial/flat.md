+++
Tags = ["Development","golang"]
Description = ""
menu = "main"
Categories = ["Development","GoLang"]
date = "2019-06-01T20:54:20+02:00"
title = "flat"
+++

# Transformation of single-headed structure into a chained structure

:information_source: You can download files used in this page:
[rules.grs](/tutorial/flat/rules.grs),
[SH6.conll](/tutorial/flat/SH6.conll)

There are two basic ways to represent *flat* structures:

1. a single-headed structure: for instance the graph `SH6` below on the left for a 6 words flat structure
1. a chained structure: for instance the graph `C6` below on the right for the same 6 words flat structure

| SH6 |  C6 |
|:---:|:---:|
| ![SH6](/tutorial/flat/_build/SH6.svg) | ![alt C6](/tutorial/flat/_build/C6.svg) |

We will see how to convert from one to the other with Graph Rewriting.

## From single-headed to chained
Of course, this will be a iterative process able to deal with an arbitrary number of items.
The simplest rule we can think of is:

```grew
rule sh2c_1 {
  pattern {
    H -[fixed]-> N1;
    e:H -[fixed]-> N2;
    }
  commands {
    del_edge e;
    add_edge N1 -[fixed]-> N2;
  }
}
```

This rule searches for two nodes `N1` and `N2` with the same head `H` through the `fixed` relation.
But this rule applied iteratively on `GH6`:

 `grew transform -grs rules.grs -strat "Iter (sh2c_1)" -i SH6.conll -o C6_120.conll`

Output 120 normal forms! Here is one of them:

![C6_120_example](/tutorial/flat/_build/C6_120_example.svg)

Our rule is not strict enough. We have to put more restriction in the pattern part.
If we require that `N1` and `N2` are two consecutive words, the rule is:

```grew
rule sh2c_2 {
  pattern {
    H -[fixed]-> N1;
    e:H -[fixed]-> N2;
    N1 < N2;
    }
  commands {
    del_edge e;
    add_edge N1 -[fixed]-> N2;
  }
}
```

 `grew transform -grs rules.grs -strat "Iter (sh2c_2)" -i SH6.conll -o C6_5.conll`

Now, the command above produces 5 normal forms, one of which is:

![C6_5_example](/tutorial/flat/_build/C6_5_example.svg)

The rule was first applied with on nodes `w2` and `w3`.
After that, the nodes `w3` and `w4` don't have the same governor and the rule cannot be applied.
The rule must be stricter.
We want to impose that the rightmost nodes are chosen first.
This can be done using a `without` clause: the rule must be applied to `N1` and `N2` only if there is no node `N3` on the right of `N2` with a `fixed` link from `H` to `N3`.
In **Grew**, this is written:

```grew
rule sh2c {
  pattern {
    H -[fixed]-> N1;
    e:H -[fixed]-> N2;
    N1 < N2;
    }
  without {
    H -[fixed]-> N3;
    N2 < N3;
  }
  commands {
    del_edge e;
    add_edge N1 -[fixed]-> N2;
  }
}
```

`grew transform -grs rules.grs -strat "Iter (sh2c)" -i SH6.conll -o C6.conll`

Finally, we get only the expected normal form:

![alt C6](/tutorial/flat/_build/C6.svg)

The last rule can be applied only on the nodes `w5` and `w6` of the graph `SH6`;
in the next step, it can be applied only on the nodes `w4` and `w5`;
etc.

## From chained to single-headed
In the other way, again we can solve our problem by iterating the application of a single rule:

```grew
rule c2sh {
  pattern {
    H -[fixed]-> N1;
    e: N1 -[fixed]-> N2;
  }
  commands {
    del_edge e;
    add_edge H -[fixed]-> N2;
  }
}
```

`grew transform -grs rules.grs -strat "Iter (c2sh)" -i C6.conll -o SH6_auto.conll`

The output is called `SH6_auto.conll` to avoid replacing the file `SH6.conll` given at the beginning.
And `SH6_auto.conll` contains only one normal form which is equals to `SH6`.
So it seems that the first try is the good one! Well, it's not so simple, as often with Graph Rewriting!

The rewriting of `C6` is tricky, let's look at `C4`.
It can be rewritten to 6 different graphs:

![C4_reducts](/tutorial/flat/_build/C4_reducts.svg)

|     |                    |
|:---:|:------------------:|
| C4  | ![C4](/tutorial/flat/_build/C4.svg) |
| G1  | ![G1](/tutorial/flat/_build/G1.svg) |
| G2  | ![G2](/tutorial/flat/_build/G2.svg) |
| G3  | ![G3](/tutorial/flat/_build/G3.svg)|
| G4  | ![G4](/tutorial/flat/_build/G4.svg) |
| SH4 | ![SH4](/tutorial/flat/_build/SH4.svg)|

And all graphs are computed by the previous command before producing the normal form.
There are (n-1)! such graphs for `Cn`.

So, what can we do to avoid this huge and useless computation?

### Solution 1: compute only one normal form
The rule `c2sh` is called a **confluent** rule.
This means that they will always be exactly one normal form when the rule is iterated.
If we know that the rule is confluent, we can ask **Grew** to compute only one normal form with the strategy `Onf (c2sh)`:

`grew transform -grs rules.grs -strat "Onf (c2sh)" -i C6.conll -o SH6_auto.conll`

For instance, on `G10`, the `Iter` strategy takes 25s to compute the normal form and the `Onf` takes 4ms.

### Solution 2: write a stricter rule
As before, we can add a `without` clause to force the application order of command:

```grew
rule c2sh_strict {
  pattern {
    H -[fixed]-> N1;
    e: N1 -[fixed]-> N2;
  }
  without {
    * -[fixed]-> H;
  }
  commands {
    del_edge e;
    add_edge H -[fixed]-> N2;
  }
}
```

At each step, we ensure that the node `H` of the pattern is matched to the word `head` of the graph.

