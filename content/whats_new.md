+++
date = "2017-05-23T16:44:27+02:00"
title = "What's new"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
menu = "main"

+++

# Grew releases

* The version numbers `x.y.z` are synchronised such that `x` and `y` are identical for sub-projects.
The third component `z` is linked to bug fixes and may vary across sub-projects.
  * `libcaml-grew` &rarr; the Grew library, used in all other sub-projects
  * `grew` &rarr; the command line interface of Grew
  * `grew_daemon` &rarr; the server daemon behing [Grew-match](http://match.grew.fr)
  * `grewpy` &rarr; the daemon called by Python library

* The symbol "⚠️" indicates changes that may break backward compatibility. Check [GRS upgrading](../../doc/upgrade).


* More detailled information in files `CHANGES.md` for each sub-project:
[libcaml-grew](https://gitlab.inria.fr/grew/libcaml-grew/blob/master/CHANGES.md),
[grew](https://gitlab.inria.fr/grew/grew/blob/master/CHANGES.md).

---
---

# :new: Version 1.6 (May 5, 2021)
  * ⚠️ stop backward compatibility with old feature names `pos`, `cat` and `phon`  (see [CoNNL-U](../../doc/conllu#note-about-conll-feature-values))
  * add `-columns` argument (see [CoNNL-U Plus](../../doc/conllup#columns-declaration))
  * fix invalid json output if there is more than one output graph

---

# Version 1.5 (March 16, 2021)
  * Change JSON encoding of graphs (see [JSON format](../../doc/json))

---

# Version 1.4 (October 2, 2020)
  * change pattern syntax (see [GRS upgrading](../../doc/upgrade))
  * add new syntax for constraints in pattern syntax (see [patterns page](../../doc/pattern#additional-constraints))
  * new implementation of Conll-U handling
  * configs replace the deprecated notion of domains

:warning: the tool `grew_gui` is obsolete and not maintained. It relies on old libraries which are not available on recent version of OSes.

---

# Version 1.3 (June 24, 2019)
  * Add support of "@alpha" extension in edges
  * Add a default “empty.grs”
  * Read from `stdin` if there is no `-i`, write to `stdout` if there is no `-o`

---

# Version 1.2 (March 26, 2019)
  * Edge label can be viewed as feature structure "x:y" <=> "1=x, 2=y"
  * Add `global` section in pattern (is_projective, is_cyclic, is_tree, is_forest)
  * Add `?get_url` parameter to `Graph.to_dot` (AMR handling in Grew-match)
  * Add a notion of pivot node in pattern for Grew-match export
  * Add `Libgrew.set_track_rules` function


---

# Version 1.1 (November 23, 2018)
  * More general definition of pattern edges (String are available everywhere)
  * Update to new MWE types (with projection information)

---

# Version 1.0 (September 10, 2018)
  * :warning: Change lexical rules syntax and lexicon representation (See [About new lexical rules syntax](../doc/upgrade_old#new-lexical-rules-syntax))
  * Handling of Parseme's column 11
  * Large code cleaning
  * Fix [#4](https://gitlab.inria.fr/grew/grew/issues/4) & [#5](https://gitlab.inria.fr/grew/grew/issues/5)

---

# Version 0.48 (June 19, 2018)
 * remove `conll_fields` mechanism (names of conll fields 2, 4 and 5 are `form`, `upos`, `xpos`). See [here](../doc/conll#note-about-backward-compatibility) for more information.

---

# Version 0.47 (March 13, 2018)
 * Add `grewpy` executable for Python library
 * `-safe_commands` option


---

# Version 0.46 (December 14, 2017)

 * GTK interface is proposed as a separate package and so **Grew** without GUI is much more easy to install
 * Command line arguments were revisited (see [here](../usage/cli))

More detailled information in files `CHANGES.md` for each sub-project: [libcaml-grew](https://gitlab.inria.fr/grew/libcaml-grew/blob/master/CHANGES.md),
[grew](https://gitlab.inria.fr/grew/grew/blob/master/CHANGES.md),
[grew_gui](https://gitlab.inria.fr/grew/grew_gui/blob/master/CHANGES.md)

---

# Version 0.45 (October 10, 2017)

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

# Version 0.44 (September 05, 2017)
  * :warning: new grs syntax (with package and strategies), see [grs](../doc/grs).


---

# Version 0.43 (May 23, 2017)


## Syntax changes
The syntax changes below make existing **Grew** code to be deprecated.
The old syntax is still accepted but for a limited amount of time, please update your existing GRS system soon.

  * :warning: the keyword `confluent` is replaced by the keyword `deterministic` (it was confusing to use the keyword "`confluent`"  with modules which are not confluent).
  * :warning: the keyword `match` is replaced by the keyword `pattern`.

## Command actions
  * :warning: the shift command semantics: edges with source and target nodes in the pattern are not concerned by the shifts
  * New syntax is available for the command `add_edge` (issue [#2](https://gitlab.inria.fr/grew/libcaml-grew/issues/2)).

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