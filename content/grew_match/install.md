+++
date = "2018-06-19T16:42:21+02:00"
title = "install_match"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""
menu = "main"

+++

# Local installation of Grew-match

**Grew-match** is available [online](http://match.grew.fr) on a set of corpora (mainly from the UD project).
If you want to use **Grew-match** on your own corpus, you have to install it locally, following the instructions on this page.

## STEP 0: Run a web server

A web server is required. You can install [apache](https://www.apache.org) or one of the easy to install distribution like [LAMP on Linux](https://en.wikipedia.org/wiki/LAMP_%28software_bundle%29) or [MAMP on Mac OSX](https://www.mamp.info).

In the following, we will call `$DOCUMENT_ROOT` the main folder accessible from your local website:

 * with apache, it is defined in the `httpd.conf` file
 * with LAMP, it should be `/opt/lampp/htdocs/`
 * with MAMP, it should be `/Applications/MAMP/htdocs`

If needed, refer to the documentation of the corresponding web server.

## STEP 1: Install the webpage

All the needed files and data will be installed in a local directory, named `$DIR`.


### Download
The code for the webpage itself is available on [`gitlab.inria.fr/grew/grew_match`](https://gitlab.inria.fr/grew/grew_match):

#### First time

```
cd $DIR
git clone https://gitlab.inria.fr/grew/grew_match.git
```

#### Update

```
cd $DIR/grew_match
git pull
```

### Make it accessible by your local server

```
cd $DOCUMENT_ROOT
ln -s $DIR/grew_match 
```

You can check that the URL [`http://localhost:8888/grew_match/`](http://localhost:8888/grew_match/) shows an empty Grew-match instance (the web server must be running).

**NB**: `8888` is the port number used by default by MAMP. You may have to change this for other web servers.

## STEP 2: Install the backend

This step has been tested with Ocaml 4.13.1. It should also work with a more recent version. Please report [here](https://github.com/grew-nlp/grew/issues) if case of trouble.

Install prerequisites and download the code:
```
opam install eliom lwt_ppx yojson containers ANSITerminal libcaml-amr libcaml-conll libcaml-grew cairo2 camomile dep2pict fileutils
cd $DIR
git clone https://gitlab.inria.fr/grew/grew_match_back.git
```

Prepare a folder for logs of the backend and for corpora description.
```
mkdir -p $DIR/log
mkdir -p $DIR/corpora
```

Setup the config file `gmb.conf.in`, starting from the template
```
cd $DIR/grew_match_back
cp gmb.conf.in__TEMPLATE gmb.conf.in
```

Edit the file `gmb.conf.in` (line 28 to 31) with:

```
  <log>$DIR/log</log>
  <extern>$DIR/grew_match_back/static/</extern>
  <corpora>$DIR/corpora</corpora>
  <config>$DIR/grew_match/corpora/config.json</config>
```

The port used by the backend is set to `8899`. This can be changed line 39 of file `Makefile.options`.

## STEP 3: configure the corpora

There are two places to describe the configuration: one describing the corpora, one describing how the grew-match interface looks like.

Here, we configure only one corpus.
Let's take the corpus `UD_French-PUD` as our example.

```
cd $DIR
git clone https://github.com/UniversalDependencies/UD_French-PUD.git
```

## corpus description 

Put the json data below in a file `french.json` in folder `$DIR/corpora`

```
{
  "corpora": [{
    "id": "UD_French-PUD",
    "config": "sud",
    "directory": "$DIR/UD_French-PUD"
  }]
}
```

## interface description

Put the json data below in a file `config.json` in the folder `$DIR/grew_match/corpora`

```
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

The port number (here `8899`) should match the port definition of the file `Makefile.options` (see above).

Now the URL [`http://localhost:8888/grew_match/`](http://localhost:8888/grew_match/) should appear with the corpus selected.



## STEP 4: compile the corpora

```
grew compile -grew_match_server $DOCUMENT_ROOT/grew_match -i $DIR/corpora/french.json
```
A new file with the name of the corpus and the extension `.marshal` is created in the corpus directory.
Of course, you will have to compile again if one of your corpora is modified.
The compilation step will also build the relation tables and put them in a place where they can be found by the server.

You can clean the compiled files with:

```
grew clean -i $DIR/corpora/french.json
```

Of course, you will have to compile again the corpus when data are changed.

## STEP 5: start the backend

```
cd $DIR/grew_match_back
make test.opt
```


# Restart the daemon when one of the corpora is updated

1. Kill the running daemon (you can use the command `killall ocsigenserver.opt` if the daemon is running in the background)
2. Run the compile operation again: step 4
3. Restart the daemon: step 5


