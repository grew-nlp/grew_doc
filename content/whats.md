+++
date = "2017-05-23T16:44:27+02:00"
title = "What's new"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""
menu = "main"

+++

# Last release: version 0.43 on May 23, 2017

The symbol ":warning:" indicates changes that may break backward compatibility.

## Syntax changes
The syntax changes below make existing Grew code to be deprecated.
The old syntax is still accepted but for a limited amount of time, please update your existing GRS system soon.

  * :warning: the keyword `confluent` is replaced by the keyword `deterministic` (it was confusing to use the keyword "`confluent`"  with modules which are not confluent).
  * :warning: the keyword `match` is replaced by the keyword `pattern`.

## Command actions
  * :warning: the shift command semantics: edges with source and target nodes in the pattern are not concerned by the shifts
  * a new syntax is available for the command `add_edge` [#2](https://gitlab.inria.fr/grew/libcaml-grew/issues/2). See [command documentation](../commands#add-a-new-edge-with-a-label-taken-in-the-pattern).

## Removed old stuff
  * :warning: old syntax for node addition is no longer supported:

~~~grew
add_node PRO: <-[obj.p]- PREP;
~~~

must be replaced by the sequence of two commands:

~~~grew
add_node PRO :> PREP;
add_edge PREP -[obj.p]-> PRO;
~~~