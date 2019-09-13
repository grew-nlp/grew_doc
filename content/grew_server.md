+++
Tags = ["Development","golang"]
Description = ""
menu = "main"
Categories = ["Development","GoLang"]
date = "2019-06-01T20:54:20+02:00"
title = "grew_server"

+++

# Use Grew as a server for the Arborator tool

The `grew_server` tool is a web server which manages set of annotated graphs with multiple annotations on the same sentence.
It is built to be used with the Arborator graph annotation tool.

Below, we suppose that the server is available on some `baseURL`.
For testing purpose, a demo server should be available at `http://arborator.grew.fr`.
(:warning: data stored on this server may be lost at any time).

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
 * `{ "status": "WARNING", "messages": …, "data": "…" }` when the request can be partially executed; the `messages` fields contains a list of messages.
 * `{ "status": "ERROR", "message": "…" }` when the request cannot be executed.

## Projects

### The `newProject` service

This service is used to initialise a new empty project. An error is returned if the project already exists.

 * `(<string> project_id)`

### The `getProjects` service

This service returns the list of existing projects.

 * `()`

### The `eraseProject` service

This service is used to remove a project. If the project does not exist, nothing append

 * `(<string> project_id)`

### The `renameProject` service

 * `(<string> project_id, <string> new_project_id)`

## Samples
All services about samples return an error if the requested project does not exist.

### The `newSample` service

This service is used to initialise a new empty sample in a given project.
An error is returned if the sample already exists.

 * `(<string> project_id, <string> sample_id)`

### The `getSamples` service

This service returns the list of existing samples in a given project.

 * `(<string> project_id)`

### The `eraseSample` service

This service is used to remove a sample. If the sample does not exist, nothing append

 * `(<string> project_id, <string> sample_id)`

### The `renameSample` service

 * `(<string> project_id, <string> sample_id, <string> new_sample_id)`

An error is returned either if `sample_id` does not exist or if `new_sample_id` alredy exists in `project_id`.

## Sentences

### The `eraseSentence` service

 * `(<string> project_id, <string> sample_id, <string> sent_id)`

## Graphs

### The `eraseGraph` service

 * `(<string> project_id, <string> sample_id, <string> sent_id, <string> user_id)`

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

## Save annotations

### The `saveConll` services

 * `(<string> project_id, <string> sample_id, <string> sent_id, <string> user_id, <file> conll_file)`
 * `(<string> project_id, <string> sample_id, <string> sent_id, <file> conll_file)`
 * `(<string> project_id, <string> sample_id, <string> user_id, <file> conll_file)`
 * `(<string> project_id, <string> sample_id, <file> conll_file)`
 * `(<string> project_id, <file> conll_file)`

### The `saveGraph` service

 * `(<string> project_id, <string> sample_id, <string> sent_id, <string> user_id, <string> conll_graph)`


## Search with Grew patterns

### The `searchPatternInSentences` service

 * `(<string> project_id, <string> pattern)`
 returns a list of dict `{'sample_id':…, 'sent_id':…, 'nodes':…, 'edges':…}`

### The `searchPatternInGraphs` service

 * `(<string> project_id, <string> pattern)`
 returns a list of dict `{'sample_id':…, 'sent_id':…, 'user_id':…, 'nodes':…, 'edges':…}`
