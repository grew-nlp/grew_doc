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
Since Grew version 1.8.2 (April 2022), the clustering is available [:link:](./#with-clustering) in the grep mode.

## Without clustering

The command is:

`grew grep -pattern <pattern_file> -i <corpus_file>`

where:

  * `<pattern_file>` is a file which describes a pattern
  * `<corpus_file>` is the corpus in which the search is done

The output is given in JSON format.

### Example

With the following files:

 * The corpus `UD_French-PUD` version 2.9: `fr_pud-ud-test.conllu`[:link:](https://github.com/UniversalDependencies/UD_French-PUD/blob/r2.8/fr_pud-ud-test.conllu?raw=true)
 * A pattern file with the code below: `rouge.pat`[:link:](/usage/cli/rouge.pat)

{{< grew file="static/usage/cli/rouge.pat" >}}

**NB**: the fact the edge from `M` to `N` is given an identifier `e` will give the information about this edge in the output (see below).

The command:

```
grew grep -pattern rouge.pat -i fr_pud-ud-test.conllu
```

produces the following JSON output:

{{< json file="static/usage/cli/_build/output_grep" >}}

This means that the pattern described in the file `rouge.pat` was found three times in the corpus, each item gives the sentence identifier and the position of the nodes and the edges matched by the pattern.

Note that two other options exist:

 * `-html`: produces a new `html` field in each JSON item with the sentence where words impacted by the pattern are in a special HTML span with class `highlight`
 * `-dep_dir <directory>`: produces a new file in the folder `directory` with the representation of the sentence with highlighted part (as in [Grew-match](http://match.grew.fr) tool) and a new field in each JSON item with the filename; the output is in `dep` format (usable with [Dep2pict](http://dep2pict.loria.fr)).


## With clustering

If the command line contains one of the two arguments `-key` or `-whether`, this mode is chosen.

### Examples

With the same files as in the *without clustering* part.

With `-key`, we can cluster the results according to the gender of the node `N` (the adjective) and observe that *rouge* is used twice with `Masc` gender and once with `Fem`.

```
grew grep -pattern rouge.pat -key N.Gender -i fr_pud-ud-test.conllu
```

{{< json file="static/usage/cli/_build/output_grep_key" >}}

With `-whether`, we can cluster the results according to the relative position of the node `N` (the adjective) and its governor.
We observe that in the three cases, the governor `M` is always before `N`.

```
grew grep -pattern rouge.pat -whether "M << N" -i fr_pud-ud-test.conllu
```

{{< json file="static/usage/cli/_build/output_grep_whether" >}}

---
# Compile

For the Grew-match server (`grew_daemon`) or for the command `grew count`, it is required to first compile corpora.
For these two usages, sets of corpora are described in a [JSON file](../../doc/corpora).

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

This mode computes corpus statistics.
There are two ways to used it:

 * Given a set of patterns and a set of corpora, a TSV table is built with the number of occurrences for each pattern in each corpus.
 * Given one pattern, a set of corpora and a cluster key, a TSV table is built with the results of the clustering (with corpora on lines and cluster keys in raws).

The set of corpora is described in a [JSON file](../../doc/corpora) and must be [compiled](./#compile) before running `grew count`.


## Example with several patterns 
Each pattern is described in a separate file.
With the two following 1-line files:

 * `ADJ_NOUN_pre.pat` [:link:](/usage/cli/ADJ_NOUN_pre.pat) {{< input file="static/usage/cli/ADJ_NOUN_pre.pat" >}}
 * `ADJ_NOUN_post.pat` [:link:](/usage/cli/ADJ_NOUN_post.pat) {{< input file="static/usage/cli/ADJ_NOUN_post.pat" >}}

and the example file `en_fr_zh.json` [:link:](/usage/cli/en_fr_zh.json)
{{< input file="static/usage/cli/en_fr_zh.json" >}}

1. Compile the corpora: `grew compile -i en_fr_zh.json`
1. Build stat table: `grew count -patterns "ADJ_NOUN_pre.pat ADJ_NOUN_post.pat" -i en_fr_zh.json`

The output is given as TSV data:

{{< input file="static/usage/cli/_build/output_count" >}}

which corresponds to the table:

| Corpus | # sentences | ADJ_NOUN | NOUN_ADJ |
|------------|-------------|----------|----|
| UD_English-PUD | 1000 | 1114 | 12 |
| UD_French-PUD | 1000 | 423 | 935 |
| UD_Chinese-PUD | 1000 | 364 | 0 |

We can then observe that in the annotations of the 3 corpora in use:

 * in English, there is a strong preference for adjective position before the noun (98.9%)
 * in French, there is a weak preference for adjective position after the noun (68.9%)
 * in Chinese, there is a **very** strong preference for adjective position before the noun (100%)

## Example with a clustering of the output

:warning: available only with *Grew* version 1.8.2 or greater.

With the same data as in the previous example, the following command:

`grew count -pattern ADJ_NOUN_pre.pat -key N.Number -i en_fr_zh.json`

produces the TSV file:

{{< input file="static/usage/cli/_build/output_count_key" >}}

which corresponds to the table:

| Corpus | Plur | Sing | undefined |
|------------|-------------|----------|----|
| UD_English-PUD | 392 | 722 | 0 |
| UD_French-PUD | 178 | 245 | 0 |
| UD_Chinese-PUD | 0 | 0 | 364 |

Using a whether clustering, with the pattern `ADJ_NOUN.pat` [:link:](/usage/cli/ADJ_NOUN.pat) 
{{< input file="static/usage/cli/ADJ_NOUN.pat" >}}

and the command: `grew count -pattern ADJ_NOUN.pat -whether "A << N" -i en_fr_zh.json`

we obtain the TSV file:

{{< input file="static/usage/cli/_build/output_count_whether" >}}

which corresponds to the table:

| Corpus | No | Yes |
|------------|-------------|----------|
| UD_English-PUD | 12 | 1114 |
| UD_French-PUD | 935 | 423 |
| UD_Chinese-PUD | 0 | 364 |





## Remarks

 * In the case without clustering, the TSV table also contains a column with the size of corpora (in number of sentences), this can be useful to make cross-corpora analysis and to compute ratios instead of raw numbers.
 * Only one pattern is used in case of clustering.
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

