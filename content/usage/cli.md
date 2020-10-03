+++
Description = ""
date = "2017-02-28T14:58:11+01:00"
title = "cli"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
+++

# Grew • Command Line Interface

The command to run **Grew** is: `grew <subcommand> [<args>]`

Main subcommands are:

  * [:link:](./#transform) `transform`: application of a rewriting system to a set of graphs
  * [:link:](./#grep)`grep`: search for a pattern in a corpus
  * [:link:](./#compile) `compile`: compile a set of corpora
  * [:link:](./#clean)`clean`: clean a set of corpora
  * [:link:](./#count) `count`: compute stats of a set of patterns in a set of corpora)

  * OBSOLETE [:link:](./#gui) `gui`: run the GTK interface


Other subcommands:

  * `version`: Print version numbers of the **Grew** Ocaml library and of the **Grew** tool
  * `help`: Print general help
  * `help <subcommand>`:  Print help for the given subcommand

---

# Transform

In this mode, **Grew** apply a Graph Rewriting System to a graph or a set of graphs.

The full command for this mode:

`grew transform [<args>]`

All arguments are optional:

 * `-grs <grs_file>`: the main file which describes the Graph Rewriting System. If no GRS is given, the empty GRS is loaded: `strat main {Seq ()}`
 * `-i <input_file>`: describes the input data (CoNLL file of gr file).
 If no input file is given, **Grew** reads from `stdin`
 * `-o <output_file>`: is the name of the output file (CoNLL file). If no output file is given, **Grew** writes to `stdout`
 * `-strat <name>`: the strategy used in transformation (default value: `main`)
 * `-safe_commands`: flag. It makes rewriting process fail in case of [ineffective command](../../doc/commands/#effective-commands)

---
# Grep

This mode corresponds to the command line version of the [Grew-match](http://match.grew.fr) tool.
The command is:

`grew grep -pattern <pattern_file> -i <corpus_file>`

where:

  * `<pattern_file>` is a file which describes a pattern
  * `<corpus_file>` is the corpus in which the search is done

The output is given in JSON format.

## Example

With the following files:

 * The `dev` part of the corpus `UD_French-GSD` version 2.6: `fr_gsd-ud-dev.conllu`[:link:](https://github.com/UniversalDependencies/UD_French-GSD/blob/r2.6/fr_gsd-ud-dev.conllu?raw=true)
 * A pattern file with the code below: `bleu.pat`[:link:](/usage/cli/bleu.pat) {{< input file="static/usage/cli/bleu.pat" >}}

The command:

`grew grep -pattern bleu.pat -i fr_gsd-ud-dev.conllu`

produces the following JSON output:

{{< input file="static/usage/cli/output_grep" >}}

This means that the pattern described in the file `bleu.pat` was found twice in the corpus, each item gives the sentence identifier and the position of nodes and edges matched by the pattern.

Note that two other options exist:

 * `-html`: produces a new `html` field in each JSON item with the sentence where words impacted by the pattern are in a special HTML span with class `highlight`
 * `-dep_dir <directory>`: produces a new file in the folder `directory` with the representation of the sentence with highlighted part (as in [Grew-match](http://match.grew.fr) tool) and a new field in each JSON item with the filename; the output is in `dep` format (usable with [Dep2pict](http://dep2pict.loria.fr)).

---
# Compile

For the Grew-match server (`grew_daemon`) or for the command `grew count`, it is required to first compile corpora.
For these two usage, sets of corpora are described in a [JSON file](../../doc/corpora).

For compilation, the command is:

`grew compile -i <corpora.json>`

Note that this produces, for each corpus, a new file with the `marshal` extension stored in the corpus directory.
The `marshal` is computed only if the corpus has changed since the last compilation.

---
# Clean

The commands below removes the `marshal` files produced by the `grew compile` command for the set of corpora described in the [JSON file](../../doc/corpora) `corpora.json`.

`grew clean -i <corpora.json>`

---
# Count

This mode computes corpus statistics. Given a set of patterns and a set of corpora, a TSV table is built with the number of occurrences for each pattern in each corpus.

The set of corpora is described in a [JSON file](../../doc/corpora) and must be [compiled](./#compile) before running `grew count`.

Each pattern is described in a separate file.

## Example
With the two following 1-line files:

 * `ADJ_NOUN.pat` [:link:](/usage/cli/ADJ_NOUN.pat) {{< input file="static/usage/cli/ADJ_NOUN.pat" >}}
 * `NOUN_ADJ.pat` [:link:](/usage/cli/NOUN_ADJ.pat) {{< input file="static/usage/cli/NOUN_ADJ.pat" >}}

and the example file `en_fr_zh.json` [:link:](/doc/corpora/en_fr_zh.json)
{{< input file="static/doc/corpora/en_fr_zh.json" >}}

1. Compile the corpora: `grew compile -i en_fr_zh.json`
1. Build stat table: `grew count -patterns "ADJ_NOUN.pat NOUN_ADJ.pat" -i en_fr_zh.json`

The output is given as TSV data:

{{< input file="static/usage/cli/output_count" >}}

which corresponds to the table:

| Corpus | # sentences | ADJ_NOUN | NOUN_ADJ |
|------------|-------------|----------|----|
| UD_English-EWT | 16622 | 9835 | 163 |
| UD_French-Sequoia | 3099 | 891 | 2779 |
| UD_Chinese-GSD | 4997 | 1505 | 0 |

We can then observe that in the annotations of the 3 corpora in use:

 * in English, there is a strong preference for adjective position before the noun (98.4%)
 * in French, there is a weak preference for adjective position after the noun (75,7%)
 * in Chinese, there is a **very** strong preference for adjective position before the noun (100%)

## Remarks

 * The TSV table also contains a column with the size of corpora (in number of sentences), this can be useful to make cross-corpora analysis and to compute ratios instead of raw numbers.
 * Pattern syntax can be learned [here](/doc/pattern/) or with the online **[Grew-match](http://match.grew.fr)** tool, first with the [tutorial](http://match.grew.fr?tutorial=yes) and then with snippets given on the right of the text area.
 * If some corpus is updated, it is necessary to run again the compilation step.
 * Some patterns may take a long time to be searched in corpora.

---
---

# GUI (Obsolete)

The command to run the GTK interface: `grew gui [<args>]`.
It supposes that you have installed the `grew_gui` opam package (see [GUI installation page](../install_gtk)).

Optional arguments:

 * `-grs <grs_file>`: load the given file
 * `-i <input_file>`: input data (graph or corpus) loaded in GUI
 * `-strat <name>`: the strategy selected in the interface (default: `main`)
 * `-main_feat <feat_name_list>` set the list of feature names used ad the *main* feat in graph visualization

