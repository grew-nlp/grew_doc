+++
title = "grew_server"
+++

# Grew-API for the Arborator-Grew tool

This documentation correspond the the [master branch on Inria GitLab](https://gitlab.inria.fr/grew/grew_server/-/tree/master).
On 2023/02/24, master is on [b8e63c50](https://gitlab.inria.fr/grew/grew_server/-/commit/b8e63c50076c500e74b74f665e173741c0398c18).

See [below](.#dev) for the difference on DEV branch and DEV server.

The Arborator-Grew tool is available on [https://arborator.github.io](https://arborator.github.io).

The `grew_server` tool is a web server which manages set of annotated graphs with multiple annotations on the same sentence.
It is built to be used as an API by the Arborator-Grew graph annotation tool.

Below, we suppose that the server is available on some `baseURL`.

Annotations are stored with the following hierarchy:

 * the server manages any number of **projects**
 * each project contains any number of **samples**
 * each sample contains any number of **sentences**
 * each sentence may be annotated by any number of **users**

We describe below the list of available services to deal with these levels.
All services are called with a base name and with POST parameters.
Three types of parameter are used: `<string>`, `<int>` and `<file>`.

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

## Search with Grew requests

### The `searchRequestInGraphs` service

The same service named `searchPatternInGraphs` exists for backward compatibilty.

Given a **Grew** request, a list of users and a project, this service returns a list of occurrences of the request in the project.

See [here](#user_ids) for the usage of `user_ids` argument.

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

 * `(<string> project_id, <string> user_ids, <string> request)` returns a list of occurrences.

 * `(<string> project_id, <string> user_ids, <string> request, <string> clusters)`
 where `clusters` is a list of cluster keys, separated by `;`.
 This returns nested dictionaries (the depth being equals to the length of the cluster key list).
 The set of occurrences of the `request` in `project_id` are clustered with the first key of the list;
 each cluster is further clustered recursively with the remaining keys.
 For instance: If the length of the cluster keys list is 1, the behaviour is similar the the *clustering* feature available in **Grew-match**.

For the service named `searchPatternInGraphs`, the POST argument of the request id named `pattern` instead of `request`.

---

## Relation tables
In order to produce the relations tables (as in Grew-match), the following service can be used:

### The `relationTables` service

 * `(<string> project_id, <string> sample_ids, <string> user_ids)`

See [here](#generic-arguments-usage) for the usage of `sampe_ids` and `user_ids` POST parameters.

The service returns a JSON dictionary of depth 3 where keys are:
 * the dependency relations label
 * the `upos` of the governor of the relation
 * the `upos` of the dependant of the relation (**NB**: `ExtPos` is taken into account if present)
 
and the values are integers indicating the number of occurrences of the each triple of keys.

#### Example

With the following CoNLL:

```
1	(	_	PUNCT	_	_	3	punct	_	_
2	ouvert	_	ADJ	_	_	0	root	_	_
3	à	_	ADP	_	_	2	mod	_	ExtPos=ADV|Idiom=Yes
4	nouveau	_	ADJ	_	_	3	comp:obj	_	InIdiom=Yes
5	)	_	PUNCT	_	_	3	punct	_	_
```

The `relationTables` service returns:


```
{
  "root": { "_": { "ADJ": 1 } },
  "punct": { "ADP": { "PUNCT": 2 } },
  "mod": { "ADJ": { "ADV": 1 } },
  "comp:obj": { "ADP": { "ADJ": 1 } }
}
```

Note the the `mod` relation has `ADV` as the POS for the dependant, because of the `ExtPos` feature on the word `à`.

The Grew pattern corresponding to the `mod` line is (using the undocumented Grew feature for requesting on ExtPos): 

```grew
pattern { GOV -[mod]-> DEP; GOV [upos="ADJ"]; DEP [ExtPos="ADV"/upos="ADV"]; }
```

---

## Applying Grew rules

### The `tryPackage` service
 * `(<string> project_id, <string> sample_ids, <string> user_ids, <string> package)`

See [here](#generic-arguments-usage) for the usage of `sample_ids` and `user_ids` arguments.

The `package` parameter must be a JSON string encoding a list of rules.
For instance:

```
"rule r1 { pattern { N [upos=VERB] } commands { N.upos = V } }
rule r2 { pattern { e: N -[nsubj]-> M } commands { del_edge e; add_edge N -[subj]-> M }"
```

See **Grew** [command syntax](../commands) for doc about the `commands` part.

The output is the list of new graphs produced by the package applications (note that the same rule may be applied more than once in a given graph). Each item of the list is an object with the following fields:

 * `conll`: the graph obtained after one or several applications of the rules.
 * `sample_id`
 * `sent_id`
 * `user_id`
 * `modified_edges` with source id, new label and target_id
 * `modified_nodes` with the id of the node and the list of features modified by the rule

Below, an example of output after a rewrite with the two rules:

* `pattern { N [upos=VERB] } commands { N.upos=V }`
* `pattern { e: N -[nsubj]-> M } commands { del_edge e; add_edge N -[NSUBJ]-> M }`

{{< input file="static/usage/grew_server/_build/output.conllu" >}}

and the output data returned by the service (with CoNLL code skipped): 

{{< json file="/static/usage/grew_server/_build/output.json" >}}













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

See [here](#sample_ids) for the usage of `sample_ids` argument.

The service returns an URL on a file containing the "export" of the project. In the export:
  * only graphs in the project with a `timestamp` numerical metadata are present
  * if several graphs share the same `sent_id`, keep only the graph with the highest `timestamp`

---

## Get the lexicon computed from a treebank

  * `(<string> project_id, <string> user_ids, <string> sample_ids, <string> features)`
  * `(<string> project_id, <string> user_ids, <string> sample_ids, <string> features, <int> prune)`

See [here](#generic-arguments-usage) for the usage of `sample_ids` and `user_ids` arguments.
The string `features` must be a JSON encoding of a list of strings (ex: `["form", "lemma", "upos", "Gender"]`).

The service returns a JSON data of the lexicon computed form the given corpora.

The output is a list of objects. 
Each object contains two fields:
   * `feats`: an object whose keys follow `features` argument (value are `string` or `null`)
   * `freq`: an `int` giving the frequency of the lexical item

If the `prune` integer argument is set as `n`, only the subset of unambiguous structure at depth `n` is reported.
    For instance, if the keys are `["form", "lemma", "upos", "Gender", "Number"]`,
    the pruning at level 3 will keep only lexicon entries where there is 
    more than one couple of value for `Gender` and `Number` with the same triple `(form, lemma, upos)`.

#### Exemple

with a corpus containing the following sentence:

```
1	moule	moule	NOUN	_	Gender=Fem|Number=Sing	_	_	_	_
2	moule	moule	NOUN	_	Gender=Fem|Number=Sing	_	_	_	_
3	moule	moule	NOUN	_	Gender=Masc|Number=Sing	_	_	_	_
4	maison	maison	NOUN	_	Gender=Fem|Number=Sing	_	_	_	_
5	maison	maison	NOUN	_	Gender=Fem|Number=Sing	_	_	_	_
6	souris	souris	NOUN	_	Gender=Fem	_	_	_	_
7	souris	souris	NOUN	_	Gender=Fem|Number=Plur	_	_	_	_
```


The `getLexicon` with features `["form", "lemma", "upos", "Gender", "Number"]` returns the JSON below (note the second line where the value associated with `Number` is `null`):

```
[
  { "feats": { "form": "souris", "lemma": "souris", "upos": "NOUN", "Gender": "Fem", "Number": "Plur" }, "freq": 1 },
  { "feats": { "form": "souris", "lemma": "souris", "upos": "NOUN", "Gender": "Fem", "Number": null }, "freq": 1 },
  { "feats": { "form": "moule", "lemma": "moule", "upos": "NOUN", "Gender": "Masc", "Number": "Sing" }, "freq": 1 },
  { "feats": { "form": "moule", "lemma": "moule", "upos": "NOUN", "Gender": "Fem", "Number": "Sing" }, "freq": 2 },
  { "feats": {  "form": "maison", "lemma": "maison", "upos": "NOUN", "Gender": "Fem", "Number": "Sing" }, "freq": 2 }
]
```

and with the additional argument `prune` with value 3, the line about `maison` is not returned because the triple `(maison, maison, NOUN)` is associated with only one line in the previous structure.

```
[
  { "feats": { "form": "souris", "lemma": "souris", "upos": "NOUN", "Gender": "Fem", "Number": "Plur" }, "freq": 1 },
  { "feats": { "form": "souris", "lemma": "souris", "upos": "NOUN", "Gender": "Fem", "Number": null }, "freq": 1 },
  { "feats": { "form": "moule", "lemma": "moule", "upos": "NOUN", "Gender": "Masc", "Number": "Sing" }, "freq": 1 },
  { "feats": { "form": "moule", "lemma": "moule", "upos": "NOUN", "Gender": "Fem", "Number": "Sing" }, "freq": 2 },
]
```


---

## Get tagset or features from a treebank
See [here](#sample_ids) for the usage of `sample_ids` argument.

### The `getPOS` service
  * `(<string> project_id, <string> sample_ids)`

returns the list of POS (`upos` feature) used in the data.

### The `getRelations` service
  * `(<string> project_id, <string> sample_ids)`

returns the list of relations used in the data/

### The `getFeatures` service
  * `(<string> project_id, <string> sample_ids)`

returns the list of feature names used in the data.

---
---

# Generic arguments usage

## `sample_ids`

Several services use a `string` argument named `sample_ids`.
The string `sample_ids` must be a JSON encoding of a list of strings (like `["sample_1", "sample_2"]`).

  * If the `sample_ids` list is not empty, only sentences from a `sample_id` in the list are considered.
  * If the `sample_ids` list is empty, all sentences are considered.

:warning: If the list contains an unused `sample_id`, no error is returned and the `sample_id` is ignored.

## `user_ids`

The ways `user_ids` is parsed was changed ([commit](https://gitlab.inria.fr/grew/grew_server/-/commit/1b61650dcdb42cb00f524775c4fe8829cd6aeaae)).
The string `user_ids` must be a JSON encoding of one of these forms:

  * The string `"all"`: all users are taken into account for each sentence
  * The object `{ "multi" : ["user_1", "user_2", …] }`: all users explicitly mentioned in the list are taken into account for each sentence
  * The object `{ "one" : ["user_1", "user_2", …] }`: for each sentence, only one graph (at most) is returned; the one for the first user of the list for which the graph is defined. In the list, the pseudo-user `__last__` can be used. It selects the graph with the most recent timestamp.

This parameter is used for the 3 services:
 * `searchPatternInGraphs`
 * `getLexicon`
 * `tryPackage`: in this case, only the value `{ "one" : […] }` is accepted in order to ensure that only at most one new graph can be returned for each sentence.

This fulfils the request [#110](https://github.com/Arborator/arborator-frontend/issues/110):

> * See for my trees &rarr; `{ "one" : ["current_user"] }` (or `{ "multi" : ["current_user"] }` which has the same meaning)
> * See for my trees or last tree (only one user_id per tree is returned) &rarr; `{ "one" : ["current_user", "__last__"] }`
> * See last trees &rarr; `{ "one" : ["__last__"] }`
> * See trees from everyone &rarr; `"all"`
> * See trees for users in a given list &rarr; `{ "multi" : ["user_1", "user_2", …] }`

---
---


# DEV

The following updates are already available on the DEV server and will be available in PROD after testing.

## [5aebc293](https://gitlab.inria.fr/grew/grew_server/-/commit/5aebc29314ded7b3a8653734fdf6adce9be11a73): remove deprecated handling of `user_ids`

The previous behaviour of `user_ids` is removed.
Here is the mapping from previous representation to new one:
 - `[]` &rarr; `"all"`
 - `["__last__"]` &rarr; `{ "one": ["__last__"] }`
 - `["user_1", "user_2"]` &rarr; `{ "multi": ["user_1", "user_2"] }`

## [aa8e97a5](https://gitlab.inria.fr/grew/grew_server/-/commit/aa8e97a5c4b4a1f0cecd429f202f67098b999758): Add a new field `tree_by_user` in `getSamples` output

[#206](https://github.com/Arborator/arborator-frontend/issues/206):
The `getSamples` contains a new field `tree_by_user` which contains a dictionay mapping `user_id` to the number of trees for the given user.
