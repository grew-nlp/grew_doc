+++
date = "2017-02-27T22:21:02+01:00"
title = "installation"
+++

# Grew installation

**Grew** is implemented with the **[Ocaml](http://ocaml.org)** language.
It is easy to install on Linux or Mac OS&nbsp;X (installation on Windows should be possible, but this is untested).
A Python binding is also available.

:warning: If you run into trouble using the instructions of this page, feel free to [open an issue on GitLab](https://gitlab.inria.fr/grew/grew_doc/issues) or to [contact the developer](mailto:Bruno.Guillaume@inria.fr?subject=Install%20of%20Grew).


## Step 1: Install prerequisite

### Linux
```bash
apt install wget m4 unzip librsvg2-bin curl bubblewrap
```

### Mac OS&nbsp;X
  * Install **[XCode](https://developer.apple.com/xcode/)**
  * Install the package manager **[MacPorts](http://www.macports.org/)**

:warning: **[Brew](https://brew.sh/)** is an alternative only if you do not plan to use the GUI (the package `webkit-gtk` required by the GUI is not available through **Brew**).

  * `sudo port install aspcud`

## Step 2: Install opam
**opam** is a package manager for **Ocaml**.
**Grew** requires **opam** version **2.0.0** or higher.

### Linux
The `apt` package manager does not currently (February 2019) provide `opam` version 2.
You should be able to install version **2.0.3** with the following commands:

  * `wget -q https://github.com/ocaml/opam/releases/download/2.0.3/opam-2.0.3-x86_64-linux`
  * `sudo mv opam-2.0.3-x86_64-linux /usr/local/bin/opam`
  * `sudo chmod a+x /usr/local/bin/opam`

For more information, please consult [**opam** installation page](https://opam.ocaml.org/doc/Install.html).

### Mac OS&nbsp;X

**MacPorts** proposes **opam** version 2 by default.

  * `sudo port install opam`

## Step 3: Setup opam

Run `opam init` and follow instructions.
Note that it takes some times to download and build the `ocaml` compiler.

NB: some user have reported that the command `opam init --disable-sandboxing` may avoid errors given by `opam init`.

Check that `ocaml` is installed with `ocamlc -v`.

## Step 4: Install the Grew software

```bash
opam remote add grew "http://opam.grew.fr"
opam install grew grewpy
```

To verify your installation:

  * Try the command `grew version`
  * In case of trouble, make sure that your PATH contains `~/.opam/default/bin` and try again
  * If trouble persists, please [fill an issue](https://gitlab.inria.fr/grew/grew_doc/issues)

## Step 5: The Python library

With Python 3, use the following command:
`pip install grew`

Note: depending on your local installation, you may have to use `pip3` or `pip3.5`.


# Other available installations

 * A Gtk user interface is available, see [here](../install_gtk).
 * A docker file with the Python library ready to be used is available [here](../docker).

