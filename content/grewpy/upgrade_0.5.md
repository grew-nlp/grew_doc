---
title: "Grewpy • Upgrade to 0.5"
date: 2024-05-06
---

# ⚠️ Howto to upgrade to grewpy 0.5

In release 0.5, the implementation of the `Request` class has been updated.

The two changes that require code updates are described below.

## 1) Deprecated function `Request.parse`
The `Request.parse` function is now deprecated. It still works in the version 0.5, with a deprecated message. It will be removed in a future release.

With the new version, the same argument (following the syntax used in Grew-match or in the request part of rules in Grew) can be used directly to build the corresponding request.

The table below describes the main changes required to existing code:

| Version < 0.5.0 | Version ≥ 0.5.0 |
|-----------------|-----------------|
| `Request.parse ("pattern { X -> Y } without { X[upos=VERB] }")` | `Request("pattern { X -> Y } without { X[upos=VERB] }")` |

## 2) Build a request from a string

As a consequence of the previous point, the previous way f building a request from a clause or a clause list is no longer available.
The easier way to patch the code is to start with an empty request with `Request()` and to append clauses with the `pattern` method.

The table below describes the main changes required to existing code:

| Version < 0.5.0 | Version ≥ 0.5.0 |
|-----------------|-----------------|
| `Request ("X -[subj]-> Y", "X[upos=VERB]")` | `Request().pattern("X -[subj]-> Y; X[upos=VERB]")`or</br>`Request().pattern("X -[subj]-> Y", "X[upos=VERB]")` |


