+++
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
date = "2018-07-11T10:17:31+02:00"
title = "lexicons_change"
Description = ""

+++

# About new lexical rules syntax

:warning: In version 1.0 (September 2018), the syntax of lexical rules has changed.
The difference between the two syntaxes is explained here.

The differences between old syntax and new syntax are:

 * In new syntax, each lexicon is given a name (below: `transitive_lexicon`).
 * Names of lexicon fields (below: `lemma` and `is_trans`) are declared in the first line of the lexicon (the fields were declarated after the rule name in old syntax).
 * Fields in the lexicon are separated by a tabulation character instead of the `#` symbol.
 * Reference to lexicon inside the rule uses the syntax `lexicon_name.lexicon_field` instead of `$lexicon_field` or `@lexicon_field`.

We describe below through examples, the correspondence between old and new syntax.

## Using a lexicon in the same file
For short lexicons, it is easier to put the lexicon next to the rule.
Lexical items are described one by line between the two special markers `#BEGIN` and `#END`.
In the new syntax, the name of the lexicon is given on the line with the `#BEGIN` marker.

### Old syntax
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

### New syntax
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

## Using a lexicon declared in an external file
If the lexicon contains a large number of items, it can be declared in an external file.
External declaration is also useful for referring to the same lexicon in several different rules.
With external declaration, the name of the lexicon is declared after the rule name with the keyword `from` in the syntax: `(lexicon_name from "lexicon_file")`.

### Old syntax

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


### New syntax
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
