+++
date = "2017-02-27T22:21:02+01:00"
title = "installation"
+++

# Grew installation

**Grew** is implemented with the [Ocaml](http://ocaml.org) language.
**Grew** is easy to install on Linux or Mac OS&nbsp;X (installation on Windows should be possible, but this is untested).

A GTK interface is available (again on Linux and Mac OS&nbsp;X, untested on Windows) separately.

:warning: If you run into trouble using the instructions of this page, feel free to open an issue on [GitLab](https://gitlab.inria.fr/grew/grew_doc/issues).


## Option 1: Basic installation without GTK interface

### On Linux
  * First installation
    * `apt-get install wget opam m4 aspcud` # Prerequisite
    * `opam init -a -y --comp 4.06.0` # Download and install Ocaml (4.06.0)
    * ```eval `opam config env` ``` # Make Ocaml ready to use know
    * `opam remote add talc "http://talc2.loria.fr/semagramme/opam"` # Add the talc OPAM repository
    * `opam install grew` # Install Grew

  * Test
    * Try the command `grew version`
    * In case of trouble, make sure that your PATH contains `~/.opam/4.06.0/bin` and try again
    * In trouble persists, please [fill an issue](https://gitlab.inria.fr/grew/grew_doc/issues)

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
    * ```eval `opam config env` ``` # Make Ocaml ready to use know
    * `opam remote add talc "http://talc2.loria.fr/semagramme/opam"` # Add the talc OPAM repository
    * `opam install grew` # Install Grew

  * Test
    * Try the command `grew version`
    * In case of trouble, make sure that your PATH contains `~/.opam/4.06.0/bin` and try again
    * In trouble persists, please [fill an issue](https://gitlab.inria.fr/grew/grew_doc/issues)

  * Updating when **Grew** is already installed:
    * `sudo port sync && sudo port upgrade`
    * `opam update && opam upgrade`

## Option 2: Installation of the GTK interface

We suppose that the basic version (Option 1) is already installed.

### Linux
  * Install GUI interface
    * `apt-get install graphviz pkg-config librsvg2-dev libwebkitgtk-dev libglade2-dev libgtk2.0-dev`
    * `opam install grew_gui`

  * Test
    * Run `Grew gui` to run the GTk interface
    * In case of trouble, [fill an issue](https://gitlab.inria.fr/grew/grew_doc/issues)

### On Mac OS&nbsp;X
  * Prerequisite Mac application for running X11 GUI.
    * Install [XQuartz](http://www.xquartz.org/)

  * Install GUI interface
    * `sudo port install graphviz librsvg libglade2 webkit-gtk`
    * `opam install grew_gui`

  * Test
    * Run `Grew gui` to run the GTk interface
    * In case of trouble, [fill an issue](https://gitlab.inria.fr/grew/grew_doc/issues)

