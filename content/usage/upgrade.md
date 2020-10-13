+++
date = "2019-02-19T17:56:47+01:00"
title = "upgrade"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""

+++

# Upgrading to a new version

## Make sure that your opam is in version 2
The last version of **grew** requires that the **opam** tool is in version **2.0.0** or higher.

You can check your versions with the command `opam --version`.
It it's not version 2, re-install **opam** in version 2 with instructions steps 1 and 2 on the [Installation page](../install).

## Update prerequisite
### Linux
```bash
apt-get update && apt-get upgrade
```

### On Mac OSX
```bash
sudo port sync && sudo port upgrade outdated
```

## Update the Grew software

```bash
opam update
opam upgrade
```

## Update the Python binding
```bash
pip install grew --upgrade
```

