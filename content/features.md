+++
date = "2018-06-05T11:16:30+02:00"
title = "features"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""

+++

# CoNLL files

The most common way to store dependency structures is the CoNLL format.
Several extension were proposed and we describe here the one which is used by **Grew**, kwown as [CoNLL-U](http://universaldependencies.org/format.html) format defined in the Unverisal Dependency project.  

For each sentence, some metadata are given in lines beginning by `#` followed by one line per lexical unit.
These lines contain 10 fields, separated by tabulations.

Here is an example of CoNLL-U data taken form the corpus `UD_English-PUD` (version 2.1).

```
# sent_id = n01118003
# text = Drop the mic.
1	Drop	drop	VERB	VB	VerbForm=Inf	0	root	_	_
2	the	the	DET	DT	Definite=Def|PronType=Art	3	det	_	_
3	mic	mic	NOUN	NN	Number=Sing	1	obj	_	SpaceAfter=No
4	.	.	PUNCT	.	_	1	punct	_	_
```

We explain here how **Grew** deals with the 10 fields if CoNLL files:

1. **ID**. This field is a number used as an identifier for the corresponding lexical unit (LU).
In Grew, it is available as the feature `position` (most of the times it not useful to use this field, constraints on relative positions can be  expressed with the `<` or `<<` syntax).
2. **FORM**. The phonological form of the LU.
In Grew, the value of this field is available through a feature named `form`
(for backward compatibility, the keyword `phon` can also be used instead of `form`).
3. **LEMMA**. The lemma of the LU. In Grew, this correponds to the feature `lemma`.
4. **UPOS**. The field `upos` (for backward compatibility, `cat` can also be used to refer to this field).
5. **XPOS**. The field `xpos` (for backward compatibility, `pos` can also be used to refer to this field).
6. **FEATS**. List of morphological features.
7. **HEAD**. Head of the current word, which is either a value of ID or `0` for the root node.
8. **DEPREL**. Dependency relation to the HEAD (root iff HEAD = 0).
9. **DEPS**. Enhanced dependency graph in the form of a list of head-deprel pairs. In Grew, the relation are available with the prefix `E:`
10. **MISC**. Any other annotation. In Grew, annotation of the field are accessible with the prefix `_MISC_`.

## Note about backward compatibility
In older versions of Grew (before the definition of the CoNLL-U format), the fields 2, 4 and 5 where accessible with the names `phon`, `cat` and `pos` respectively.
To have a backward compatibility and uniform handling of these fields, the 3 names `phon`, `cat` and `pos` are replaced at parsing time by `form`, `upos` and `xpos`.
As a consequence, it is impossible to use both `phon` and `form` in the same system.
We highly recommend to use only the `form` feature in this setting.
Of course, the same observation applies to `cat` and `upos` (`upos` should be used) and to `pos` and `xpos` (`xpos` should be chosen).