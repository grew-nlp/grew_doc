+++
Description = ""
date = "2017-02-28T14:58:11+01:00"
title = "run"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
+++

# Running Grew

**Grew** can be used from Python. See [Tutorial page](../tuto) for basic usage from Python.
The remaining of this page presents the command line program.


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

In this mode, **Grew** apply a Graph Rewriting System to a graph or a set of graphs.

The full command for this mode:

`grew transform [<args>]`

All arguments are optional:

 * `-grs <grs_file>`: the main file which describes Graph Rewriting System.
 If no GRS is given an empty GRS is loaded: `strat main {Seq ()}`
 * `-i <input_file>`: describes the input data (CoNLL file of gr file).
 If no input file is given, Grew reads from `stdin`
 * `-o <output_file>`: is the name of the output file (CoNLL file).
  If no output file is given, Grew writes to `stdout`
 * `-strat <name>`: the strategy used in transformation (default value: `main`)
 * `-safe_commands`: make rewriting process fail in case of [ineffective command](../commands/#effective-commands)

---

# GTK interface

The command to run the GTK interface: `grew gui [<args>]`.
It supposes that you have installed the `grew_gui` opam packages (see [GUI installation page](../gtk)).

Optional arguments:

 * `-grs <grs_file>`: load the given file
 * `-i <input_file>`: input data (graph or corpus) loaded in GUI
 * `-strat <name>`: the strategy selected in the interface (default: `main`)
 * `-main_feat <feat_name_list>` set the list of feature names used ad the *main* feat in graph visualization

---
# Grep mode

This mode corresponds to the command line version of the [Grew-match](http://match.grew.fr) tool.
The command is:

`grew grep -pattern <pattern_file> -i <corpus_file>`

where:

  * `<pattern_file>` is a file which describes a pattern
  * `<corpus_file>` is the corpus in which the search is done

The output is given in JSON format.

:warning: The output of the `grep` mode has changed in version 1.3 (June 2019)

## Example

With the following files:

 * The surface sequoia version 9.0: `sequoia.surf.conll` ([Download](https://gitlab.inria.fr/sequoia/deep-sequoia/raw/master/tags/sequoia-9.0/sequoia.surf.conll)),
 * A pattern file with the code below: `subcat.pat` ([Download](https://gitlab.inria.fr/grew/grew_doc/raw/master/static/examples/grep/subcat.pat))

```
pattern {
  V [cat=V];
  V -[a_obj]-> A;
  V -[de_obj]-> DE;
}
```

The command:

`grew grep -pattern subcat.pat -i sequoia.surf.conll`

produces the following JSON output:

```json
[
  {
    "sent_id": "Europar.550_00496",
    "matching": { "V": "16", "DE": "19", "A": "14" }
  },
  {
    "sent_id": "emea-fr-test_00478",
    "matching": { "V": "33", "DE": "32", "A": "35" }
  },
  {
    "sent_id": "emea-fr-test_00438",
    "matching": { "V": "20", "DE": "21", "A": "22" }
  },
  {
    "sent_id": "annodis.er_00441",
    "matching": { "V": "16", "DE": "20", "A": "18" }
  },
  {
    "sent_id": "annodis.er_00240",
    "matching": { "V": "12", "DE": "13", "A": "11" }
  },
  {
    "sent_id": "annodis.er_00040",
    "matching": { "V": "42", "DE": "50", "A": "47" }
  }
]
```

This means that the pattern described in the file `subcat.pat` was found 6 times in the corpus, each item gives the sentence identifier and the position of nodes matched by the pattern.

Note that two other options exist (`-html` and `-dep_dir <directory>`).
The first one produces a new `html` field in each JSON item with the sentence where words impacted by the pattern are in a special HTML span with class `highlight`.
The second one produces a new file in the folder `directory` with the representation of the sentence with highlighted part (as in [Grew-match](http://match.grew.fr) tool) and a new field in each JSON item with the filename; the output is in `dep` format (usable with [Dep2pict](http://dep2pict.loria.fr)).
