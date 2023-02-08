+++
Description = ""
date = "2017-02-28T14:58:11+01:00"
title = "python"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
+++

# Grewpy • Python library

:warning: The [previous library](../python_2018) described in the [book](https://www.wiley.com/en-fr/Application+of+Graph+Rewriting+to+Natural+Language+Processing-p-9781119522348) is deprecated. Please refer to the documentation on this page for uptodate information. 

## Install

If you don' have already installed some **Grew** related software or library, follow steps 1 and 2 on [this page](../install).

 - `opam update`
 - `opam install grewpy_backend`
 - `pip install grewpy` (`pip` may be replaced by `pip3` depending on your local installation)

Test the installation with `echo "import grewpy" | python`. It should output `connected to port: 8888` (or a higher port number if `8888` is already used.)

## Upgrade

1. `opam update && opam install grewpy_backend`
2. `pip install grewpy --upgrade`

The latest version of `grewpy_backend` is 0.1.3. You can check your version with `opam list | grep grewpy`

The latest version of `grewpy` is 0.1.2. You can check your version with `pip3 show grewpy`


## Usage

See [grewpy documentation](https://grew.fr/python) for a detail documentation of the Python library.

## Examples

You can find examples in the [`examples` folder](https://github.com/grew-nlp/grewpy/tree/master/examples).
Click [here](https://downgit.github.io/#/home?url=https://github.com/grew-nlp/grewpy/tree/master/examples) to download the folder.



---
---
# DEV version

**Grewpy** is currently under development. You can install a more recent (and probably less stable) version with the commands belows.

## Install

 - run `opam pin add libcaml-grew git+https://gitlab.inria.fr/grew/libcaml-grew#dev`
 - run `opam pin add grewpy_backend git+https://github.com/grew-nlp/grewpy_backend#dev`
 - use `grewpy` from a local clone of `https://github.com/grew-nlp/grewpy`

## update

 - `opam reinstall libcaml-grew grewpy_backend`
 - `git pull` in your local clone of `https://github.com/grew-nlp/grewpy`


