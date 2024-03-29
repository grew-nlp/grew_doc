+++
date = "2018-06-19T16:42:21+02:00"
title = "install_match"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""
menu = "main"

+++

# Local installation of Grew-match

This page is outdated. A new page will be provided later.

**Grew-match** is available [online](http://match.grew.fr) on a set of corpora (UD, SUD, Parseme…).
If you want to use **Grew-match** on your own corpus, you have to install it locally, following the instructions on this page.

Please report any issue [here](https://github.com/grew-nlp/grew/issues) in case of trouble.

## Step 1: Install the webpage

All the needed files and data will be installed in a local directory, named `$DIR` in all this page.

### Download
The code for the main Grew-match webpage itself is available on [`gitlab.inria.fr/grew/grew_match`](https://gitlab.inria.fr/grew/grew_match):

#### First time install

```
cd $DIR
git clone https://gitlab.inria.fr/grew/grew_match.git
```

#### Update

```
cd $DIR/grew_match
git pull
```

--- 

## Step 2: Start an http server

With Python 3, you can start a web server with the commands:

```
cd $DIR/grew_match
python -m http.server
```

:warning: the last command should be running during Grew-match usage: run it in the background (or in another terminal).

You can check that the URL [`http://localhost:8000`](http://localhost:8000) shows an empty Grew-match interface.

> The PORT 8000 can be changed to another value (ex: 12345) with the command `python -m http.server 12345` to start the sever and URL [`http://localhost:12345`](http://localhost:12345) to connect.

---

## Step 3: Install the backend

This has been tested with Ocaml _Long Term Support release_ [4.14.1](https://ocaml.org/releases/4.14.1).
It does not work with Ocaml 5.0.0.

Follow the **Grew** [install instruction](../../usage/install/) (Steps 1 and 2), in order to install and setup Ocaml & opam.

:warning: only for Mac (see [#16](https://github.com/ocaml/dbm/pull/16))
  - `opam pin dbm https://github.com/ocaml/dbm.git#master`

Install prerequisites:

```
opam install ssl ocsipersist-dbm fileutils eliom
opam install dep2pictlib grew
```

download the code:
```
cd $DIR
git clone https://gitlab.inria.fr/grew/grew_match_back.git
```

---

## Step 4: configure the corpora

There are four places to describe the configuration:
 1. a JSON file describing the corpora
 2. a JSON file describing how the grew-match interface looks like
 3. the config file of the backend `gmb.conf.in`
 4. the config file of the backend `Makefile.options`

In this example, we configure only one corpus (see [here](./#more-complex-interfaces) for more complex usages).
We take the corpus `UD_French-PUD` as our example.

```
cd $DIR
git clone https://github.com/UniversalDependencies/UD_French-PUD.git
```

### Step 4-1: describe the corpora

Build a folder `$DIR/corpora`:

```
mkdir -p $DIR/corpora
```

and put inside the JSON data below in a file `french.json` (replace `$DIR` by your local path):

```json_alt
{
  "corpora": [{
    "id": "UD_French-PUD",
    "config": "sud",
    "directory": "$DIR/UD_French-PUD"
  }]
}
```

### Step 4-2: interface description 

Put the json data below in a file `config.json` in the folder `$DIR/grew_match`

```json_alt
{
  "backend_server": "http://localhost:8899/",
  "default": "UD_French-PUD",
  "groups": [{
    "id": "French",
    "name": "French",
    "mode": "syntax",
    "style": "single",
    "corpora": [{
      "id": "UD_French-PUD"
    }]
  }]
}
```

:warning: It is required that the file name is `config.json` here. Do not change it.

### Step 4-3

Setup the config file `gmb.conf.in`, starting from the template
```
cd $DIR/grew_match_back
cp gmb.conf.in__TEMPLATE gmb.conf.in
```

Edit the file `gmb.conf.in` (line 28 to 31) with:

```
  <log>$DIR/grew_match_back/log</log>
  <extern>$DIR/grew_match_back/static</extern>
  <corpora>$DIR/corpora</corpora>
  <config>$DIR/grew_match/config.json</config>
```

### Step 4-4

Setup the config file `Makefile.options`, starting from the template

```
cd $DIR/grew_match_back
cp Makefile.options__TEMPLATE Makefile.options
```

Edit the file `Makefile.options` (line 39) with the port number given in `config.json` above (8899 in the example).

```
TEST_PORT := 8899
```

Now the URL [`http://localhost:8000`](http://localhost:8000) should appear with the corpus `UD_French-PUD` selected.


## Step 5: compile the corpora

For a more efficient access corpora are compiled.

```
grew compile -grew_match_server $DIR/grew_match/meta -i $DIR/corpora/french.json
```

A new file with the name of the corpus and the extension `.marshal` is created in the corpus directory.
Of course, you will have to compile again if a corpus is modified.

> You can clean the compiled files with: `grew clean -i $DIR/corpora/french.json`

## Step 6: start the backend

```
cd $DIR/grew_match_back
make test.opt
```

:warning: the last command should be running during Grew-match usage: run it in the background (or in another terminal).

You're done! At the URL [`http://localhost:8000`](http://localhost:8000) we should be able to make a request on your corpus. 

 * {{< tryit "http://localhost:8000?request=%20" >}}: search an empty request (it will just display the trees fo the corpus)
 * {{< tryit "http://localhost:8000?relation=nsubj" >}}: search the `nsubj` relation


## Next steps

To start again when everything is installed, you have to:
 * from `$DIR/grew_match`, start in background `python -m http.server`
 * from `$DIR/grew_match_back`, start in background `make test.opt`

To restart the backend when a corpus is updated:
 * kill the running backend (you can use the command `killall ocsigenserver.opt` if the daemon is running in the background)
 * Run the compile operation again: Step 5
 * Restart the backend: Step 6


---
---

# Going further

## Run a web server

If the Python-based solution proposed above is not enough, a web server is required.

You can install [apache](https://www.apache.org), [nginx](https://nginx.org/) or one of the easy to install distribution like [LAMP on Linux](https://en.wikipedia.org/wiki/LAMP_%28software_bundle%29) or [MAMP on Mac OSX](https://www.mamp.info).

We call `$DOCUMENT_ROOT` the main folder accessible from your local website:
 * with apache, it is defined in the `httpd.conf` file
 * with LAMP, it should be `/opt/lampp/htdocs/`
 * with MAMP, it should be `/Applications/MAMP/htdocs`

If needed, refer to the documentation of the corresponding web server.

The folder `grew_match` must be accessible from the server.
You can install it in `$DOCUMENT_ROOT` or use a symbolic link:

```
cd $DOCUMENT_ROOT
ln -s $DIR/grew_match 
```

## More complex interfaces

On [gitlab.inria.fr/grew/grew_match_config](https://gitlab.inria.fr/grew/grew_match_config), you can find all the configuration files used in the instances available through [match.grew.fr](http://match.grew.fr).

 * In folder `corpora`, all JSON files describes some set of corpora (like in Step 4-1 above)
 * Each other folder (`universal`, `parseme`…) describes the interface of the corresponding instance ([universal.grew.fr](http://universal.grew.fr), [parseme.grew.fr](http://parseme.grew.fr)…) in the file `config.json`. Other files in these folders describe the snippets appearing on the right side of the textarea (TODO: document the snippets description!).
