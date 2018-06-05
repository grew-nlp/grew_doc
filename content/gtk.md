+++
date = "2018-04-25"
title = "Gtk installation"
+++

A GTK interface is available (on Linux and Mac OS&nbsp;X, untested on Windows) separately.

# Installation of the GTK interface

We suppose that the basic version ([see install page](../install)) is already installed.

## Linux
  * Install GUI interface
    * `apt-get install graphviz pkg-config librsvg2-dev libwebkitgtk-dev libglade2-dev libgtk2.0-dev`
    * `opam install grew_gui`

  * Test
    * Run `Grew gui` to run the GTk interface
    * In case of trouble, [fill an issue](https://gitlab.inria.fr/grew/grew_doc/issues)

## On Mac OS&nbsp;X
  * Prerequisite Mac application for running X11 GUI.
    * Install [XQuartz](http://www.xquartz.org/)

  * Install GUI interface
    * `sudo port install graphviz librsvg libglade2 webkit-gtk`
    * `opam install grew_gui`

  * Test
    * Run `Grew gui` to run the GTk interface
    * In case of trouble, [fill an issue](https://gitlab.inria.fr/grew/grew_doc/issues)

