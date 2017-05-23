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

TODO
