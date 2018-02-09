+++
Description = ""
date = "2017-02-28T14:58:11+01:00"
title = "run"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
+++

The command to run **Grew** is: `grew <subcommand> [<args>]`

Available subcommands are:

  * `transform`: **Grew** transform mode, see below
  * `gui`: **Grew** GTK interface, see below
  * `grep`: **Grew** grep mode, see below
  * `version`:    Print current version number
  * `help`: Print help
  * `help <sub>`:  Print help for the given subcommand

---

# Transform mode

In this mode, **Grew** apply a Graph Rewrinting System to a graph of a set of graphs.

The full command for this mode:

`grew transform -grs <grs_file> -i <input_file> -o <output_file>`

Required arguments for this mode are:

where:

 * `<grs_file>` is the main file which describes Graph Rewriting System
 * `<input_file>`: describes the input data (CoNLL file of gr file)
 * `<output_file>`: is the name of the output file (CoNLL file)

Optional argument is:

 * `-strat <name>`: the strategy used in transformation (default value: `main`)

---

# GTK interface

The command to run the GTK interface: `grew gui <args>`.
It supposes that you have installed the `grew_gui` opam packages (see [option 2 in Installation page](../installation#option-2-installation-of-the-gtk-interface)).

Optional arguments:

 * `-grs <grs_file>`: load the given file
 * `-i <input_file>`: input data (graph or corpus) loaded in GUI
 * `-strat <name>`: the strategy selected in the interface (default: `main`)
 * `-main_feat <feat_name_list>` set the list of feature names used ad the *main* feat in graph visualisation

---
# Grep mode

This mode corresponds to the command line version of the [Online graph matching](http://match.grew.fr) tool.
The command is:

`grew grep -pattern <pattern_file> -node_id <id> -i <corpus_file>`

where:

  * `<pattern_file>` is a file which describes a pattern
  * `<id>` is the name of a node identifier declared in the pattern
  * `<corpus_file>` is the corpus in which the search is done

The output is a list of lines, one for each occurrence of the pattern in the corpus.

## Example

With the following files:

 * The surface sequoia version 7.0: `sequoia.surf.conll` ([Download](https://gitlab.inria.fr/sequoia/deep-sequoia/raw/master/tags/sequoia-7.0/sequoia.surf.conll)),
 * A pattern file with the code below: `subcat.pat` ([Download](https://gitlab.inria.fr/grew/grew_doc/raw/master/static/examples/grep/subcat.pat))

```
pattern {
  V [cat=V];
  V -[a_obj]-> A;
  V -[de_obj]-> DE;
}
```

The command:

`grew grep -pattern subcat.pat -node_id V -i sequoia.surf.conll`

produces the following output:

```
annodis.er_00040	41
annodis.er_00240	12
annodis.er_00441	14
emea-fr-test_00438	19
emea-fr-test_00478	31
Europar.550_00496	14
```

This means that the pattern described in the file `subcat.pat` was found 6 times in the corpus, each line gives the sentence identifier and the position of node matched by the node `V` of the pattern.
