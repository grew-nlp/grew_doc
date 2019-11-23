+++
Description = ""
date = "2019-10-23T16:34:39+02:00"
title = "corpus_stat"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]

+++

The tool `grew_daemon` was initially built to be used as the daemon to answer requests in **Grew-match**.
But it can also be used as a command line tool to compute statistics on sets of corpora.
This page describes this usage.

# Install the `grew_daemon` tool

Follow general instruction for [Grew installation](../install) and then install the `grew_daemon` tool with:

`opam install grew_daemon`

# Describe the set of corpora on which you want to compute statistics

A JSON file is used to describes the set.
Each corpus is described by a identifier `id` and a `directory` where the files of the corpus are stored.
For instance, the following file `en_fr_zh.json` describes 3 corpora from UD 2.4 (of course, directories should be modified to match your local installation).

```
{ "corpora": [
  { "id": "UD_English-EWT@2.4",
    "directory": "/Users/guillaum/resources/ud-treebanks-v2.4/UD_English-EWT/"
  },
  { "id": "UD_French-Sequoia@2.4",
    "directory": "/Users/guillaum/resources/ud-treebanks-v2.4/UD_French-Sequoia/"
  },
  { "id": "UD_Chinese-GSD@2.4",
    "directory": "/Users/guillaum/resources/ud-treebanks-v2.4/UD_Chinese-GSD/"
  } ]
}
```

# Compile the corpora in order to speed up the next step

```
grew_daemon marshal en_fr_zh.json
```

Note that this will produce a new file with the `marshal` extension, stored in the corpus directory, for each corpus in `en_fr_zh.json`

# Compute statistics

It is possible to compute the number of occurrences of several patterns at the same time.
For intance, with the two following 1-line files:

 * `ADJ_NOUN.pat` containing: `pattern { A[upos=ADJ]; N[upos=NOUN]; N -[amod]-> A; A << N }`
 * `NOUN_ADJ.pat` containing: `pattern { A[upos=ADJ]; N[upos=NOUN]; N -[amod]-> A; N << A }`

The commands below computes the statistics about the number of occurrences of each pattern in each corpus:

```
grew_daemon grep --patterns "ADJ_NOUN.pat NOUN_ADJ.pat" en_fr_zh.json
```

The output is given as TSV data:

```
Corpus	# sentences	ADJ_NOUN	NOUN_ADJ
UD_English-EWT	16622	9838	162
UD_French-Sequoia	3099	891	2777
UD_Chinese-GSD	4997	1481	0
```

which corresponds to the table:

| Corpus | # sentences | ADJ_NOUN | NOUN_ADJ |
|------------|-------------|----------|----|
| UD_English-EWT | 16622 | 9838 | 162 |
| UD_French-Sequoia | 3099 | 891 | 2777 |
| UD_Chinese-GSD | 4997 | 1481 | 0 |

We can then observe that in the annotations of the 3 corpora in use:

 * in English, there is a strong preference for adjective position before the noun (98.4%)
 * in French, there is a weak preference for adjective position after the noun (75,7%)
 * in Chinese, there is a **very** strong preference for adjective position before the noun (100%)


----

## Remarks

 * The TSV table also contains a column with the size of corpora (in number of sentences), this can be useful to make cross-corpora analysis and to compute ratios instead of raw numbers.
 * Pattern syntax can be learned [here](/pattern/) or with the online [**Grew-match**](http://match.grew.fr) tool, first with the [tutorial](http://match.grew.fr?tutorial=yes) and then with snippets given on the right of the text area.
 * If some corpus is updated, it is necessary to run again the compilation step.
 * The command `grew_daemon clean en_fr_zh.json` can be used to remove `marshal` files (results of compilation).
 * Some patterns may take a long time to be searched in corpora.