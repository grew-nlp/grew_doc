+++
date = "2020-05-09T17:49:29+02:00"
title = "upgrade"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""

+++

# GRS upgrading

This page describes the breaking changes in **Grew** and provides the information needed to upgrade a Graph Rewriting System.

---

# 1.3 to 1.4 (September 2020)


## Access to the label of an edge in the pattern

|Constraint | Old syntax | New syntax |
|:-----------------:|:-----------------:|:-----------------:|
| equality of two edge labels | `label(e1) = label(e2)` |  `e1.label = e2.label` |
| inequality of two edge labels | `label(e1) <> label(e2)` |  `e1.label <> e2.label` |

## Avoid duplicate solutions

When several nodes are equivalent in a pattern, each occurrence is reported several times (up to permutation on the set of equivalent nodes).
For instance, to search for two relations `det` with the same governor, the pattern below will return twice each solution.

```grew
pattern {
  G -[det]-> D1;
  G -[det]-> D2;
}
```

To avoid this, it is possible to give an ordering constraint on some internal identifier:

 * old_syntax: `id(D1) < id (D2)`
 * new_syntax: `D1.__id__ < D2.__id__`

The complete pattern in new syntax:

```grew
pattern {
  G -[det]-> D1;
  G -[det]-> D2;
  D1.__id__ < D2.__id__;
}
```

## Add a new edge with a label taken in the pattern

In previous version, the syntax `add_edge e: N -> M` was used for adding a new edge between `N` and `M` with a label identical to the edge named `e` in the pattern.

In the 1.4 version, the semantic of the same syntax has changes.
Now, the syntax `add_edge e: N -> M` means add a new edge between `N` and `M` and give it the **fresh** name `e`.

In order to have the same semantic as the previous version, the command:

```grew
add_edge e: N -> M;      # e being an edge declared in the pattern
```

must be replaced by:

```grew
add_edge f: N -> M;      # f is a fresh name
f.label = e.label;       # the label of f is set to be equal to the one of e.
```

Fortunately, this should not produce unexpected behaviour:

 * If the old syntax is used with the new **Grew** version,
 * If the new syntax is used with the old **Grew** version, the error ` Unknwon identifier "f"` is reported.






---

# 0.49 to 1.0 (September 2018)

## New lexical rules syntax

The differences between old syntax and new syntax are:

 * In new syntax, each lexicon is given a name (below: `transitive_lexicon`).
 * Names of lexicon fields (below: `lemma` and `is_trans`) are declared in the first line of the lexicon (the fields were declared after the rule name in old syntax).
 * Fields in the lexicon are separated by a tabulation character instead of the `#` symbol.
 * Reference to lexicon inside the rule uses the syntax `lexicon_name.lexicon_field` instead of `$lexicon_field` or `@lexicon_field`.

We describe below through examples, the correspondence between old and new syntax.

### Using a lexicon in the same file
For short lexicons, it is easier to put the lexicon next to the rule.
Lexical items are described one by line between the two special markers `#BEGIN` and `#END`.
In the new syntax, the name of the lexicon is given on the line with the `#BEGIN` marker.

#### Old syntax
```grew
rule update_trans (feature $lemma, $is_trans) {
  pattern { N [lemma = $lemma, !trans] }
  commands { N.trans = $is_trans}
}
#BEGIN
dormir#no
manger#yes
vendre#yes
#END
```

#### New syntax
```grew
rule update_trans {
  pattern { N [lemma = transitive_lexicon.lemma, !trans] }
  commands { N.trans = transitive_lexicon.is_trans }
}
#BEGIN transitive_lexicon
lemma	is_trans
%---------------
dormir	no
manger	yes
vendre	yes
#END
```

NB: the line `%---------------` is not required, lines beginning with `%` are considered as comments and are discarded.

### Using a lexicon declared in an external file
If the lexicon contains a large number of items, it can be declared in an external file.
External declaration is also useful for referring to the same lexicon in several different rules.
With external declaration, the name of the lexicon is declared after the rule name with the keyword `from` in the syntax: `(lexicon_name from "lexicon_file")`.

#### Old syntax

Rule:
```grew
rule update_trans (feature $lemma, $is_trans; file "path_to_the_file/trans.lex") {
  pattern { N [lemma = $lemma, !trans] }
  commands { N.trans = $is_trans }
}
```

Lexicon file `trans.lex`:
```
dormir#no
manger#yes
vendre#yes
```


#### New syntax
```grew
rule update_trans (transitive_lexicon from "path_to_the_file/trans.lex") {
  pattern { N [lemma = transitive_lexicon.lemma, !trans] }
  commands { N.trans = transitive_lexicon.is_trans}
}
```

Lexicon file `trans.lex`:
```
lemma	is_trans
%---------------
dormir	no
manger	yes
vendre	yes
```
