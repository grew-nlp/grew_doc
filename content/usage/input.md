+++
title = "Input data"
menu = "main"
aliases = [
    "/doc/corpora"
]
+++

# Input data

The **Grew** [command line interface](../cli) can be used with two different ways to describe the input linguistic data:

 * the **Mono** mode where one corpus is considered
 * the **Multi** mode where a set of corpora is considered 

The table below shows which are the modes compatible with each subcommand.

|             | `transform` | `grep` | `count` | `compile` | `clean` |
|:-----------:|:-----------:|:---------:|:---------:|:---------:|:---------:|
| **Mono**    |     ✅      |     ✅     |     ✅ (🆕 in `1.10`)      |     ❌     |     ❌     |
| **Multi**   |     ❌      |     ✅ (🆕 in `1.10`)     |     ✅     |     ✅     |     ✅     |

The **Multi** mode is also use in **Grew-match** to describe the set of corpora on which one can request.

# The **Mono** mode

The **Mono** mode corresponds the following arguments on the command line:

 * a sequence of arguments `-i <file>.<ext>` with extension `.conll`, `.conllu`, `.cupt` or `.orfeo`  &rarr; all sentences in the different files are loaded, following the [CoNLL-U](../../doc/conllu) format or [CoNLL-U Plus](../../doc/conllup) format.
 * a sequence of arguments `-i <file>.json` with JSON files following [Graph JSON encoding](../../doc/json) &rarr; all sentences in the different JSON files
 * a sequence of arguments `-i <file>.amr` or `-i <file>.txt` &rarr; all graphs in the different files are loaded, following the [PENMAN](https://penman.readthedocs.io/) notation
 * one argument `-i directory` &rarr; load all files in the directory like in one of the3 items above
 * no `-i` argument &rarr; CoNLL-u data is read on `stdin`

# The **Multi** mode

The **Multi** mode is used when the command line argument contains a sequence of arguments `-i <file>.json` with JSON files following the JSON description of a set of corpora below.

## JSON description of a set of corpora

Set of corpora are used both for the **[Grew-match](https://match.grew.fr)** online tool and for **Grew**.

A JSON file encodes a list of corpus.
Each corpus is described by:

  * a unique identifier `id`
  * a `directory` where the files of the corpus are stored (use absolute paths)
  * a `files` field with a list of file names. This field is optional, by default all files with extension `conll`, `conllu`, `cupt` or `orfeo` are loaded.

For instance, the file `en_fr_zh.json` [:link:](/usage/input/en_fr_zh.json) describes 3 corpora from UD 2.16 (of course, directories should be modified to match your local installation).

{{< json file="static/usage/input/en_fr_zh.json" >}}

**NB:** A few other fields are used for the description of corpora used in the **Grew-match**.
See [here](https://github.com/grew-nlp/corpusbank) for examples of the JSON files used in different instances of **Grew-match**.