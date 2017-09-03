+++
Description = ""
date = "2017-05-23T15:18:57+02:00"
title = "Rules"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]

+++

# Grew basic rules

A **rewrite rule** in grew is defined by:

  * One pattern describing the part of graph we want to match (see [pattern page](../pattern)) and on which we will apply rules, introduced by the keyword `pattern`
  * A set of negative clauses to filter out unwanted occurrences of the pattern, each clause being introduced by the keyword `without`
  * One sequence of commands to apply (see [commands page](../commands)), introduced by the keyword `commands`

## example
~~~grew
rule accuser {
  pattern {
    V [cat=V, lemma="accuser"];
    O [];
    D [cat=D, lemma="de"];
    DO [cat=V, m = inf | part];

    V -[obj]-> O;
    V -[de_obj]-> D;
    D -[obj]-> DO
    }
  without {
    DO -[suj]-> O
  }
  commands {
    add_edge DO -[suj]-> O
  }
}
~~~

# Grew lexical rules

Grew rules can be parametrized by one or several lexicons.

A lexicon is defined by:

  * a list in n different identifiers
  * a list of lexicon items, each item is a n-tuple

A lexicon can be declared in a external file.
The syntax below declares a lexicon called `lex` for the rule `rule_name`.
~~~grew
rule rule_name (lex from "file.lex") {…}
~~~

The file `file.lex` follows the syntax:
~~~
phon	new_phon
p1	r1
p2	r2
p3	r3
~~~
where each line is a list of elements separated by tabulations.
The first line defines the parameters identifiers.
All other lines define the lexicon items that are n-tuples of strings.
Hence, all lines are supposed to contain the same number of elements.

The same lexicon `lex` can also be defined directly at the end of the rule definition with the syntax:
~~~grew
rule rule_name {…}
##BEGIN lex
phon	new_phon
p1	r1
p2	r2
p3	r3
##END
~~~

Once the lexicon `lex` is declared, the syntax `lex#ident` can be used to refer to lexical items in every place where a feature value can be used in the rule definition.


The same lexicon can refer to several files and several final declaration.
In such a case, only identifiers that are declared in all lexicons are taken into account
