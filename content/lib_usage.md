+++
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""
date = "2018-03-13T16:40:34+01:00"
title = "lib_usage"
menu = "main"

+++

# Example of library usage with several GRS applied sequentially.
The graph representation has changed in version 0.47 and now each graph is aware of its relative domain.
The usage of the library is simpler (see the old version for comparison).

In the code below, 3 different GRS are loaded (you will need to adapt full path to your local install):

 * `pos_to_ssq`
 * `ssq_to_dsq`
 * `dsq_to_deep`

The file with the code below: `lib_usage.ml` ([Download](/lib_usage/lib_usage.ml)) can be compiled with the command:

`ocamlbuild -use-ocamlfind -pkgs 'libgrew, libgrew, conll, yojson, log, containers, str, ANSITerminal' lib_usage.native`

```ocaml
{{< input file="/static/lib_usage/lib_usage.ml" >}}
```



# Obsolete: Example of version 0.46 library usage with several GRS applied sequentially.

Example with version 0.46 of the library.

:warning: A graph is defined relatively to a particular domain and using it with the wrong domain may produced unwanted effects and erroneous graphs.

In the code below, 3 different GRS are loaded (you will need to adapt full path to your local install):
 * `pos_to_ssq`
 * `ssq_to_dsq`
 * `dsq_to_deep`


The output of the first GRS `graph1__pos_to_ssq` is defined relatively to the domain of the same GRS `pos_to_ssq`.
To be used as the input of the GRS `ssq_to_dsq`, it must be converted to the domain of the new GRS `ssq_to_dsq`.
The converted version of `graph1` is `graph1__ssq_to_dsq`.

Again, the output of `ssq_to_dsq` must be converted before being used as an input to the next GRS `dsq_to_deep` (see below).

```ocaml
{{< input file="/static/lib_usage/lib_usage_0.46.ml" >}}
```

