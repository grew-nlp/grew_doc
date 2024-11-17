+++
Description = ""
Tags = ["Development", "golang"]
Categories = ["Development", "GoLang"]
menu = "main"
+++

# Example of non-deterministic rewriting with `Iter`

With the grs file [iter_package.grs](../iter/iter_package.grs):

{{< grew file="/static/gallery/iter/iter_package.grs" >}}

applied to a two nodes graph `AB`, four different output graphs are produced because there are two places where the rewriting is non-deterministic and with two alternatives in both places.

| Input | Output 0 | Output 1 | Output 2 | Output 3 |
|-|-|-|-|-| 
| ![input](/gallery/iter/_build/input.svg) | ![output_0](/gallery/iter/_build/output__0.svg) | ![output_1](/gallery/iter/_build/output__1.svg) | ![output_2](/gallery/iter/_build/output__2.svg) | ![output_3](/gallery/iter/_build/output__3.svg) |

{{< tryit "https://web.grew.fr/?corpus=https://grew.fr/gallery/iter/input.json&grs=https://grew.fr/gallery/iter/iter_package.grs" >}} in Grew-web.

## Similar example with lexical non deterministic rule

With the grs file [iter_rule.grs](../iter/iter_rule.grs):

{{< grew file="/static/gallery/iter/iter_rule.grs" >}}

we observe the same rewriting process as above: {{< tryit "https://web.grew.fr/?corpus=https://grew.fr/gallery/iter/input.json&grs=https://grew.fr/gallery/iter/iter_rule.grs" >}} in Grew-web.

