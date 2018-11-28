+++
date = "2017-02-27T22:21:02+01:00"
title = "installation"
+++

# Grew installation

The installation proceeds in two steps: first, installation of the native library and second, installation of the Python library


**Grew** is implemented with the [Ocaml](http://ocaml.org) language.
It is easy to install on Linux or Mac OS&nbsp;X (installation on Windows should be possible, but this is untested).

:warning: If you run into trouble using the instructions of this page, feel free to [open an issue on GitLab](https://gitlab.inria.fr/grew/grew_doc/issues) or to [contact the developer](mailto:Bruno.Guillaume@inria.fr?subject=Install%20of%20Grew).

## Linux

### Step 1: native library
  * `apt-get install opam m4 aspcud` # Prerequisite
  * `opam init -a -y --comp 4.06.0` # Download and install Ocaml (4.06.0)
  * ```eval `opam config env` ``` # Make Ocaml ready to be used now
  * `opam remote add grew "http://opam.grew.fr"` # Add the grew OPAM repository
  * `opam install grew grewpy` # Install Grew

To verify your installation

  * Try the command `grew version`
  * In case of trouble, make sure that your PATH contains `~/.opam/4.06.0/bin` and try again
  * If trouble persists, please [fill an issue](https://gitlab.inria.fr/grew/grew_doc/issues)

### Step 2: The Python library

With Python 3, use the following command:
`pip install grew`

Note: depending on your local installation, you may have to use `pip3` or `pip3.5`.


## Mac OS&nbsp;X

### Step 1: native library
  * Install [XCode](https://developer.apple.com/xcode/)
  * Install the package manager [MacPorts](http://www.macports.org/) (:warning: [Brew](https://brew.sh/) is an alternative only if you do not plan to use the GUI. The package `webkit-gtk` required by the GUI is not available through Brew).
  * `sudo port install opam aspcud`  # Install opam and aspcud
  * `opam init -a -y --comp 4.06.0` # Download and install Ocaml (4.06.0)
  * ```eval `opam config env` ``` # Make Ocaml ready to be used now
  * `opam remote add grew "http://opam.grew.fr"` # Add the grew OPAM repository
  * `opam install grew grewpy` # Install Grew

To verify your installation

  * Try the command `grew version`
  * In case of trouble, make sure that your PATH contains `~/.opam/4.06.0/bin` and try again
  * In trouble persists, please [fill an issue](https://gitlab.inria.fr/grew/grew_doc/issues)

### Step 2: The Python library

With Python 3, use the following command:
`pip install grew`

Note: depending on your local installation, you may have to use something like `pip3` or `pip3.5`.


# Upgrade

### On Linux
When grew is already installed, you can upgrade to the latest version with:

  * `apt-get update && apt-get upgrade` # upgrade prerequisites
  * `opam update && opam upgrade` # upgrade OCaml part
  * `pip install grew --upgrade` # upgrade Python part

### On Mac OSX
When grew is already installed, you can upgrade to the latest version with:

  * `sudo port sync && sudo port upgrade` # MacPorts upgrade
  * `opam update && opam upgrade` # upgrade OCaml part
  * `pip install grew --upgrade` # upgrade Python part

# Other available installations

 * A Gtk user interface is available, see [here](../gtk).
 * A docker file with the Python library ready to be used is available [here](../docker).
