+++
Description = ""
Tags = ["Development", "golang"]
Categories = ["Development", "GoLang"]
menu = "main"
+++

# Grew-count web service

The **Grew-count** web service is available on http://count.grew.fr.
It is still in development and it may evolve in the near future.

With the **Grew-count** web service, it is possible to send a list of **Grew** patterns and a list of corpora and to get a TSV file with the number of occurrences of each pattern in each corpus.

---

## The `count` service

The URL of the main service is http://count.grew.fr/count and it must be called with two POST parameters: `corpora` and `patterns`.

The `corpora` parameter must be a JSON string describing a list of corpora. For instance:

```json_alt
[
  "SUD_French-PUD@2.7",
  "SUD_English-PUD@2.7"
]
```

The available corpora are the same as the ones available on **[Grew-match](http://match.grew.fr)**, with the same identifiers.

The `patterns` parameter must be a JSON string describing a dictionary of patterns. For instance:

```json_alt
{
  "sv": "pattern { V -[subj]-> S; S << V }",
  "vs": "pattern { V -[subj]-> S; V << S }"
}
```

Again, the patterns are the same as the ones available on **[Grew-match](http://match.grew.fr)**.
Patterns syntax can be learned through **Grew-match**'s [tutorial](http://match.grew.fr?tutorial=yes) and some documentation is available on the [pattern page](../../doc/pattern).

---

## Example of usage with Python

The web service can be called with Python's `requests` library.
The code below ([Download](count_test.py)) shows a way to call the web service with the two patterns above and with the 20 PUD corpora of SUD 2.7.

{{< python file="static/usage/grew_count/count_test.py" >}}

The script should produce, the following TSV file:

{{< input file="static/usage/grew_count/_build/out.tsv" >}}