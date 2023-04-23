+++
title = "Tuto • Relation table"
+++

• [:arrow_up: Top](../top) •

# Building relation tables on your treebank

We call here "relation table" a table like the ones which are available through Grew-match: [example on UD_French-PUD, version 2.11](http://universal.grew.fr/meta/UD_French-PUD@2.11_table.html) (select a relation on the left).

The simplest way to compute this kind of table on your own corpus is to use the Python library [grewpy](../../usage/python).
It is also possible to do the same with the [Command Line Interface](../../usage/cli).

For this example, we suppose that we have a subfolder `data` which contains the file `fr_pud-ud-test.conllu` (the version 2.11 of the corpus **UD_French-PUD** which can be downloaded [here](https://raw.githubusercontent.com/UniversalDependencies/UD_French-PUD/r2.11/fr_pud-ud-test.conllu)).

```
.
├── data
│   └── fr_pud-ud-test.conllu
```

## With the `grewpy` Python lib

See [here](../../usage/python#install) for the installation of `grewpy`.

### Table for `nsubj` relation

The script below loads the corpus and computes the table for the `nsubj` relation:

{{< python file="/static/tutorial/relation_table/nsubj_table.py" >}}

The output is a nested Python dictonary, the toplevel keys correspond to the `G.upos` and the embedded keys correspond to the `D.upos`.
For instance, `nsubj_table['VERB']['NOUN']` returns `544` which corresponds to the number of occurrences of the `nsubj` relation from a `VERB` to a `NOUN`:

{{< input file="static/tutorial/relation_table/_build/nsubj_table.out" >}}

Note that the sums for rows and columns are not given but it is easy to add them in the Python code.

### Table for `nsubj` relation and its possible extension

The example about requires for `nsubj` but not for `nsubj:pass` and `nsubj:caus` which are also used in **UD_French-PUD**.
To have the table for all relations `nsubj` with and without extension, the request `'G -[nsubj]-> D'` should be changed to `'G -[1=nsubj]-> D'` (see [complex edges](../../doc/request#complex-edges) for an explanation).

### Compute tables for all relations

It is possible to get all relation tables (without looping on edge labels) by using one more clustering key.

{{< python file="/static/tutorial/relation_table/all_tables.py" >}}

In the code above, `all_tables` is a dictionay mapping the possible values of dependency labesl (`e.label`) to a sub-dictionary as the one obtained above for `nsubj`.

```
…,
 'iobj': {'VERB': {'PRON': 35}, 'ADJ': {'ADP': 1}}, 
 'goeswith': {'NUM': {'X': 1}, 'NOUN': {'X': 1}, 'ADV': {'X': 1}},
…
```

## With the Command Line Interface

The needed requests must be declared in a external file.
So we suppose that our folder contains two more files:

 - `nsubj_table.req`

{{< grew file="/static/tutorial/relation_table/nsubj_table.req" >}}

 - `all_tables.req`

{{< grew file="/static/tutorial/relation_table/all_tables.req" >}}

The command below build a JSON code of the `nsubj` relation table.

```
grew count -request nsubj_table.req -key G.upos -key D.upos -i data/fr_pud-ud-test.conllu
```

For all tables:
```
grew count -request all_tables.req -key e.label -key G.upos -key D.upos -i data/fr_pud-ud-test.conllu
```

## Remarks
 - It we want to get list of occurrences instead of just a number, the command `grew count …` can be replaced by `grew grep …`, with the same arguments.
 - The JSON obtained is slightly different from the one of the Python library, it contains another external layer of dictionary because the command can be applied with more than one requests.
The output of the last command is then:

```json_alt
{
  "all_tables.req": {
    "xcomp": { … },
    …
    "acl": { … }
  }
}
```
