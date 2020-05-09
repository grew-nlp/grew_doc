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

  * One pattern describing the part of graph to match (see [pattern page](../pattern)) and on which commands will be applied, introduced by the keyword `pattern`
  * A set of negative clauses to filter out unwanted occurrences of the pattern, each clause being introduced by the keyword `without`
  * One sequence of commands to apply (see [commands page](../commands)), introduced by the keyword `commands`

## Example

{{< grew file="/static/rule/accuser.grs" >}}

# Using lexicons in Grew rules

:warning: The syntax described below was introduced in version 1.0.
See "[About new lexical rules syntax](../lexicons_change)" for more details. :warning:

**Grew** rules can be parametrized by one or several lexicons.

## Lexicon
A lexicon is defined by:

  * a list in *n* different field identifiers
  * a list of lexicon items, each item is a *n*-tuple

For instance, the table below describes a tiny lexicon for French nouns where each noun is associated with its gender.

| noun   | Gender |
|--------|--------|
| garçon | Masc   |
| maison | Fem    |

A lexicon is written as text where:

 * Blank lines and lines starting with `%` symbol are ignored
 * Each line is a list of elements separated by tabulations.
 * The first line defines the field  identifiers.
 * All other lines define the lexicon items that are n-tuples of strings.
 * All lines contain the same number of elements.

The lexicon above can be then written in the file [`nouns.lex`](../rule/nouns.lex)
{{< grew file="/static/rule/nouns.lex" >}}

## Lexical rule

A rule can be parametrized by a lexicon.
The rule below adds a new feat `Gender` with the relevant value when the noun is found in the lexicon.
Note that the lexicon is named in the rule (`lex` in the example), this will allow us to use several lexicons in the same rule.

~~~grew
rule set_gender (lex from "nouns.lex") {
  pattern { N [upos=NOUN, !Gender, lemma=lex.noun] }
  commands { N.Gender = lex.Gender }
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

The file [`set_gender.py`](../rule/set_gender.py) below presents a self-contained example of rewriting with the lexical rule above.
It supposes that the grew Python library is installed (see [Installation page](../install)).

:warning: The tabulation is not well interpreted when using copy/paste into interactive Python session.
That's why tabulations are replaced by explicit `\t` in the Python code below.

{{< python file="/static/rule/set_gender.py" >}}

## Using several lexicons

The file [`obl_loc.grs`](../rule/obl_loc.grs) below defines a rule which changes the relation `obl` into `obl:loc` when both the verb and the preposition are controled by lexicons.
{{< grew file="/static/rule/obl_loc.grs" >}}

The file [`max.conll`](../rule/max.conll) contains the following sentence:

![Max](/rule/max.svg)

With the command `grew transform -grs obl_loc.grs -strat "Onf(obl_loc)" -i max.conll -o max_loc.conll`, the rule above is applied twice and produces the next graph:

![Max_loc](/rule/max_loc.svg)

## Using twice the same lexicon

If the file [`transitive_verbs.lex`](/rule/transitive_verbs.lex) contains a list of transitive verbs, the following rule distributes the `obj` relation when two transitive verbs are coordinated.

{{< grew file="/static/rule/transitive_coord.grs" >}}

This rule can be used to turn the left part below into the right part:

| ![pomme](/rule/pomme.svg) | ![pomme_enhanced](/rule/pomme_enhanced.svg) |
|:---:|:---:|



