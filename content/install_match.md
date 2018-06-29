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

## The daemon

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

In order to speed up the pattern search and to preserve memory when a large number of corpora are available, corpora are compiled with the command:

```
grew_daemon marshal my_corpora.json
```
A new file with the name of the corpus and the extension `.marshal` is created in the corpus directory.
Of course, you will have to compile again if one of your corpora is modified.
You can clean the compiled files with

```
grew_daemon clean my_corpora.json
```

### Run the daemon

The Daemon is started with the command (update the port number if necessary):

```
grew_daemon run --port 8888 my_corpora.json
```

## STEP 2: install the webpage

### Download
The code for the webpage is available through `gitlab.inria.fr` with:

```
git clone https://gitlab.inria.fr/grew/grew_match.git
```

### Configuration
Edit the file `grew_match/corpora/groups.json` to describe the set of corpora available.
For instance with our previous examples with 3 corpora, the configuration file looks like:

```JSON
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

In JSON, `groups` define the items in the top navbar and `corpora` the list of corpora in the left bar, maybe organised in folders (recursive folders are not handled).
You can look the [configuration file](https://gitlab.inria.fr/grew/grew_match/blob/master/corpora_for_website/groups.json) used on [Grew-match](match.grew.fr) for a larger example.

### Install

Edit the following installation script (update DEST definition and port number id needed).
Run it from the place where you did the `git clone`.

```shell
# decide where you want to store the webpage locally
DEST=/some/directory/accessible/from/the/web/server/

# Copy the files in the right place
cd grew_match
cp -rf * $DEST

# build local folders for storing data
cd $DEST
mkdir -p data/shorten
chmod -R 777 data

# update parameters in the code
sed -i old "s+@PORT@+8888+" ajaxGrew.php
sed -i old "s+@DATADIR@+$DEST/data/+" ajaxGrew.php
sed -i old "s+@DATADIR@+$DEST/data/+" purge.php
sed -i old "s+@DATADIR@+$DEST/data/+" shorten.php
rm -f *old
```

## Step 3 and more

### Test
You should be able to request your corpora from `localhost`.
Feel free to contact [us](mailto:Bruno.Guillaume@loria.fr) in case of trouble.

### Restart the daemon when one of the corpora is updated

1. Kill the running daemon (you can use the command `killall grew_daemon` if the daemon is running in the background)
2. Run the compile operation again: `grew_daemon marshal my_corpora.json`
3. Restart the daemon: `grew_daemon run --port 8888 my_corpora.json`


