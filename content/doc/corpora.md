+++
date = "2020-08-29T10:05:28+02:00"
title = "corpora"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""

+++

# JSON description of a set of corpora

Set of corpora are used both for the **[Grew-match](http://match.grew.fr)** online tool and for the **Grew** [count mode](../../usage/cli/#count).

A JSON file is used to describes the set.
Each corpus is described by:

  * a unique identifier `id`
  * a `directory` where the files of the corpus are stored
  * a `files` field with a list of file names. This field is optional, by default all files with extension `conll`, `conllu`, `cupt` or `orfeo` are loaded.

For instance, the file `en_fr_zh.json` [:link:](/doc/corpora/en_fr_zh.json) describes 3 corpora from UD 2.6 (of course, directories should be modified to match your local installation).

{{< input file="static/doc/corpora/en_fr_zh.json" >}}


**NB:** a few other fields are used for corpus description in the **[Grew-match](http://match.grew.fr)**.
See [here](https://gitlab.inria.fr/grew/grew_daemon/-/tree/dev/conf/lchn) for examples of the JSON files used for **Grew-match**