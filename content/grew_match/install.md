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

In the following, we will call `DOCUMENT_ROOT` the main folder accessible from your website:

 * with apache, it is defined in the `httpd.conf` file
 * with LAMP, it should be `/opt/lampp/htdocs/`
 * with MAMP, it should be `/Applications/MAMP/htdocs`

In needed, refer to the documentation of the corresponding web server.

We use here the port number `8888`. You may have to change this if this port number is already used.

## STEP 1: Install the webpage

### Download
The code for the webpage is available on [`gitlab.inria.fr`](https://gitlab.inria.fr/grew/grew_match):

```
git clone https://gitlab.inria.fr/grew/grew_match.git
```

### Configuration
Move to the main folder of the project:

```
cd grew_match
```

Edit the file `corpora/groups.json` to describe the set of available corpora.
An example of configuration file with 3 corpora:

```json
{ "groups": [
    { "id": "local",
      "name": "Local corpora",
      "corpora": [
        { "id": "my_corpora" },
        { "folder": "Older versions",
          "corpora": [
            { "id": "my_corpora@2.0" },
            { "id": "my_corpora@1.0" }
          ]
        }
      ]
    }
  ]
}
```

In JSON, `groups` defines the items in the top navbar and `corpora` the list of corpora in the left bar, maybe organised in folders (recursive folders are not handled).
You can look the [configuration file](https://gitlab.inria.fr/grew/grew_match/blob/master/corpora_for_website/groups.json) used on [Grew-match](http://match.grew.fr) for a larger example.

### Install

The project contains a file [`install_template.sh`](https://gitlab.inria.fr/grew/grew_match/-/blob/master/install_template.sh).
Copy it with the name `install.sh`:

```
cp install_template.sh install.sh
```

Edit the new file `install.sh` and update `DEST` definition (line 2) and `PORT` (line 5) if needed.
Run the install script:

```
./install.sh
```

## STEP 2: Install the daemon

You have to start locally a daemon which will handle your requests on your corpora.

### Installation
Follow general instruction for [Grew installation](../install) and then install the daemon with:

`opam install grew_daemon`

### Configuration
To configure your daemon, you have to describe the corpora you want to use in a `conf` file.
This file describes each corpora with a name, a directory and a list of files.
For instance, the JSON file `my_corpora.json` below defines 3 corpora:

```json
{ "corpora": [
  { "id": "my_corpora",
    "directory": "/users/me/corpora/my_corpora",
    "files": [ "my_corpora_dev.conll", "my_corpora_test.conll", "my_corpora_train.conll" ]
  },
  { "id": "my_corpora@2.0",
    "directory": "/users/me/corpora/my_corpora/2.0",
    "files": [ "my_corpora_dev.conll", "my_corpora_test.conll", "my_corpora_train.conll" ]
  },
  { "id": "my_corpora@1.0",
    "directory": "/users/me/corpora/my_corpora/1.0",
    "files": [ "my_corpora_dev.conll", "my_corpora_test.conll", "my_corpora_train.conll" ]
  }
  ]
}
```

### Compile your corpora

In order to speed up the pattern search and to preserve memory when a large number of corpora are available, corpora are compiled.

During the compilation, a few files are stored in three specific folders.
Before the first compilation, you have to create them with the command:

```
mkdir DOCUMENT_ROOT/_logs DOCUMENT_ROOT/_tables DOCUMENT_ROOT/_descs
```

Then, the compilation is done with the command:

```
grew compile -grew_match_server DOCUMENT_ROOT -i my_corpora.json
```

A new file with the name of the corpus and the extension `.marshal` is created in the corpus directory.
Of course, you will have to compile again if one of your corpora is modified.
The compilation step will also build the relation tables and put them in a place where they can be found by the server.

You can clean the compiled files with:

```
grew clean -i my_corpora.json
```

### Run the daemon

The Daemon is started with the command (update the port number if necessary):

```
grew_daemon run --port 8888 my_corpora.json
```

## Step 3 and more

### Test
Make sure that the web server is running.
You should be able to request your corpora from [`http://localhost:8888/grew_match`](http://localhost:8888/grew_match).
Feel free to contact [us](mailto:Bruno.Guillaume@loria.fr) in case of trouble.

### Restart the daemon when one of the corpora is updated

1. Kill the running daemon (you can use the command `killall grew_daemon` if the daemon is running in the background)
2. Run the compile operation again: `grew compile -grew_match_server DOCUMENT_ROOT -i my_corpora.json`
3. Restart the daemon: `grew_daemon run --port 8888 my_corpora.json`


