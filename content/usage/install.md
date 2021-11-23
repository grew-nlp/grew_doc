+++
date = "2017-02-27T22:21:02+01:00"
title = "installation"
+++

# Grew installation

**Grew** is implemented with the **[Ocaml](http://ocaml.org)** language.
It can be installed on Linux or Mac OS&nbsp;X (installation on Windows should be possible, but this is untested).
A Python binding is also available.

You will need to install:

 1. `opam` which is the standard package manager for Ocaml
 1. `ocaml` which can be installed by `opam`
 1. `grew` which is available as an `opam` package

If you just need to upgrade your installation, please consult the [Upgrade page](../upgrade).

:warning: If you run into trouble using the instructions of this page, feel free to [open an issue on GitLab](https://gitlab.inria.fr/grew/grew_doc/issues) or to [contact the developer](mailto:Bruno.Guillaume@inria.fr?subject=Install%20of%20Grew).


## Step 1: Install opam

**Grew** requires **opam** version **2.0.0** or higher.

### Linux
In most Linux recent distribution, version 2 can be installed from default packages.

```
apt-get install opam
```

The following commands installs a few other needed packages:

```
apt-get install wget m4 unzip librsvg2-bin curl bubblewrap
```

### Mac OS&nbsp;X
  * Install **[XCode](https://developer.apple.com/xcode/)**
  * Install the package manager **[Brew](https://brew.sh/)**

  * `brew install aspcud`
  * `brew install opam`

## Step 2: Setup opam

Run: 
  * `opam init` 
  * `opam switch create 4.13.1 4.13.1` Install a recent version of Ocaml.
  * as advice by the previous command: `eval $(opam env --switch=4.13.1)`


Check that `ocaml` is installed with `ocamlc -v`. This gives you the version of Ocaml installed.
This should be 4.10.0 or higher.

## Step 3: Install the Grew software

Run the commands:

```
opam remote add grew "http://opam.grew.fr"
opam install grew grewpy
```

To verify your installation:

  * Try the command `grew version`. You should have 1.4 or higher.
  * In case of trouble, try `eval $(opam env)` and `opam install …` again.
  * If trouble persists, please [fill an issue](https://gitlab.inria.fr/grew/grew_doc/issues)

## Step 4: The Python library

With Python 3, use the following command:
`pip install grew`

Note: depending on your local installation, you may have to use `pip3` or `pip3.5`.


# Other available installations

 * A docker file with the Python library ready to be used is available [here](../docker).
 * A Gtk user interface was available with previous versions, it is not maintained anymore (see [here](../install_gtk)).

---

# Addendum

If opam 2 in not available in your favorite package manager, you should be able to install version **2.0.6** with the following commands:

  * `wget -q https://github.com/ocaml/opam/releases/download/2.0.6/opam-2.0.6-x86_64-linux`
  * `sudo mv opam-2.0.6-x86_64-linux /usr/local/bin/opam`
  * `sudo chmod a+x /usr/local/bin/opam`

For more information, please consult [**opam** installation page](https://opam.ocaml.org/doc/Install.html).
