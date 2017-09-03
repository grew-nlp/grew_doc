+++
date = "2017-02-27T22:21:02+01:00"
title = "installation"
+++

# Grew installation

**Grew** is implemented with the [Ocaml](http://ocaml.org) language. The Graphical User Interface is based on [GTK](http://gtk.org), **Grew** is then easy to install on Linux or MAC OS&nbsp;X (installation on Windows should be possible, but this is untested).

:warning: If you run into trouble using the instruction of this page, feel free to open an issue on [GitLab](https://gitlab.inria.fr/grew/grew_doc/issues).

## Step 1: Prerequisites, install non-ocaml needed packages

### On Linux
On Debian/Ubuntu based Linux installation, the following command installs the prerequisites.

 * If needed, install `aptitude` with the command `apt get install aptitude`
 * for all usage: `aptitude install graphviz pkg-config librsvg2-dev m4 automake librsvg2-bin  python-software-properties opam`
 * for GUI, run also: ``aptitude install libwebkitgtk-dev libglade2-dev libgtk2.0-dev`

### On Mac OS&nbsp;X
  1. Install [XCode](https://developer.apple.com/xcode/)
  2. Install [XQuartz](http://www.xquartz.org/)
  3. Install [MacPorts](http://www.macports.org/)

 The following command install the prerequisites

  * for all usages: `sudo port install graphviz librsvg libglade2 wget opam`
  * for GUI, run also: `sudo port install webkit-gtk`

## Step 2: Initialize OPAM
 * `opam init --comp 4.05.0`  # Download and install the last version of Ocaml (4.05.0)

 * `opam config setup -a`  # Update configuration file

 * ```eval `opam config env` ``` # Make Ocaml ready to use know


## Step 3: Add the talc local OPAM repository
 * `opam remote add talc "http://talc2.loria.fr/semagramme/opam"`

## Step 4: Install grew
 * **Grew** GUI: `opam install grew`
 * **Grew** daemon: `opam install grew_daemon` (see [grew daemon](https://gitlab.inria.fr/grew/grew_daemon) gitlab page)

# Update to the latest versions
  1. update prerequisites:
    * Linux :arrow_right: `aptitude update && aptitude upgrade`
    * Mac OS&nbsp;X :arrow_right: `sudo port sync && sudo port upgrade`
  1. update **Grew**: `opam update && opam upgrade`
