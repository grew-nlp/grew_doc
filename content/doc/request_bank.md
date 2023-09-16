+++
title = "request_bank"
+++

# Request bank

⚠️ This page describes a Work In Progress and the info may change in the near future.

In several applications of the Grew matching procedure, we need to define a "list of requests".
The goal of this page is to describe a unified way to describe such a list, which will be called a **request bank** later on.

## Usage of request banks
 - They are used to produce the SUD validation pages (see examples in [French-GSD](https://universal.grew.fr/validator.html?corpus=meta/valid_SUD/SUD_French-GSD@latest.json&top=https://universal.grew.fr/)), where each item in the validation is a Grew request.
 - They are used to produce observation tables, again where a set of requests tries to catch some invalid or inconsistent annotations. See for example the [validation table on Parseme 1.3 data](https://parseme.grew.fr/tables/?data=parseme/valid@1.3).
 - They are used in ArboratorGrew constructicon.

## JSON format for request bank

Request banks are stored in JSON files.
The file must contain a list of dictionaries, each dictionnary describing one request.

A dictionnary for a request must contain the following keys:
 - `id`: an identifier which is unique in the request bank
 - `request`: a JSON encoding of a Grew request (see below)

Other fields may be added for specific usage but they are not mandatory.
Among these optional field, we can have:
 - TODO

## JSON format for request

Depending on the context, there are two different ways to describe a Grew request as a JSON data.

### **Grew-match-like** JSON request

This is an encoding of the string text that appears in the textarea of the Grew-match interface or in rules of a GRS file.
As JSON does not support multiline strings, a multiline request is given as a list of strings.
A few examples of such JSON encodings of request:

```json_alt
"pattern { N[upos=VERB] }"
```

```json_alt
["pattern { N[upos=VERB] }"]
```

```json_alt
["pattern {", "  N[upos=VERB]", "}"]
```

The first two examples just encode the one line request `pattern { N[upos=VERB] }` and the last one a multiline equivalent request:
```grew
pattern { 
  N[upos=VERB] 
}
```

### **grewpy-like** JSON request

When working from **grewpy**, it can be useful to have a more direct access to the internal structure of a request.
A request is then encoded as a list of one-key dictionaries, this key can be: `pattern`, `with`, `without` or `global` and the values are list of clauses.
The example above becomes:

```json_alt
[{"pattern": ["N [upos = VERB]"] }]
```

### A more complex example

The Grew pattern:
```grew
pattern {MWE [label = IAV]}
without {MWE -> V;V[upos=AUX|VERB];MWE -> A;A[upos=ADP]}
```

And the two corresponding JSON versions:

```json_alt
[
  "pattern {MWE [label = IAV]}",
  "without {MWE -> V;V[upos=AUX|VERB];MWE -> A;A[upos=ADP]}"
]
```

```json_alt
[
  {"pattern": [ "MWE [label = IAV]"] },
  {"without": [ "MWE -> V", "V[upos=AUX|VERB]", "MWE -> A", "A[upos=ADP]" ] }
]
```