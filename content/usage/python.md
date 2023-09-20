+++
Description = ""
date = "2017-02-28T14:58:11+01:00"
title = "python"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
+++

# Grewpy • Python library

:warning: The [previous library](../python_2018) described in the [book published in 2018](https://www.wiley.com/en-fr/Application+of+Graph+Rewriting+to+Natural+Language+Processing-p-9781119522348) is obsolete. Please refer to the documentation on this page for up-to-date information. 

## Install

If you don't already have any **Grew**-related software or libraries installed, follow steps 1 and 2 on [this page](../install).

 - `opam update`
 - `opam install grewpy_backend`
 - `pip install grewpy` (`pip` may be replaced by `pip3` depending on your local installation)

Test the installation with `echo "import grewpy" | python`. It should output `connected to port: 8888` (or a higher port number if `8888` is already in use.)

## Upgrade

1. `opam update && opam upgrade`
2. `pip install grewpy --upgrade`

The latest version of `grewpy_backend` is **0.5.1**. You can check your version with `opam list | grep grewpy`

The latest version of `grewpy` is **0.4.3**. You can check your version with `pip show grewpy`


## Usage

See [grewpy documentation](https://grew.fr/python) for a detailed documentation of the Python library.

## Examples

Examples can be found in the [`examples` folder](https://github.com/grew-nlp/grewpy/tree/master/examples).
Click [here](https://downgit.github.io/#/home?url=https://github.com/grew-nlp/grewpy/tree/master/examples) to download the folder.

