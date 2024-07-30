+++
date = "2017-02-27T22:21:02+01:00"
title = "installation"
+++

# Grew installation

**Grew** is implemented using the **[Ocaml](http://ocaml.org)** language and can be installed on Linux or Mac OS&nbsp;X (installation on Windows should be possible, but this is untested).
A Python binding is also available, which can be found [here](../python).

You have to install:

 1. `opam` which is the standard package manager for Ocaml
 1. `ocaml` which can be installed by `opam`
 1. `grew` an related libraries which are available as `opam` packages

If you just need to upgrade your installation, please refer to the [Upgrade section](./#grew-upgrade).

:warning: If you encounter any issues while using the instructions on this page, please do not hesitate to [open an issue on GitHub](https://github.com/grew-nlp/grew/issues/new).


## Step 1: Install opam


**Grew** requires **opam** version **2.0.0** or higher.
In case of trouble installing opam, please consult [**opam** installation page](https://opam.ocaml.org/doc/Install.html).


### Linux
Opam version 2 can be installed from default packages in most recent Linux distributions.

```
apt-get install opam
```

The following commands install a few other necessary packages:

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
  * `opam switch create 5.1.1` Install a recent version of Ocaml (released on Dec 8, 2023)
  * as adviced by the previous command: `eval $(opam env)`

Check that `ocaml` is installed with `ocamlc -v`.
This gives you the version of Ocaml installed.
This should be 4.13 or higher.


## Step 3: Install the Grew software

To add the Grew-specific opam repository, run the following command:

```
opam remote add grew "https://opam.grew.fr"
```

```
opam install grew
```

To verify your installation:

  * Try running command `grew version`. Ensure that the version is 1.16 (refer to the [Upgrade page](../upgrade) if necessary)
  * If you encounter any issues, try running `eval $(opam env)` and then reinstalling grew using `opam install grew`.
  * If the issue persists, please [submit an issue](https://github.com/grew-nlp/grew/issues/new)

**NB:** If you want to install the Python library, see [here](../python).

# Grew upgrade

To upgrade to a newer version of **Grew**, run the following commands:

```
opam update
opam upgrade
```

The latest version is 1.16. You can check your version with

```
opam list | grep grew
```

you should obtain (the third line may not appear if you haven't installed the Python library backend):

```
grew                          1.16.0      Grew system
grewlib                       1.16.0      The main library for the Grew system
grewpy_backend                0.5.3       The Ocaml backend for the `grewpy` Python lib
```
