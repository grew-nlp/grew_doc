+++
Description = ""
Tags = ["Development", "golang"]
Categories = ["Development", "GoLang"]
menu = "main"
+++

# Grew-count web service

The **Grew-count** web service is available on http://count.grew.fr.

With the **Grew-count** web service, it is possible to send a list of **Grew** requests and a list of corpora and to get a TSV file with the number of occurrences of each request in each corpus.
Corpora available are ones which are used in Grew-match.

Note that if you want to run similar requests on your onw data, you should consider using the [grewpy](../python) library: see an example [here](../../grewpy/multi_corpora_counting).


---

## The `count` service

The URL of the main service is http://count.grew.fr/count and it must be called with two POST parameters: `corpora` and `requests`.

The `corpora` parameter must be a JSON string describing a list of corpora. For instance:

```json_alt
[
  "SUD_French-PUD@2.15",
  "SUD_English-PUD@2.15"
]
```

The available corpora are the same as the ones available on **[Grew-match](http://match.grew.fr)**, with the same identifiers.

The `requests` parameter must be a JSON string describing a dictionary of requests. For instance:

```json_alt
{
  "sv": "pattern { V -[subj]-> S; S << V }",
  "vs": "pattern { V -[subj]-> S; V << S }"
}
```

Again, the requests are the same as the ones available on **[Grew-match](http://match.grew.fr)**.
requests syntax can be learned through **Grew-match**'s [tutorial](http://match.grew.fr?tutorial=yes) and some documentation is available on the [request page](../../doc/request).

---

## The `set_config` service

If you want to run requests on UD or SUD data, you should first run the service.
For instance from Python: 
```python_alt
# Set the config to "UD"
url = "http://count.grew.fr/count"
requests.request("POST", f'{url}/set_config', data={'config': 'ud'})
```

---

## Example of usage with Python

The web service can be called with Python's `requests` library.
The code below ([Download](count_test.py)) shows a way to call the web service with the two requests above and with the 20 PUD corpora of SUD 2.14.

{{< python file="static/usage/grew_count/count_test.py" >}}

The script should produce, the following TSV file:

{{< input file="static/usage/grew_count/_build/out.tsv" >}}
