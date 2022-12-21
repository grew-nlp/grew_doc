+++
date = "2017-02-27T22:21:02+01:00"
title = "installation"
+++

# Grew installation

**Grew** is implemented with the **[Ocaml](http://ocaml.org)** language.
It can be installed on Linux or Mac OS&nbsp;X (installation on Windows should be possible, but this is untested).
A Python binding is also available, see [here](../python).

You have to install:

 1. `opam` which is the standard package manager for Ocaml
 1. `ocaml` which can be installed by `opam`
 1. `grew` an related libraries which are available as `opam` packages

If you just need to upgrade your installation, please consult the [Upgrade page](../upgrade).

:warning: If you run into trouble using the instructions of this page, feel free to [open an issue on GitHub](https://github.com/grew-nlp/grew/issues/new).


## Step 1: Install opam


**Grew** requires **opam** version **2.0.0** or higher.
In case of trouble installing opam, please consult [**opam** installation page](https://opam.ocaml.org/doc/Install.html).


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
  * `opam switch create 4.14.1 4.14.1` Install a recent version of Ocaml.
  * as adviced by the previous command: `eval $(opam env --switch=4.14.1)`

Check that `ocaml` is installed with `ocamlc -v`. This gives you the version of Ocaml installed.
This should be 4.10.0 or higher.

Run the following command to add the grew specific opam repository:
```
opam remote add grew "http://opam.grew.fr"
```

## Step 3: Install the Grew software


```
opam install grew
```

To verify your installation:

  * Try the command `grew version`. You should have 1.10 (see [Upgrade page](../upgrade) if needed)
  * In case of trouble, try `eval $(opam env)` and `opam install grew` again.
  * If trouble persists, please [fill an issue](https://github.com/grew-nlp/grew/issues/new)

NB: If you want to install the Python library, see [here](../python).
