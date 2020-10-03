+++
Tags = ["Development","golang"]
Description = ""
menu = "main"
Categories = ["Development","GoLang"]
date = "2019-06-01T20:54:20+02:00"
title = "grew_server"

+++

# Grew-API for the Arborator-Grew tool

The Arborator-Grew tool is available on [https://arboratorgrew.ilpga.fr/](https://arboratorgrew.ilpga.fr/).

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

```json
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

```json
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

 * `(<string> project_id, <string> sample_id, <string> sent_id, <string> user_id, <file> conll_file)`
 * `(<string> project_id, <string> sample_id, <string> sent_id, <file> conll_file)`
 * `(<string> project_id, <string> sample_id, <string> user_id, <file> conll_file)`
 * `(<string> project_id, <string> sample_id, <file> conll_file)`
 * `(<string> project_id, <file> conll_file)`

### The `saveGraph` service

 * `(<string> project_id, <string> sample_id, <string> sent_id, <string> user_id, <string> conll_graph)`

---

## Search with Grew patterns

:warning: The server uses the new syntax for patterns (see [here](../trans_14)).

### The `searchPatternInGraphs` service

Given a **Grew** pattern and a project, this service returns a list of occurrences of the pattern in the project.
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

 * `(<string> project_id, <string> pattern)` returns a list of occurrences.

 * `(<string> project_id, <string> pattern, <string> clusters)`
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

**NB:** The graph are left unchanged in the project. If you want to modify the graph with the new graphs, use `applyRules` service.

### :warning: DEPRECATED The `tryRule` service

The service `tryRule` is equivalent to `tryRules` but limited to only one rule. It is subsumed by the `tryRules` service and will be removed soon.

 * `(<string> project_id, [<string> sample_id], [<string> user_id], <string> pattern, <string> commands)`


### The `applyRules` service
 * `(<string> project_id, [<string> sample_id], [<string> user_id], <string> rules)`

The input arguments are used in the same way as in `tryRules` service.
But instead of returning new graphs, the project is updated and new graphs replace the previous one (:warning: previous graphs are not recoverable).

The output gives the number of rewritten graphs and the number of unchanged graphs:
```json
{
    "rewritten": 2,
    "unchanged": 0
}
```

### :warning: DEPRECATED The `applyRule` service

The service `applyRule` is equivalent to `applyRules` but limited to only one rule. It is subsumed by the `applyRules` service and will be removed soon.

 * `(<string> project_id, [<string> sample_id], [<string> user_id], <string> pattern, <string> commands)`


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
  * `(<string> project_id)` **DEPRECATED**: use the other service with value `[]` for `sample_ids` parameter

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
  * if several graphs share the same `sent_id`, keep only the graph with the highest `timestamp`

### :warning: REMOVED

In a previous version, the `getLexicon` service was available with profile:

  * `(<string> project_id)`

It was removed. Use the profile `(<string> project_id, <string> sample_ids)` with `[]` for `sample_ids` parameter
