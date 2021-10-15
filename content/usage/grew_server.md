+++
Tags = ["Development","golang"]
Description = ""
menu = "main"
Categories = ["Development","GoLang"]
date = "2019-06-01T20:54:20+02:00"
title = "grew_server"

+++

# Grew-API for the Arborator-Grew tool

The Arborator-Grew tool is available on [https://arborator.github.io](https://arborator.github.io).

The `grew_server` tool is a web server which manages set of annotated graphs with multiple annotations on the same sentence.
It is built to be used as an API by the Arborator-Grew graph annotation tool.

Below, we suppose that the server is available on some `baseURL`.
For testing purpose, a demo server should be available at `http://arborator.grew.fr`.

Annotations are stored with the following hierarchy:

 * the server manages any number of **projects**
 * each project contains any number of **samples**
 * each sample contains any number of **sentences**
 * each sentence may be annotated by any number of **users**

We describe below the list of available services to deal with these levels.
All services are called with a base name and with POST parameters.
Two types of parameter are used: `<string>` and `<file>`.

All services reply with JSON data of one of this three forms:

 * `{ "status": "OK", "data": … }` when the request was executed correctly, the content of the `data` field depends on the service.
 * `{ "status": "WARNING", "messages": …, "data": … }` when the request can be partially executed; the `messages` fields contains a list of messages.
 * `{ "status": "ERROR", "message": "…" }` when the request cannot be executed.

---

## Projects

### The `newProject` service

This service is used to initialise a new empty project. An error is returned if a project with the same name already exists.

 * `(<string> project_id)`

### The `getProjects` service

This service returns the list of existing projects.

 * `()`

The returned value is a list of dict ([see #2](https://gitlab.inria.fr/grew/grew_server/issues/2)):

```json_alt
[
    { "name": "project_1", "number_samples": 23, "number_sentences": 45, "number_tokens": 574, "number_trees": 79 },
    { "name": "project_2", "number_samples": 2, "number_sentences": 4, "number_tokens": 54, "number_trees": 9 }
]
```

### The `eraseProject` service

This service is used to remove a project. If the project does not exist, nothing happens.

 * `(<string> project_id)`

### The `renameProject` service

Renaming of an existing project.
An error is produced either if `project_id` does not exists or if `new_project_id` already exists.

 * `(<string> project_id, <string> new_project_id)`

---

## Samples
All services about samples return an error if the requested project does not exist.

### The `newSample` service

This service is used to initialise a new empty sample in a given project.
An error is returned if the sample already exists.

 * `(<string> project_id, <string> sample_id)`

### The `getSamples` service

This service returns the list of existing samples in a given project ([see #2](https://gitlab.inria.fr/grew/grew_server/issues/2)).

 * `(<string> project_id)`

```json_alt
[
    { "name": "sample_1", "number_sentences": 5, "number_tokens": 74, "number_trees": 8, "users": [ "alice", "bob"] },
    { "name": "sample_2", "number_sentences": 4, "number_tokens": 54, "number_trees": 9, "users": [ "alice", "charlie"]  }
]
```

### The `eraseSample` service

This service is used to remove a sample. If the sample does not exist, nothing happens.

 * `(<string> project_id, <string> sample_id)`

### The `renameSample` service

An error is returned either if `sample_id` does not exist or if `new_sample_id` already exists in `project_id`.

 * `(<string> project_id, <string> sample_id, <string> new_sample_id)`


---

## Sentences

### The `eraseSentence` service

 * `(<string> project_id, <string> sample_id, <string> sent_id)`

---

## Graphs

### The `eraseGraph` service

 * `(<string> project_id, <string> sample_id, <string> sent_id, <string> user_id)`

---

## Other `get` services

### The `getConll` service

 * `(<string> project_id, <string> sample_id, <string> sent_id, <string> user_id)`
 returns a `conll_string`
 * `(<string> project_id, <string> sample_id, <string> sent_id)`
 returns a dict `user_id` -> `conll_string`
 * `(<string> project_id, <string> sample_id)`
 returns a 2-levels dict `sent_id` ->  `user_id` -> `conll_string`

### The `getUsers` service

 * `(<string> project_id, <string> sample_id, <string> sent_id)`
 * `(<string> project_id, <string> sample_id)`
 * `(<string> project_id)`

### The `getSentIds` service

 * `(<string> project_id, <string> sample_id)`
 * `(<string> project_id)`

---

## Save annotations

### The `saveConll` services

 * `(<string> project_id, <string> sample_id, <string> user_id, <file> conll_file)`
 * `(<string> project_id, <string> sample_id, <file> conll_file)`

### The `saveGraph` service

 * `(<string> project_id, <string> sample_id, <string> sent_id, <string> user_id, <string> conll_graph)`

---

## Search with Grew patterns

### The `searchPatternInGraphs` service

Given a **Grew** pattern, a list of users and a project, this service returns a list of occurrences of the pattern in the project.

The string `user_ids` must be a JSON encoding of a list of strings:

 * if the list is empty (i.e. `[]`), all users are taken into account (this is equivalent to the previous behaviour).
 * if the list is `["__last__"]`, for each `sent_id`,  only the most recent graph is taken into account
 * otherwise (like `["user_1", "user_2"]`), only graphs of users present in the list are taken into account

Each occurrence is described by a dict

```
{
  'sample_id':…,
  'sent_id':…,
  'conll':…,
  'user_id':…,
  'nodes':…,
  'edges':…
}
```

 * `(<string> project_id, <string> user_ids, <string> pattern)` returns a list of occurrences.

 * `(<string> project_id, <string> user_ids, <string> pattern, <string> clusters)`
 where `clusters` is a list of cluster keys, separated by `;`.
 This returns nested dictionaries (the depth being equals to the length of the cluster key list).
 The set of occurrences of the `pattern` in `project_id` are clustered with the first key of the list;
 each cluster is further clustered recursively with the remaining keys.
 For instance:

   * If the length of the cluster keys list is 1, the behaviour is similar the the *clustering* feature available in **Grew-match**.
   * Data presented in one table of the page **Relations tables** in **Grew-match** ([ex](http://match.grew.fr/_meta/SUD_French-GSD@latest_table.html)) can be obtained (for the `obj` relation in the example) with the arguments:

     * `pattern`: `pattern { G -[obj]-> D }`
     * `clusters`: `G.upos; D.upos`

---


## Applying Grew rules

### The `tryRules` service
 * `(<string> project_id, [<string> sample_id], [<string> user_id], <string> rules)`

**NB:** brackets are used for optional arguments.
If `sample_id` is provided, the service is restricted to this sample else all samples of the project are considered.
Similarly, if `user_id` is provided, the service is restricted to the graphs belonging to the requested user else all users are considered.

The `rules` parameter must be a JSON encoding of a list of strings, each string being the internal content of a Grew rule.
For instance:

```
[
"pattern { N [upos=VERB] } commands { N.upos = V }",
"pattern { e: N -[nsubj]-> M } commands { del_edge e; add_edge N -[subj]-> M }"
]
```

See **Grew** [command syntax](../commands) for doc about the `commands` part.

The output is the list of new graphs produced by the rules applications (note that the same rule may be applied more than once in a given graph). Each item of the list is an object with the following fields:

 * `conll`: the graph obtained after one or several applications of the rules.
 * `sample_id`
 * `sent_id`
 * `user_id`

**NB:** The graph are left unchanged in the project. If you want to replace old graphs with the new graphs, use `applyRules` service.

The CoNLL output contains special metadata listing nodes and edges that were changed by the rules applications:
 * for each modified node, a metadata `modified_node` is added with the id of the node and the list of features modified by the rule
 * for each modified edge, a metadata `modified_edge` is added with source id, new label and target_id

Below, an example of output after a rewrite with the two rules:

* `pattern { N [upos=VERB] } commands { N.upos=V }`
* `pattern { e: N -[nsubj]-> M } commands { del_edge e; add_edge N -[NSUBJ]-> M }`

```
# user_id = ud
# sent_id = fr-ud-dev_00002
# text = Les études durent six ans mais leur contenu diffère donc selon les Facultés.
# modified_node = 3:upos
# modified_node = 9:upos
# modified_edge = 9,NSUBJ,8
# modified_edge = 3,NSUBJ,2
1	Les	le	DET	_	Definite=Def|Gender=Fem|Number=Plur|PronType=Art	2	det	_	wordform=les
2	études	étude	NOUN	_	Gender=Fem|Number=Plur	3	NSUBJ	_	_
3	durent	durer	V	_	Mood=Ind|Number=Plur|Person=3|Tense=Pres|VerbForm=Fin	0	root	_	_
4	six	six	NUM	_	_	5	nummod	_	_
5	ans	an	NOUN	_	Gender=Masc|Number=Plur	3	obj	_	_
6	mais	mais	CCONJ	_	_	9	cc	_	_
7	leur	son	DET	_	Gender=Masc|Number=Sing|Poss=Yes|PronType=Prs	8	det	_	_
8	contenu	contenu	NOUN	_	Gender=Masc|Number=Sing	9	NSUBJ	_	_
9	diffère	différer	V	_	Mood=Ind|Number=Sing|Person=3|Tense=Pres|VerbForm=Fin	3	conj	_	_
10	donc	donc	ADV	_	_	9	advmod	_	_
11	selon	selon	ADP	_	_	13	case	_	_
12	les	le	DET	_	Definite=Def|Number=Plur|PronType=Art	13	det	_	_
13	Facultés	faculté	NOUN	_	Definite=Def|Number=Plur	9	obl	_	SpaceAfter=No|wordform=facultés
14	.	.	PUNCT	_	_	3	punct	_	_
```

### The `applyRules` service
 * `(<string> project_id, [<string> sample_id], [<string> user_id], <string> rules)`

The input arguments are used in the same way as in `tryRules` service.
But instead of returning new graphs, the project is updated and new graphs replace the previous one (:warning: previous graphs are not recoverable).

The output gives the number of rewritten graphs and the number of unchanged graphs:
```json_alt
{
    "rewritten": 2,
    "unchanged": 0
}
```

---

## Services for project configuration

### The `getProjectConfig` service
  * `(<string> project_id)`

  The service returns a JSON data of the current configuration of the project

### The `updateProjectConfig` service
  * `(<string> project_id, <string> config)`

  The service update the current configuration associated to the project.

---


## Export the most recent data in a project

### The `exportProject` service
  * `(<string> project_id, <string> sample_ids)`

The string `sample_ids` must be a JSON encoding of a list of strings (like `["sample_1", "sample_2"]`).

The service returns an URL on a file containing the "export" of the project. In the export:

  * sentences are filtered with the `sample_ids` list:
    * if the `sample_ids` list is not empty, only sentences from a `sample_id` in the list are considered
    * if the `sample_ids` list is empty, all sentences are considered
  * only graphs in the project with a `timestamp` numerical metadata are present
  * if several graphs share the same `sent_id`, keep only the graph with the highest `timestamp`

---

## Get the lexicon computed from a treebank

### The `getLexicon` service
  * `(<string> project_id, <string> sample_ids)`
  * `(<string> project_id, <string> sample_ids, <string> features)`

The string `sample_ids` must be a JSON encoding of a list of strings (like `["sample_1", "sample_2"]`).

The string `features` must be a JSON encoding of a list of strings (like `["Number", "PronType"]`).
If `features` is not given, the default value is `["PronType", "Mood", "Gloss"]` (this ensures the backward compatibility with previous version).

The service returns a JSON data of the lexicon produced with the Python script [treebank2lexicon.py](https://github.com/Arborator/arborator-flask/blob/master/lexicon/treebank2lexicon.py).
The list of features are passed to the Python script.

The set of graphs considered for the production of the lexicon is the one considered in the `exportProject` service:

  * sentences are filtered with the `sample_ids` list:
    * if the `sample_ids` list is not empty, only sentences from a `sample_id` in the list are considered
    * if the `sample_ids` list is empty, all sentences are considered
  * only graphs in the project with a `timestamp` numerical metadata are present
  * if several graphs share the same `sent_id`, keep only the most recent graph (the one with the highest `timestamp`)

---

## Get tagset or features from a treebank

### The `getPOS` service
  * `(<string> project_id, <string> sample_ids)`

returns the list of POS (`upos` feature) used in the data:

  * in all the project if `sample_id` is `[]`
  * else, only for the subset of sample described by the list

### The `getRelations` service
  * `(<string> project_id, <string> sample_ids)`

returns the list of relations used in the data:

  * in all the project if `sample_id` is `[]`
  * else, only for the subset of sample described by the list


### The `getFeatures` service
  * `(<string> project_id, <string> sample_ids)`

returns the list of feature names used in the data:

  * in all the project if `sample_id` is `[]`
  * else, only for the subset of sample described by the list

---
---


### :warning: DEPRECATED The `tryRule` service

The service `tryRule` is equivalent to `tryRules` but limited to only one rule. It is subsumed by the `tryRules` service and will be removed soon.

 * `(<string> project_id, [<string> sample_id], [<string> user_id], <string> pattern, <string> commands)`


### :warning: DEPRECATED The `applyRule` service

The service `applyRule` is equivalent to `applyRules` but limited to only one rule. It is subsumed by the `applyRules` service and will be removed soon.

 * `(<string> project_id, [<string> sample_id], [<string> user_id], <string> pattern, <string> commands)`

