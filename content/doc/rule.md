+++
Description = ""
date = "2017-05-23T15:18:57+02:00"
title = "Rules"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
+++

# Basic Grew rules

A **rewrite rule** in **Grew** is defined by:

  * A request (see [request](../request) for a complete doc) composed of:
    * One item (introduced by the keyword `pattern`) describing the part of graph to match and on which commands will be applied, 
    * A set of negative (or positive) filtering items to filter out unwanted occurrences of the request, each clause being introduced by the keyword `without` (or `with`)
  * A sequence of commands to apply (see [commands page](../commands)), introduced by the keyword `commands`

## Example

Here is an example of rule taken from a gallery page (see [this gallery example for an explanation](../../gallery/flat)).

{{< grew file="/static/doc/rule/example.grs" >}}

# Avoiding Looping Rules

One of the most common problems we can have when using Grew rules is the fact that the rule starts an infinite loop.

For example, the rule `tv` below add a feature `Transitive = Yes` on the verb when there is a `comp:obj` relation from this verb to a noun.

```grew
rule tv {
  pattern { X[upos=VERB]; Y[upos=NOUN|PROPN|PRON]; X-[comp:obj]->Y }
  commands { X.Transitive = Yes }
}
```

This rule must to be applied iteratively to correctly handle a sentence with more than one transitive verb with a strategy:
```grew
strat main { Onf (tv) }
```

In this case, you will get very soon the error message:
```
"More than 10000 rewriting steps: check for loops or increase max_rules value. Last rules are: […tv, tv, tv, tv, tv, tv, tv, tv, tv, tv]"
```

This is because there is nothing to prevent the rule from being applied again to the same node after a first application.
To avoid this, a `without` clause can be added.

```grew
rule tv {
  pattern { X[upos=VERB]; Y[upos=NOUN|PROPN|PRON]; X-[comp:obj]->Y }
  without { X[Transitive = Yes] }
  commands { X.Transitive = Yes }
}
```

See also the [tutorial page about termination](../../tutorial/04_termination) for more details.

# Using lexicons in Grew rules

**Grew** rules can be parametrised by one or several lexicons.

## Lexicon
A lexicon is defined by:

  * a list of *n* different field identifiers
  * a list of lexicon items, each item is a *n*-tuple

For instance, the table below describes a tiny lexicon for French nouns where each noun is associated with its gender.

| noun   | Gender |
|--------|--------|
| garçon | Masc   |
| maison | Fem    |

A lexicon is written as text where:

 * Blank lines and lines starting with `%` symbol are ignored
 * Each line is a list of elements separated by tabulations
 * The first line defines the field  identifiers
 * All other lines define the lexicon items that are *n*-uples of strings.
 * All lines must contain the same number of elements.

The lexicon above can be then written in the file [`nouns.lex`](nouns.lex)
{{< grew file="/static/doc/rule/nouns.lex" >}}

## Lexical rule

A rule can be parametrised by a lexicon.
The rule below adds a new feat `Gender` with the relevant value when the noun is found in the lexicon.
Note that the lexicon is named in the rule (`lex` in the example), this will allow us to use several lexicons in the same rule.

~~~grew
rule set_gender (lex from "nouns.lex") {
  pattern { X [upos=NOUN, !Gender, lemma=lex.noun] }
  commands { X.Gender = lex.Gender }
}
~~~

Once the lexicon `lex` is declared, the syntax `lex.ident` can be used to refer to lexical items in any place where a feature value can be used in the rule definition.

When a lexicon is short and specific to one rule, it may be painful to put it in a new file.
In this case, an alternative syntax is proposed: the lexicon is defined directly at the end of the rule definition.
The rule above can be written:

~~~grew
rule set_gender {
  pattern { N [upos=NOUN, !Gender, lemma=lex.noun] }
  commands { N.Gender = lex.Gender }
}
#BEGIN lex
noun	Gender
%-------------
garçon	Masc
maison	Fem
#END
~~~

### Try it!

The file [`set_gender.py`](set_gender.py) below presents a self-contained example of rewriting with the lexical rule above.
It supposes that the grew Python library is installed (see [Installation page](../../usage/python)).

:warning: The tabulation is not well interpreted when using copy/paste into interactive Python session.
That's why tabulations are replaced by explicit `\t` in the Python code below.

{{< python file="/static/doc/rule/set_gender.py" >}}

The code above outputs the following structure where the two nouns have their gender values.

![with_gender](/doc/rule/_build/with_gender.svg)

## Using several lexicons

The file [`obl_loc.grs`](obl_loc.grs) below defines a rule which changes the relation `obl` into `obl:loc` when both the verb and the preposition are controlled by lexicons.
{{< grew file="/static/doc/rule/obl_loc.grs" >}}

The file [`max.conll`](max.conll) contains the following sentence:

![Max](/doc/rule/_build/max.svg)

With the command `grew transform -grs obl_loc.grs -strat "Onf(obl_loc)" -i max.conll`, the rule above is applied twice and produces the next graph:

![Max_loc](/doc/rule/_build/max_loc.svg)

## Using twice the same lexicon

If the file [`transitive_verbs.lex`](transitive_verbs.lex) contains a list of transitive verbs, the following rule distributes the `obj` relation when two transitive verbs are coordinated.

{{< grew file="/static/doc/rule/transitive_coord.grs" >}}

This rule can be used to turn the left part below into the right part:


| ![pomme](/doc/rule/_build/pomme.svg) | ![pomme_enhanced](/doc/rule/_build/pomme_enhanced.svg) |
|:---:|:---:|



