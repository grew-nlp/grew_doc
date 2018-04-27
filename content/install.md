+++
date = "2017-02-27T22:21:02+01:00"
title = "installation"
+++

# Grew installation

The installation proceeds in two steps: first, installation of the native library and second, installation of the Python library

Note: if you use docker, a `dockerFile` is available with everything installed in it, see [Docker page](../docker).

## Step 1: native library

**Grew** is implemented with the [Ocaml](http://ocaml.org) language.
It is easy to install on Linux or Mac OS&nbsp;X (installation on Windows should be possible, but this is untested).

:warning: If you run into trouble using the instructions of this page, feel free to [open an issue on GitLab](https://gitlab.inria.fr/grew/grew_doc/issues) or to [contact the developer](mailto:Bruno.Guillaume@inria.fr?subject=Install%20of%20Grew).

### On Linux
  * First installation
    * `apt-get install wget opam m4 aspcud` # Prerequisite
    * `opam init -a -y --comp 4.06.0` # Download and install Ocaml (4.06.0)
    * ```eval `opam config env` ``` # Make Ocaml ready to use now
    * `opam remote add grew "http://opam.grew.fr"` # Add the grew OPAM repository
    * `opam install grew grewpy` # Install Grew

  * Test
    * Try the command `grew version`
    * In case of trouble, make sure that your PATH contains `~/.opam/4.06.0/bin` and try again
    * If trouble persists, please [fill an issue](https://gitlab.inria.fr/grew/grew_doc/issues)

  * Updating when **Grew** is already installed:
    * `apt-get update && apt-get upgrade`
    * `opam update && opam upgrade`

### On Mac OS&nbsp;X
  * Prerequisite Mac applications
    * Install [XCode](https://developer.apple.com/xcode/)
    * Install [MacPorts](http://www.macports.org/)

  * First installation
    * `sudo port install wget opam aspcud`  # Prerequisite
    * `opam init -a -y --comp 4.06.0` # Download and install Ocaml (4.06.0)
    * ```eval `opam config env` ``` # Make Ocaml ready to use now
    * `opam remote add talc "http://opam.grew.fr"` # Add the grew OPAM repository
    * `opam install grew grewpy` # Install Grew

  * Test
    * Try the command `grew version`
    * In case of trouble, make sure that your PATH contains `~/.opam/4.06.0/bin` and try again
    * In trouble persists, please [fill an issue](https://gitlab.inria.fr/grew/grew_doc/issues)

  * Updating when **Grew** is already installed:
    * `sudo port sync && sudo port upgrade`
    * `opam update && opam upgrade`

## Step 2: The Python library

With Python 3, use the following command:
`pip install grew`

Note: depending on your local installation, you may have to use `pip3` or `pip3.5`.

# Other available installation

 * A Gtk user interface is available, see [here](../gtk).
 * A docker file with the Python library ready to be used is available [here](../docker).
