+++
date = "2018-06-19T16:42:21+02:00"
title = "install_match"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""
menu = "main"

+++

# Local installation of Grew-match

**Grew-match** is available [online](http://match.grew.fr) for a number of corpora (UD, SUD, Parseme…).
If you want to use **Grew-match** on your own corpus, you have to install it locally, following the instructions on this page.

Please report any problems [here](https://github.com/grew-nlp/grew/issues) in case of trouble.

You may also consider using [grew_match_quick](https://github.com/grew-nlp/grew_match_quick).
This a Python script that automatizes the steps depscribed here.

---

## Step 0: Prerequisites
Follow the **Grew** [installation instructions](../../usage/install/) (steps 1 and 2), in order to install and set up Ocaml & Opam.

Install the required Ocaml libraries:

```
opam install ssl ocsipersist-dbm fileutils eliom
opam remote add grew "https://opam.grew.fr"
opam install dep2pictlib grew
```

---
## Step 1: Create a new directory
Create a new directory where all the necessary files and data will be installed.
Replace the string `__DIR__` with this new directory throughout this documentation, in commands or parameter files.

---

## Step 2: Installing data and corpusbank

For this example, we will install three treebanks in `__DIR__/data` :

```
cd __DIR__
mkdir data && cd data
git clone https://github.com/UniversalDependencies/UD_Arabic-PUD.git
git clone https://github.com/UniversalDependencies/UD_French-PUD.git
git clone https://github.com/UniversalDependencies/UD_Spanish-PUD.git
```

### Configuring the `corpusbank`

The set of corpora to be served is described in a folder called `corpusbank` which contains JSON files.

```
cd __DIR__
mkdir corpusbank
```

In this new folder, add the JSON file `pud.json`:

```json_alt
[
  {
    "id": "UD_Arabic-PUD",
    "config": "ud",
    "lang": "ar",
    "rtl": true,
    "directory": "__DIR__/data/UD_Arabic-PUD"
  },
  {
    "id": "UD_French-PUD",
    "config": "ud",
    "lang": "fr",
    "directory": "__DIR__/data/UD_French-PUD"
  },
  {
    "id": "UD_Spanish-PUD",
    "config": "ud",
    "lang": "es",
    "directory": "__DIR__/data/UD_Spanish-PUD"
  }

]
```

### Compiling the corpora
The following command compiles all the corpora defined in the `corpusbank`. 
It should be run before the first use and each time a corpus is modified.

```
grew compile -CORPUSBANK __DIR__/corpusbank
```


## Step 3: Install and configure the backend


download the code:
```
cd __DIR__
git clone https://gitlab.inria.fr/grew/grew_match_back.git
```

### Configuring `grew_match_back`
In the grew-match_back folder (`__DIR__/grew_match_back`), edit the file `gmb.conf.in` (lines 28 to 31) with the real `__DIR__` value:

```
  <LOG>__DIR__/grew_match_back/log</LOG>
  <CORPUSBANK>__DIR__/corpusbank</CORPUSBANK>
  <RESOURCES>__DIR__/data</RESOURCES>
  <STORAGE>__DIR__/grew_match_back/static</STORAGE>
```

## Step 4: Starting the backend
The command below should be run in the background (or in a separate terminal) so that the backend remains available during use.

```
cd __DIR__/grew_match_back
make GMB_PORT=4758 test.opt
```

Of course, the port number (4758) can be changed to another value, but it must be the same as the one defined in the `instance.json` file below.

---


## Step 5: Install and configure the frontend webpage

### Download
The code for the main Grew-match website itself is available at [`gitlab.inria.fr/grew/grew_match`](https://gitlab.inria.fr/grew/grew_match):

```
cd __DIR__
git clone https://gitlab.inria.fr/grew/grew_match.git
```

#### Update

```
cd __DIR__/grew_match
git pull
```

--- 


### Configure `grew_match`
In the grew-match folder (`__DIR__/grew_match`), add a `instance.json` file with the following code:
```json_alt
{
	"backend": "http://localhost:4758/",
	"groups": 
	[
		{
			"id": "PUD",
			"mode": "syntax",
			"style": "dropdown",
			"corpora": [
				"UD_Arabic-PUD",
				"UD_French-PUD",
				"UD_Spanish-PUD"
			]
		}
	]
}
```


## Step 5: Start an http server

With Python 3, you can start a web server with the following commands:

```
cd __DIR__/grew_match
python -m http.server
```

:warning: the last command should be kept running while using Grew-match: run it in the background (or in another terminal).

You can check that the URL [`http://localhost:8000`](http://localhost:8000) shows the Grew-match interface.

> The PORT 8000 can be changed to another value (e.g. 12345) with the command `python -m http.server 12345` to start the server and URL [`http://localhost:12345`](http://localhost:12345) to connect.

---



## Step 6: Grew-match is ready!

You're done! At the URL [`http://localhost:8000`](http://localhost:8000), you should be able to make a request on your corpora. 
 * {{< tryit "http://localhost:8000?corpus=UD_Spanish-PUD&request=%20" >}}: search an empty request (it will only display the trees of the corpus)
 * {{< tryit "http://localhost:8000?corpus=UD_French-PUD&relation=nsubj" >}}: search the `nsubj` relation


Note: Once everything is configured as explained above, you should run the two commands in the background to restart Grew-match:
 - `cd __DIR__/grew_match && python -m http.server`
 - `cd __DIR__/grew_match_back && make GMB_PORT=4758 test.opt`

---

# Going further

## After a corpus update
 - Re-compile the corpora again: `grew compile -CORPUSBANK __DIR__/corpusbank`
 - Force the backend to reload the new data: `curl --location --request POST 'http://localhost:4758/reload'`

Note: There is no need to restart the Python http server for the frontend.


## Web interface configuration
If you have a long list of corpora and want to put them in a pane on the left (like for UD treebanks),
change in `instance.json` the line `"style": "dropdown",` by `"style": "left_pane",`.


## More complex examples

For larger examples of corpusbank definition: see [https://github.com/grew-nlp/corpusbank](https://github.com/grew-nlp/corpusbank)

