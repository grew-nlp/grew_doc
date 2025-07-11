+++
Description = ""
date = "2017-02-28T14:58:11+01:00"
title = "cli"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
+++

# Grew • Command Line Interface

The command used to run **Grew** is: `grew <subcommand> [<args>]`

The 5 main subcommands are:

  * [:link:](./#transform) `transform`: application of a rewriting system to a set of graphs
  * [:link:](./#grep)`grep`: search for a request in a corpus
  * [:link:](./#count) `count`: compute stats of a set of requests in a set of corpora
  * [:link:](./#compile) `compile`: compile a set of corpora
  * [:link:](./#clean)`clean`: clean a set of corpora

Other subcommands:

  * `version`: Print version numbers of the **Grew** Ocaml library and of the **Grew** tool
  * `help`: Print general help
  * `help <subcommand>`:  Print help for the given subcommand

There are two modes of input data: **Mono** corpus or **Multi** corpora. See [here](../input) for more details about input formats.

The table below shows what are the accepted input modes for the main subcommands.

|             | `transform` | `grep` | `count` | `compile` | `clean` |
|:-----------:|:-----------:|:---------:|:---------:|:---------:|:---------:|
| **Mono**    |     ✅      |     ✅     |     ✅ (🆕 in `1.10`)      |     ❌     |     ❌     |
| **Multi**   |     ❌      |     ✅ (🆕 in `1.10`)     |     ✅     |     ✅     |     ✅     |

The table below shows what are the ouptut mode modes for the 3 main subcommands (`compile` and `clean` does not have any output).

|                | CLI arg |  `transform` | `grep` | `count` |
|:--------------:|:----------:|:-----------:|:---------:|:---------:|
| **CoNLL-U**    |   ∅   |     ✅ (default)      |     ❌     |     ❌     |
| **JSON**       | `-json` |     ✅      |     ✅ (default)    |     ✅ (default)    |
| **CoNLL-X**    | `-cupt` /  `-semcor` / `-columns …`  |     ✅      |     ❌     |     ❌     |
| **DOT**        | `-dot` |     ✅      |     ❌     |     ❌     |
| **multi JSON** | `-multi_json` |     ✅      |     ❌    |     ❌    |
| **TSV**        | `-tsv` |     ❌      |     ❌     |     ✅ ([in some cases](./#count))    |

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
 * `-config`: See [here](#-config)

---
# Grep

This mode corresponds to the command line version of the [Grew-match](https://match.grew.fr) tool.
Clustering is also available [:link:](./#with-clustering) in the grep mode.

## Without clustering

The command is:

`grew grep -request <request_file> -i <input>`

where:

  * `<request_file>` is a file which describes a request
  * `<input>` describes the data on which the search is done
    * one corpus (**Mono** mode); in this case, the optional `-config` parameter ([see here](#-config)) can also be used
    * a set of corpora (**Multi** mode)

The output is given in JSON format.

### Example with **Mono** input

With the following files:

 * The corpus `UD_French-PUD` version 2.16: `fr_pud-ud-test.conllu`[:link:](https://github.com/UniversalDependencies/UD_French-PUD/blob/r2.16/fr_pud-ud-test.conllu?raw=true)
 * A request file with the code below: `dislocated.req`[:link:](/usage/cli/dislocated.req)

{{< grew file="static/usage/cli/dislocated.req" >}}

**NB**: the fact the edge from `X` to `Y` is given an identifier `e` will give the information about this edge in the output (see below).

The command:

```
grew grep -request dislocated.req -i fr_pud-ud-test.conllu
```

produces the following JSON output:

{{< json file="static/usage/cli/_build/output_grep" >}}

This means that the request described in the file `dislocated.req` has been found three times in the corpus, each item giving the sentence identifier and the position of the nodes and the edges matched by the request.

Note that there are two other options:

 * `-html`: produces a new `html` field in each JSON item with the sentence where words impacted by the request are in a special HTML span with class `highlight`
 * `-dep_dir <directory>`: produces a new file in the `directory` folder with the representation of the sentence with the highlighted part (as in the [Grew-match](https://match.grew.fr) tool) and a new field in each JSON item with the filename; the output is in `dep` format usable with Dep2pict.

### Example with **Multi** input

With the **Mutli** mode data described in the example file `en_fr_zh.json` [:link:](/usage/cli/en_fr_zh.json) (which must be compiled with `grew compile -i en_fr_zh.json`)
{{< json file="static/usage/cli/en_fr_zh.json" >}}

The command:

```
grew grep -request dislocated.req -i en_fr_zh.json
```

produces the following JSON output:

{{< json file="static/usage/cli/_build/output_grep_multi" >}}


## With clustering

In both **Mono** and **Multi** modes, if the command line additionally contains one or more arguments introduced by `-key`,
the set of occurrences is clustered recursively according to the given clustering items.

See the [Clustering documentation page](../../doc/clustering) for details of the various clustering items available.

### Examples

With the same files as in the *without clustering* example above.

With `-key`, we can cluster the results according to the `upos` of the node `Y` (the dependent).

```
grew grep -request dislocated.req -key Y.upos -i fr_pud-ud-test.conllu
```

{{< json file="static/usage/cli/_build/output_grep_key" >}}

If the `-key` argument is surrounded by curly braces, a _whether_ like clustering.
In the next example, we cluster the results according to the fact that the relation is left-headed.

```
grew grep -request dislocated.req -key "{X << Y}" -i fr_pud-ud-test.conllu
```

{{< json file="static/usage/cli/_build/output_grep_whether" >}}


Finally, several clusterings can be applied one after the other. For example

```
grew grep -request dislocated.req -key Y.upos -key "{ X << Y }" -i fr_pud-ud-test.conllu
```

{{< json file="static/usage/cli/_build/output_grep_key_whether" >}}

### Remarks:
 * Any longer sequence of `-key …` can be used.
 * The relative order of clutering items is relevant (try `grew grep -request dislocated.req -key "{ X << Y }" -key Y.upos -i fr_pud-ud-test.conllu`)
 * It is possible to combine **Multi** mode and clustering: `grew grep -request dislocated.req -key Y.upos -key "{ X << Y }" -i en_fr_zh.json`

---
# Count

This mode computes corpus statistics based on **Grew-match** style requests.

The input data are:
 - one (**Mono** mode) or more (**Multi** mode) corpora
 - one or more requests
 - any number of clustering items (either key or whether)

By default, it returns a JSON describing several embedded dictionaries, counting in each corpus, each request clustered according to clustering items.

If the output dimension is 2, the statistics can be printed as a TSV table.
This is the case for:
 * **Mono** mode, any number of requests, 1 clustering item (🆕 in `1.10`)
 * **Multi** mode, any number of requests, no clustering items &rarr; a TSV table is built with the number of occurrences for each request in each corpus.
 * **Multi** mode, 1 request, 1 clustering item &rarr; a TSV table is built with the results of the clustering (with corpora on lines and values of the cluster key in rows).

The optional `-config` parameter ([see here](#-config)) can also be used.



TODO: The set of corpora is described in a [JSON file](../input) and must be [compiled](./#compile) before running `grew count`.


## Example with **Multi** mode, several requests and no clustering
Each request is described in a separate file.
With the two following 1-line files:

 * `ADJ_NOUN_pre.req` [:link:](/usage/cli/ADJ_NOUN_pre.req) {{< grew file="static/usage/cli/ADJ_NOUN_pre.req" >}}
 * `ADJ_NOUN_post.req` [:link:](/usage/cli/ADJ_NOUN_post.req) {{< grew file="static/usage/cli/ADJ_NOUN_post.req" >}}

and the Multi mode file `en_fr_zh.json` [:link:](/usage/cli/en_fr_zh.json)
{{< input file="static/usage/cli/en_fr_zh.json" >}}

After compiling the corpora: `grew compile -i en_fr_zh.json`

The command `grew count -request ADJ_NOUN_pre.req -request ADJ_NOUN_post.req -i en_fr_zh.json`
outputs the JSON data:

{{< json file="static/usage/cli/_build/output_count.json" >}}

And, with `-tsv` option: `grew count -request ADJ_NOUN_pre.req -request ADJ_NOUN_post.req -i en_fr_zh.json -tsv`

{{< input file="static/usage/cli/_build/output_count.tsv" >}}

which corresponds to the table:

| Corpus | ADJ_NOUN | NOUN_ADJ |
|------------|-------------|----------|
| UD_English-PUD | 1114 | 12 |
| UD_French-PUD | 423 | 935 |
| UD_Chinese-PUD | 364 | 0 |

We can then observe that in the annotations of the 3 corpora in use:

 * in French, there is a weak preference for the position of the adjective after the noun (68.9%)
 * in English, there is a strong preference for placing the adjective before the noun (98.9%)
 * in Chinese, there is a **very** strong preference for adjective position before the noun (100%)

## Example with **Multi** mode, one request and a key clustering of the output

Using the same data as in the previous example, the following command:

`grew count -request ADJ_NOUN_pre.req -key N.Number -i en_fr_zh.json -tsv`

produces the TSV file:

{{< input file="static/usage/cli/_build/output_count_key.tsv" >}}

which corresponds to the table:

| Corpus | Plur | Sing | undefined |
|------------|-------------|----------|----|
| UD_English-PUD | 392 | 722 | 0 |
| UD_French-PUD | 178 | 245 | 0 |
| UD_Chinese-PUD | 0 | 0 | 364 |

## Example with **Multi** mode, one request and a whether clustering of the output

Using a whether clustering, with the request `ADJ_NOUN.req` [:link:](/usage/cli/ADJ_NOUN.req) 
{{< input file="static/usage/cli/ADJ_NOUN.req" >}}

and the command: `grew count -request ADJ_NOUN.req -key "{ A << N }" -i en_fr_zh.json -tsv`

we obtain the TSV file:

{{< input file="static/usage/cli/_build/output_count_whether.tsv" >}}

which corresponds to the table:

| Corpus | No | Yes |
|------------|-------------|----------|
| UD_English-PUD | 12 | 1114 |
| UD_French-PUD | 935 | 423 |
| UD_Chinese-PUD | 0 | 364 |


## Remarks

 * Only one request is used in case of clustering.
 * The Request syntax can be learned [here](/doc/request/) or with the online tool **[Grew-match](https://match.grew.fr)**, first with the [tutorial](https://universal.grew.fr?tutorial=yes) and then with the snippets given to the right of the text area.
 * If some corpus is updated, it is necessary to repeat the compilation step.
 * Some requests may take a long time to be searched in corpora.
 * ⚠️ In previous versions (< `1.10`), the TSV table also contains a column with the size of corpora (in number of sentences). This column is no longer available since version `1.10`.


---
# Compile

For the Grew-match backend (`grew_match_back`) or for the `grew count` command, it is necessary to first compile corpora.
For these two usages, sets of corpora are described in a [JSON file](../input).

The files describing the corpora are search in the `CORPUSBANK` folder.
The `CORPUSBANK` folder can be given as an environment variable `CORPUSBANK` or on the command line with the arg `-CORPUSBANK <folder>`.

 - `grew compile`: compiles all corpora described in the corpusbank
 - `grew compile <PATTERN>`: compiles all corpora described in the corpusbank for which the `id` contains the `PATTERN`

Note that the compilation creates a new folder named `_build_grew` in the mail folder of the corresponding corpus.
This folder contains a compiled version of the corpus and a fex other files used by **Grew-match**.

---

# Clean

The commands below removes the `marshal` files produced by the `grew compile` command for the set of corpora described in a corpus bank (see [Compile](./#compile) section above).

 - `grew clean`: cleans all corpora described in the corpusbank
 - `grew clean <PATTERN>`: cleans all corpora described in the corpusbank for which the `id` contains the `PATTERN`

`grew clean -i <corpora.json>`


---
# Parameters

This section describes some command line arguments that are common to several commands.

## `-config`
The config value can be: `ud`, `sud`, `sequoia` or `basic`. The default value is `ud`.

This parameter changes how CoNLL-U and GRS files are interpreted.
More specifically, it controls:
  * How edge labels are parsed (e.g. taking into account `@` extension in SUD). See [here](../../doc/graph#edges) for a detailed description.
  * How features are stored in CoNLL-U (FEATS column or MISC column). See [here](../../doc/conllu#how-the-misc-field-is-handled-by-grew) for details.

This parameter is used in the `transform`, `grep` and `count` modes.
