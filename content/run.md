+++
Description = ""
date = "2017-02-28T14:58:11+01:00"
title = "run"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
+++

# Grew running modes

There are 3 main running modes for **Grew**:

  * **GUI** mode (this is the default mode): `grew`
  * **Deterministic** mode for one-to-one graph transformation: `grew -det`
  * **Grep** mode searches for occurrences of grew pattern in a corpus `grew -grep`

Options available in all modes:
```
    -grs <grs_file>              chose the grs file to load
    -seq <seq>                   set the module sequence to use
    -timeout <float>             set a timeout on rewriting
    -main_feat <feat_name_list>  set the list of feature names used in dep format to set the "main word"
```





## Graphical User Interface

The following option is available only for the GUI mode:
```
  -gr <gr_file>             set the graph file (.gr or .conll) to use
  -doc                      force to generate the GRS doc
```

The documentation generation takes some time and it is disabled by default.
The documentation given in the GUI can be outdated if the GRS has changed since the last documentation generation.

## Deterministic corpus rewriting
When the GRS file describes a one-to-one transformation, the ''**-det**'' option can be used to transform all graphs of a corpus.

The command below rewrite each graph found in ''**input**'' (a conll file).
The output is written in a file.

```grew -det -i input_file -f output_file ```

**Note**:
In the current version it is possible to use a folder as a corpus (both in input and output) but this will be remove soon, you should avoid to use this.

NB: One way to ensure that a GRS is deterministic is to declare all modules as `deterministic`.

## Grep mode

This mode corresponds to the command line version of the [Online graph matching](http://grew.loria.fr/demo) tool.
The command is:

`grew -grep -pattern <pattern_file> -node_id <id> -i <corpus_file>`

where:

  * `<pattern_file>` is a file which describes a pattern
  * `<id>` is the name of a node identifier declared in the pattern
  * `<corpus_file>` is the corpus in which the search is done

The output is a list of lines, one for each occurrence of the pattern in the corpus.

### Example

With the following files:

 * The surface sequoia version 7.0: `sequoia.surf.conll` ([Download](https://gitlab.inria.fr/sequoia/deep-sequoia/raw/master/tags/sequoia-7.0/sequoia.surf.conll)),
 * A pattern file with the code below: `subcat.pat` ([Download](https://gitlab.inria.fr/grew/grew_doc/raw/master/examples/grep/subcat.pat))

```
match {
  V [cat=V];
  V -[a_obj]-> A;
  V -[de_obj]-> DE;
}
```

The command:

`grew -grep -pattern subcat.pat -node_id V -i sequoia.surf.conll`

produces the following output:

```
annodis.er_00040	41
annodis.er_00240	12
annodis.er_00441	14
emea-fr-test_00438	19
emea-fr-test_00478	31
Europar.550_00496	14
```

This means that the pattern descibed in the file `subcat.pat` was found 6 times in the corpus, each line gives the sentence identifier and the position of node matched by the node `V` of the pattern.
