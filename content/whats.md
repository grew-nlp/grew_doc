+++
date = "2017-05-23T16:44:27+02:00"
title = "What's new"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""
menu = "main"

+++

* The version numbers `x.y.z` are synchronized such that `x` and `y` are identical for the 3 main sub-projects (`grew`, `grew_gui`, `libcaml-grew`). The third component `z` is linked to bug fixes and may vary across the 3 sub-projects.
* The symbol ":warning:" indicates changes that may break backward compatibility.

More detailled informations in files `CHANGES.md` for each sub-project:
[libcaml-grew](https://gitlab.inria.fr/grew/libcaml-grew/blob/master/CHANGES.md),
[grew](https://gitlab.inria.fr/grew/grew/blob/master/CHANGES.md),
[grew_gui](https://gitlab.inria.fr/grew/grew_gui/blob/master/CHANGES.md)

---

# [**last release**] Version 1.0 on September 10, 2018
  * :warning: Change lexical rules syntax and lexicon representation (See [About new lexical rules syntax](../lexicons_change))
  * Handling of Parseme's column 11
  * Large code cleaning
  * Fix [#4](https://gitlab.inria.fr/grew/grew/issues/4)
  * Fix [#5](https://gitlab.inria.fr/grew/grew/issues/5)

---

# Version 0.48 on June 19, 2018
 * remove `conll_fields` mechanism (names of conll fields 2, 4 and 5 are `form`, `upos`, `xpos`). See [here](../features#note-about-backward-compatibility) for more information.

---

# Version 0.47 on March 13, 2018
 * Add `grewpy` executable for Python library
 * `-safe_commands` option


---

# Version 0.46 on December 14, 2017

 * GTK interface is proposed as a separate package and so **Grew** without GUI is much more easy to install
 * Command line arguments were revisited (see [Run Grew page](../run))

More detailled informations in files `CHANGES.md` for each sub-project: [libcaml-grew](https://gitlab.inria.fr/grew/libcaml-grew/blob/master/CHANGES.md),
[grew](https://gitlab.inria.fr/grew/grew/blob/master/CHANGES.md),
[grew_gui](https://gitlab.inria.fr/grew/grew_gui/blob/master/CHANGES.md)

---

# Version 0.45 on October 10, 2017

  * features structures given in column 10 of CoNLL are kept in the output
  * :warning: new grs syntax ([grs](../grs)) is required; old syntax can be used with the command line argument `-old_grs`
  * :warning: in patterns, implicit node declaration is available only for nodes in edge (see below)

### Implicit nodes in version 0.45
In pattern, you can refer only to nodes which are explicitely declared or declared in a edge declaration.
The following patterns used to be valid (with a implicit declaration of node `M`), but there are not anymore

```grew
pattern { N[cat=NOUN]; M < N }
pattern { N[cat=NOUN]; M.cat = VERB }
pattern { N[cat=NOUN]; M -[obj]-> * }
```

They have to be replaced by, respectively:
```grew
pattern { N[cat=NOUN]; M[]; M < N }
pattern { N[cat=NOUN]; M[]; M.cat = VERB }
pattern { N[cat=NOUN]; M[]; M -[obj]-> * }
```

But it is still possible to write
```grew
pattern { N[cat=NOUN]; N -[obj]-> M }
```


---

# Version 0.44 on September 05, 2017
  * :warning: new grs syntax (with package and strategies), see [grs](../grs).

# Vversion 0.43 on May 23, 2017


## Syntax changes
The syntax changes below make existing **Grew** code to be deprecated.
The old syntax is still accepted but for a limited amount of time, please update your existing GRS system soon.

  * :warning: the keyword `confluent` is replaced by the keyword `deterministic` (it was confusing to use the keyword "`confluent`"  with modules which are not confluent).
  * :warning: the keyword `match` is replaced by the keyword `pattern`.

## Command actions
  * :warning: the shift command semantics: edges with source and target nodes in the pattern are not concerned by the shifts
  * a new syntax is available for the command `add_edge` (issue [#2](https://gitlab.inria.fr/grew/libcaml-grew/issues/2)). See [command documentation](../commands#add-a-new-edge-with-a-label-taken-in-the-pattern).

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