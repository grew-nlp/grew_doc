+++
date = "2018-06-19T16:42:21+02:00"
title = "install_match"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""
menu = "main"

+++

# Local installation of Grew-match

**Grew-match** is available [online](https://match.grew.fr) for various corpora (UD, SUD, Parseme, etc.).
If you wish to use **Grew-match** on your own corpus, follow the instructions on this page for local installation.

If you encounter any issues, please report them [here](https://github.com/grew-nlp/grew/issues).

You may also consider using [grew_match_quick](https://github.com/grew-nlp/grew_match_quick), a Python script that automates the steps depscribed here.

---

## Step 0: Prerequisites
Follow the **Grew** [installation instructions](../../usage/install/) (steps 1 and 2), in order to install and set up Ocaml & Opam.

Install the required Ocaml libraries:

```
opam install dream
opam remote add grew "https://opam.grew.fr"
opam install dep2pictlib grew
```

---
## Step 1: Create a New Directory
Create a new directory for all necessary files and data.
Set the environment variable `GREW_MATCH_DIR` to this new folder.
For assistance with environment variables in Linux/Unix, refer to [this guide](https://www.geeksforgeeks.org/environment-variables-in-linux-unix/).

```
mkdir -p $GREW_MATCH_DIR
```
---

## Step 2: Install Data and Corpusbank

For this example, we will install three treebanks in `$GREW_MATCH_DIR/data` :

```
mkdir $GREW_MATCH_DIR/data
cd $GREW_MATCH_DIR/data
git clone https://github.com/UniversalDependencies/UD_Arabic-PUD.git
git clone https://github.com/UniversalDependencies/UD_French-PUD.git
git clone https://github.com/UniversalDependencies/UD_Spanish-PUD.git
```

### Configuring the `corpusbank`

The set of corpora to be served is described in a folder called `corpusbank`, which contains JSON files.

```
mkdir $GREW_MATCH_DIR/corpusbank
```

In this new folder, create the JSON file `pud.json` with the following content:

```json_alt
[
  {
    "id": "UD_Arabic-PUD",
    "config": "ud",
    "lang": "ar",
    "rtl": true,
    "directory": "${GREW_MATCH_DIR}/data/UD_Arabic-PUD"
  },
  {
    "id": "UD_French-PUD",
    "config": "ud",
    "lang": "fr",
    "directory": "${GREW_MATCH_DIR}/data/UD_French-PUD"
  },
  {
    "id": "UD_Spanish-PUD",
    "config": "ud",
    "lang": "es",
    "directory": "${GREW_MATCH_DIR}/data/UD_Spanish-PUD"
  }
]
```

### Compiling the corpora

Run the following command to compile all the corpora defined in the `corpusbank`.
This should be executed before the first use and each time a corpus is modified.


```
grew compile -CORPUSBANK $GREW_MATCH_DIR/corpusbank
```


## Step 3: Install and Configure the Backend


Download the backend code:
```
cd $GREW_MATCH_DIR
git clone https://github.com/grew-nlp/grew_match_dream.git
```

### Configuring `grew_match_dream`
In the `grew_match_dream` folder (`$GREW_MATCH_DIR/grew_match_dream`), the file `config.json` contains the description below:

```json_alt
{
	"port": 4758,
	"prefix": "grew_match",
	"corpusbank": "${GREW_MATCH_DIR}/corpusbank",
	"log": "${GREW_MATCH_DIR}/grew_match_dream/log",
	"storage": "${GREW_MATCH_DIR}/grew_match_dream/static"
}
```

If you have followed preceding instructions, no modification is needed.
You can change the port number (4758) to another value, but ensure it matches the one defined in the `instances.json` file below.


## Step 4: Starting the backend
Run the following command in the background (or in a separate terminal) to keep the backend available during use:

```
dune exec grew_match_dream config.json
```

---


## Step 5: Install and Configure the Frontend Webpage

### Download the Frontend Code
The code for the main Grew-match website itself is available at [`gitlab.inria.fr/grew/grew_match`](https://gitlab.inria.fr/grew/grew_match):

```
cd $GREW_MATCH_DIR
git clone https://gitlab.inria.fr/grew/grew_match.git
```

#### Update the Frontend Code

To update the frontend code to the latest version, run:

```
cd $GREW_MATCH_DIR/grew_match
git pull
```

--- 


### Configure `grew_match`
In the grew-match folder (`$GREW_MATCH_DIR/grew_match`), create a configuration file by running:
```
cp instance_template.json instance.json
```

The `instance.json` file will contain the following code, which you can update as needed:

```json_alt
{ 
	"backend": "http://localhost:4758/",
	"desc": [
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
 - The `backend` field specifies the URL of the backend service.
 - The `desc` field describes a list of groups of treebanks, with each group appearing as an item in the top navigation bar of the Grew-match interface.


## Step 5: Start an http server

To start a web server using Python 3, run the following commands:

```
cd $GREW_MATCH_DIR/grew_match
python -m http.server
```

:warning: the last command should be kept running while using Grew-match.
You may run it in the background or in a separate terminal.

You can verify that the Grew-match interface is accessible at [`http://localhost:8000`](http://localhost:8000).

> The default PORT is 8000, you can change it to another value (e.g., 12345) with the command `python -m http.server 12345`. In this case, access the interface at [`http://localhost:12345`](http://localhost:12345).

---



## Step 6: Grew-match is ready!

Congratulations! You can now run requests on your corpora at the URL
[`http://localhost:8000`](http://localhost:8000).
Here are a couple of example queries:

 * {{< tryit "http://localhost:8000?corpus=UD_Spanish-PUD&request=%20" >}}: Search an empty request (this will display the trees of the corpus)
 * {{< tryit "http://localhost:8000?corpus=UD_French-PUD&relation=nsubj" >}}: Search the `nsubj` relation


Note: Once everything is configured as explained above, you should run the two commands in the background to restart Grew-match:
 - `cd $GREW_MATCH_DIR/grew_match && python -m http.server`
 - `cd $GREW_MATCH_DIR/grew_match_dream && dune exec grew_match_dream config.json`

---

# Going further

## After a corpus update
 - Re-compile the corpora: `grew compile -CORPUSBANK $GREW_MATCH_DIR/corpusbank`
 - Force the backend to reload the new data: `curl --location --request POST 'http://localhost:4758/reload'`

Note: There is no need to restart the Python http server for the frontend.


## Web interface configuration
If you have a long list of corpora and prefer to display them in a left pane (similar to UD treebanks),
modify the `instance.json` file by changing the line:
 `"style": "dropdown",` to `"style": "left_pane",`.


## More complex examples

For larger examples of corpusbank definition: see [https://github.com/grew-nlp/corpusbank](https://github.com/grew-nlp/corpusbank).

