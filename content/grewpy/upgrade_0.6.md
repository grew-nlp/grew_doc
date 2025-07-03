+++
Description = "About version 0.6"
title = "Grewpy"
+++

# ⚠️ How to to upgrade to grewpy 0.6

Version 0.6 of Grewpy was released on 19 November 2024.
It introduced some major changes, which are described here.
Feel free to [post an issue here](https://github.com/grew-nlp/grewpy/issues) if you need help with the new version.

## Change in the behaviour of request building function

In previous versions (up to 0.5.2), a command like `req.pattern ("X [upos=AUX]")` has two effects:
 - It changes the existing value of the variable `req` by adding a new `pattern` clause to it.
 - It returns the new request (with the new clause).

The same remark applies to the other three methods: `with_`, `without` and `global_`, 

We considered this behaviour to be unexpected and changed it in version 6.0.
Since this version, the new request is returned, but the old variable is not modified.

You will need to check your use of these methods to see if anything in your code should be updated.

If you need to keep the old behaviour, you should replace a code like this:

```python_alt
# In version ≤ 0.5.2
req = Request ("pattern { X -[det]-> Y}")
req2 = req.without_ ("X << Y")  # both req and req2 contain the new value, including the "without"
```

by:

```python_alt
# In version ≥ 0.6.0
req = Request ("pattern { X -[det]-> Y}")
req2 = req.without_ ("X << Y")  # only req2 contains the new value, req is unchanged
req = req2                      # force the req change to new value, to simulate the old behavior
```


## Rename Corpus method `apply` to `map`

The `apply` method is used in `Corpus`, `Grs` and `Graph` to apply a GRS (Graph Rewriting System) to a Corpus or a Graph.
Unfortunately a method with the same name was available in `CorpusDraft` (but it applies a function to each graph).

In version 0.6, the method `apply` of `CorpusDraft` is renamed to `map` to avoid this confusion.

The old name is retained with a deprecation warning and will be removed in a future release.

## Rename Snake Case to Camel Case

The naming of classes and methods was inconsistent.
Since version 0.6, the CamelCase is used systematically.
The following renaming has been done:

 - `Add_edge` &rarr; `AddEdge`
 - `Delete_edge` &rarr; `DeleteEdge`
 - `Delete_feature` &rarr; `DeleteFeature`
 - `Fs_edge` &rarr; `FsEdge`
 - `Grew_web` &rarr; `GrewWeb`

Old names will still be available until a future release with a deprecated warning.

## Method `parse` removed in `GRS`

Deprecated method `parse` removed (see [Howto to upgrade to grewpy 0.5](../upgrade_0.5)).

