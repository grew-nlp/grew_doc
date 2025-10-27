+++
Description = ""
date = "2017-02-28T14:58:11+01:00"
title = "python"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
+++

# Grewpy • Python library

:warning: The [previous library](../python_2018) described in the [book published in 2018](https://www.wiley.com/en-fr/Application+of+Graph+Rewriting+to+Natural+Language+Processing-p-9781119522348) is now obsolete.

## Install

If you do not have any software or libraries related to **Grew** installed, please follow steps 1 and 2 on [this page](../install) and run the commands:

 - `opam remote add grew "https://opam.grew.fr"`
 - `opam update`
 - `opam install grewpy_backend`
 - `pip install grewpy` (`pip3` may be used instead of `pip` depending on your local installation).

To test the installation, run the command `echo "import grewpy" | python`.
The expected output is `connected to port: …` (The port number is selected dynamically).

## Upgrade

1. `opam update && opam upgrade grewpy_backend`
2. `pip install grewpy --upgrade`

The current version of `grewpy_backend` is **0.6.1**. You can verify your version by running `opam list | grep grewpy`.

The current version of `grewpy` is **0.7.0**. You can verify your version by running `pip show grewpy`.
View [How to to upgrade to grewpy 0.7](../../grewpy/upgrade_0.6).

## Usage

The library is in developement and the documentation is not complete. Feel free to [raise an issue](https://github.com/grew-nlp/grewpy/issues) for any questions.

 - A [Grewpy Tutorial](../../grewpy/tutorial) is available with a few examples.

 - You can also refer to the automatically generated [grewpy documentation](https://grew.fr/python) for detailed information on the Python library.

 - Some more examples can be found in the [`examples` folder](https://github.com/grew-nlp/grewpy/tree/master/examples).
Click [here](https://downgit.github.io/#/home?url=https://github.com/grew-nlp/grewpy/tree/master/examples) to download the folder.

