+++
date = "2019-02-19T18:02:29+01:00"
title = "install_gtk"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""

+++

# Installation of the GTK interface

:warning: Since version 1.4, the GTK interface is obsolete.
Anyway, you may try to install the last version (1.3.4) which should be compatible with libcaml 1.4.

---

We suppose that the basic version ([see installation page](../install)) is already installed.

## Linux
  * Install GUI interface
    * `apt-get install graphviz pkg-config librsvg2-dev libwebkitgtk-dev libglade2-dev libgtk2.0-dev`
      :warning: the package `libwebkitgtk-dev` is not available on recent distribution.
    * `opam install grew_gui`

  * Test
    * Run `grew gui` to run the GTk interface
    * In case of trouble, [fill an issue](https://gitlab.inria.fr/grew/grew_doc/issues)

## On Mac OS&nbsp;X
  * Prerequisite Mac application for running X11 GUI.
    * Install [XQuartz](http://www.xquartz.org/)

  * Install GUI interface
    * `sudo port install graphviz librsvg libglade2 webkit-gtk` :warning: Some users didn't manage to install `webkit-gtk` on recent version of OSX.
    * `opam install grew_gui`



  * Test
    * Run `grew gui` to run the GTk interface
    * In case of trouble, [fill an issue](https://gitlab.inria.fr/grew/grew_doc/issues)
