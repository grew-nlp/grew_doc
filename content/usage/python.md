+++
Description = ""
date = "2017-02-28T14:58:11+01:00"
title = "python"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
+++

# Grew • Python library

Examples below are taken from first chapter of the book [*Application of Graph Rewriting to Natural Language Processing*](https://www.wiley.com/en-fr/Application+of+Graph+Rewriting+to+Natural+Language+Processing-p-9781119522348).
This chapter can be [downloaded in PDF from the editor website](https://media.wiley.com/product_data/excerpt/66/17863009/1786300966-587.pdf).

Since section 1.5, examples given use the Grew Python library.
If necessary, follow [installation page](../install).

:warning: Make sure that your version of `grewpy` and of the `grew` Python lib are updated.

## 1.1. Creating a graph

Create an empty graph:

```python_alt
g = dict()
```
---

Add a node `W1` labelled _the_ to `g`:

```python_alt
g['W1'] = ('the', [])
```
---

Add a second and a third node, with the edges which connect them

```python_alt
g['W2'] = ('child', [])
g['W3'] = ('plays', [])
g['W3'][1].append(('suj', 'W2'))
g['W2'][1].append(('det', 'W1'))
```
---

Print the result

```python_alt
g
```

```
{'W2': ('child', [('det', 'W1')]), 'W3': ('plays', [('suj', 'W2')]), 'W1': ('the', [])}
```

![thechildplays](/usage/python/_build/thechildplays.svg)

---
Define construction functions
```python_alt
def add_node(g, u, a):
  #Add a node u labeled a in graph g
  g[u] = (a, [])

def add_edge(g, u, e, v):
  # Add an edge labeled e from u to v in graph g
  if (e, v) not in g[u][1]:
    g[u][1].append( (e, v) )
```

---
add two more nodes
```python_alt
add_node(g, 'W4', 'the')
add_node(g, 'W5', 'fool')
add_edge(g, 'W3', 'obj', 'W5')
add_edge(g, 'W5', 'det', 'W4')
```

![thechildplays](/usage/python/_build/thechildplaysthefool.svg)

---
Using NLTK to build a flat graph (See [NLTK installation page](http://www.nltk.org/install.html) if necessary)

```python_alt
import nltk
word_list = nltk.word_tokenize("She takes a glass")
word_graph = dict()
for i in range(len(word_list)):
    add_node(word_graph, 'W%s' %  i, word_list[i])

for i in range(len(word_list) - 1):
    add_edge(word_graph, 'W%s' % i, 'SUC', 'W%s' % (i + 1))

word_graph
```

```
{'W2': ('a', [('SUC', 'W3')]), 'W0': ('She', [('SUC', 'W1')]), 'W3': ('glass', []), 'W1': ('takes', [('SUC', 'W2')])}
```
![thechildplays](/usage/python/_build/sheistakingaglass.svg)

## 1.2. Features structures

Build a feature structure

```python_alt
fs_plays = {'phon' : 'plays', 'cat' : 'V'}
```

---
and read in it
```python_alt
fs_plays['cat']
```

```
'V'
```

---
Rebuild previous example with feature structures

```python_alt
g = dict()
add_node(g, 'W1', {'phon' : 'the', 'cat' : 'DET'} )
add_node(g, 'W2', {'phon' : 'child', 'cat' : 'N'} )
add_node(g, 'W3', {'phon' : 'plays', 'cat' : 'V'} )
add_node(g, 'W4', {'phon' : 'the', 'cat' : 'DET'})
add_node(g, 'W5', {'phon' : 'fool', 'cat' : 'N'})
add_edge(g, 'W2', 'det', 'W1')
add_edge(g, 'W3', 'suj', 'W2')
add_edge(g, 'W3', 'obj', 'W5')
add_edge(g, 'W5', 'det', 'W4')
```

![thechildplaysthefool_fs](/usage/python/_build/thechildplaysthefool_fs.svg)


---
Use the basic POS-tagger provided with NLTK
```python_alt
import nltk
word_list = nltk.word_tokenize("She takes a glass")
tag_list = nltk.pos_tag(word_list)
feat_list = [{'phon':n[0], 'cat':n[1]} for n in tag_list]
t_graph = {'W%s' % i : (feat_list[i], []) for i in range(len(tag_list))}
for i in range(len(tag_list)-1):
    add_edge(t_graph, 'W%s' % i, 'SUC', 'W%s' % (i+1))

t_graph
```

```
{'W2': ({'phon': 'a', 'cat': 'DT'}, [('SUC', 'W3')]), 'W0': ({'phon': 'She', 'cat': 'PRP'}, [('SUC', 'W1')]), 'W3': ({'phon': 'glass', 'cat': 'NN'}, []), 'W1': ({'phon': 'takes', 'cat': 'VBZ'}, [('SUC', 'W2')])}
```

![sheistakingaglass_nltk](/usage/python/_build/sheistakingaglass_nltk.svg)

## 1.3. Information searches

Find the label or feature structure of a node
```python_alt
g['W4'][0]
```

```
{'phon': 'the', 'cat': 'DET'}
```

---

Functions to get label or the list of successors
```python_alt
def get_label(g, u):
    return g[u][0]

def get_sucs(g, u):
    return g[u][1]
```

### 1.3.1. Access to nodes

Get the list of nodes identifiers
```python_alt
nodes = g.keys()
```
---

Get the list of verbs
```python_alt
verbs = []
for u in nodes:
  if get_label(g, u)['cat'] == 'V':
      verbs.append(u)
```
---

or, with comprehension
```python_alt
verbs =  [ u for u in g if get_label(g, u)['cat'] == 'V' ]
```

### 1.3.2. Extracting edges

Get the list of edges
```python_alt
triplets = [ (s, e, t) for s in g for (e, t) in get_sucs(g, s) ]
```

---
or the same with a loop:
```python_alt
triplets = []
for s in g:
  for (e, t) in get_sucs(g, s):
    triplets.append( (s, e, t) )
```

---
Extract the pairs of nodes linked by a subject relationship
```python_alt
subject_verbs = [ (s, v) for (v, e, s) in triplets if e=='suj' ]
```

---
A function to check if there is an edge between two nodes `u` and `v`
```python_alt
def are_related(g, u, v):
  triplets = [(s, e, t) for s in g for (e, t) in get_sucs(g, s)]
  for (s, e, t) in triplets:
    if (s, t) == (u, v):
      return True
  return False
```

---
Check if a node is a root node (i.e. whitout incomoing edge)
```python_alt
def is_root(g, u):
  triplets = [(s, e, t) for s in g for (e, t) in get_sucs(g, s)]
  for (s, e, t) in triplets:
    if t == u:
      return False
  return True
```

## 1.4. Recreating an order

Using the convention explained in the book, we can reconstruct the sentence corresponding to a graph using the following function

```python_alt
def get_phonology(g):
    def get_idx(node): #gets the float after 'W' in node if any
        import re #for regular expressions
        word_id = re.search(r'W(\d+(\.\d+)?)', node)
        return word_id.group(1) if word_id else None
    words = {get_idx(node) : get_label(g, node)['phon']
                        for node in g if get_idx(node)}
    return ' '.join([ words[idx] for idx in sorted(words)])

get_phonology(g)
```

```
'the child plays the fool'
```

## 1.5. Using patterns with the Grew library
To run the next part of the chapter, the **Grew** library must be imported and the **Grew** tool must be started.
The two next lines are then required:

```python_alt
import grew
grew.init()
```

---

Build a graph with Grew syntax
```python_alt
g = grew.graph('''graph {
  W1 [phon="the", cat=DET];
  W2 [phon="child", cat=N];
  W3 [phon="plays", cat=V];
  W4 [phon="the", cat=DET];
  W5 [phon="fool", cat=N];
  W2 -[det]->W1;
  W3 -[suj]->W2;
  W3 -[obj]->W5;
  W5 -[det]->W4;
}''')
```

![thechildplaysthefool_fs](/usage/python/_build/thechildplaysthefool_fs.svg)
---

Search for a specific pattern;
each line below can be executed separately.

```python_alt
grew.search ("pattern { X[cat=V] }", g)
grew.search ("pattern { X[cat=DET] }", g)
grew.search ("pattern { X[cat=ADJ] }", g)
grew.search ("pattern { X[cat=V]; Y[]; X -[suj]-> Y }", g)
grew.search ("pattern { X[cat=V]; X -[suj]-> Y }", g)
grew.search ("pattern { X[cat=V]; e:X -[suj]-> Y }", g)
grew.search ("pattern { X[] } without { *->X }", g)
```


### 1.5.2 Common pitfalls

#### 1.2.5.1. Multiple choice edge searches
```python_alt
g0 = grew.graph('''graph {
  W1 [phon=ils, cat=PRO];
  W2 [phon="s'", cat=PRO];
  W3 [phon=aiment, cat=V];
  W3 -[suj]-> W1;
  W3 -[obj]-> W1;
}''')
```
![ilssaiment](/usage/python/_build/ilssaiment.svg)

---
```python_alt
grew.search ("pattern { X -[suj|obj]-> Y }", g0)
```

```
[{'__e_2__': 'W3/suj/W1', 'X': 'W3', 'Y': 'W1'}, {'__e_2__': 'W3/obj/W1', 'X': 'W3', 'Y': 'W1'}]
```

#### 1.5.2.2. Anonymous nodes
```python_alt
m1 = 'pattern{ P[phon="en",cat=P]; V[cat=V]; V-[obj]-> *}'
m2 = 'pattern{ P[phon="en",cat=P]; V[cat=V]; V-[obj]-> O}'
```


---
```python_alt
g1 = grew.graph('''graph{
W1 [phon="en", cat=P];
W2 [phon="prend", cat=V];
W2 -[obj]->W1;
}''')
```
![enprend](/usage/python/_build/enprend.svg)


---
```python_alt
grew.search(m1, g1)
grew.search(m2, g1)
```


---
```python_alt
g2 = grew.graph('''graph{
W1 [phon="en", cat=P];
W2 [phon="connait", cat=V];
W3 [phon="la", cat=Det];
W4 [phon="fin", cat=N];
W2 -[det]->W3;
W2 -[mod]->W1;
W2 -[obj]->W4;
}''')
```
![enconnaitlafin](/usage/python/_build/enconnaitlafin.svg)


---
```python_alt
grew.search(m1, g2)
grew.search(m2, g2)
```


#### 1.5.2.3. Multiple `without` clauses

```python_alt
g3 = grew.graph('''graph{
  W1 [phon=John, cat=NP];
  W2 [phon=reads, cat=V ];
  W3 [phon=the, cat=Det];
  W4 [phon=book, cat=N];
  W2 -[suj]-> W1;
  W2 -[obj]-> W4;
  W4 -[det]-> W3;
}''')

g4 = grew.graph('''graph{
  W1 [phon=John, cat=NP];
  W2 [phon=reads, cat=V ];
  W3 [phon=the, cat=Det];
  W4 [phon=book, cat=N];
  W5 [phon=today, cat=ADV];
  W2 -[suj]-> W1;
  W2 -[obj]-> W4;
  W4 -[det]-> W3;
  W2 -[mod]-> W5;
}''')
```

| ![johnreadsthebook](/usage/python/_build/johnreadsthebook.svg) | ![johnreadsthebooktoday](/usage/python/_build/johnreadsthebooktoday.svg) |
|:---:|:---:|


```python_alt
m3 = "pattern{Y-[suj]->X} without{Y-[obj]->Z; Y-[mod]->T}"
m4 = "pattern{Y-[suj]->X} without{Y-[obj]->Z} without{Y-[mod]->T}"
```

```python_alt
grew.search(m3, g3)
grew.search(m4, g3)
grew.search(m3, g4)
grew.search(m4, g4)
```

#### 1.5.2.4. Double negations
```python_alt
g5 = grew.graph('''graph{
  W1 [phon=dors, cat=V, m=imp];
  W2 [phon="!", cat=PONCT];
}''')
```
![dors](/usage/python/_build/dors.svg)

```python_alt
m5 = "pattern { X[cat=V, t=fut] }"
m6 = "pattern { X[cat=V] } without{ X[t<>fut] }"
```

```python_alt
grew.search(m5, g5)
grew.search(m6, g5)
```


#### 1.5.2.5. Double edges
```python_alt
g0 = grew.graph('''graph {
  W1 [phon=ils, cat=PRO];
  W2 [phon="s'", cat=PRO];
  W3 [phon=aiment, cat=V];
  W3 -[suj]-> W1;
  W3 -[obj]-> W1;
}''')
```
![ilssaiment](/usage/python/_build/ilssaiment.svg)

---

```python_alt
grew.search("pattern { e : X -> Y ; f : X -> Y }", g0)
```

## 1.6. Graph rewriting

The syntactic structure for a French sentence with a passive agent
```python_alt
g = grew.graph('''graph{
  W1 [phon="John",cat=NP];
  W2 [phon="est",cat=V ];
  W3 [phon="mordu", cat=V, m=pastp];
  W4 [phon="par",cat=P ];
  W5 [phon="le", cat=D];
  W6 [word="chien",cat=NP];

  W3 -[suj]-> W1;
  W3 -[aux.pass]-> W2;
  W3 -[p_obj.agt]-> W4;
  W6 -[det]-> W5;
  W4 -[obj.p]-> W6;
}''')
```
![john_est_mordu_par_le_chien](/usage/python/_build/john_est_mordu_par_le_chien.svg)

---
Example of rule dealing with passive agent

```python_alt
r = """rule passiveAgt {
  pattern {
    V [cat=V, m=pastp];
    V -[aux.pass]-> AUX;
    e: V -[suj]-> SUJ;
    P [phon=par]; V -[p_obj.agt]-> P;
    P -[obj.p]-> A;
} commands {
    del_node P;
    del_node AUX;
    add_edge V -[suj]-> A;
    add_edge V -[obj]-> SUJ;
    del_edge e;
} }"""
```

---
Apply the rule to the graph
```python_alt
grew.run(r, g, 'passiveAgt')
```

```
[{'W5': ('cat="D", phon="le"', []), 'W6': ('cat="NP", word="chien"', [('det', 'W5')]), 'W3': ('cat="V", m="pastp", phon="mordu"', [('obj', 'W1'), ('suj', 'W6')]), 'W1': ('cat="NP", phon="John"', [])}]
```

![john_est_mordu_par_le_chien_2](/usage/python/_build/john_est_mordu_par_le_chien_2.svg)

### 1.6.2. From rules to strategies

In order to run examples for this section, we put the two rules `passiveAgt` and `du2dele` into the same rewriting system:

```python_alt
rs = grew.grs ("""
rule passiveAgt {
  pattern {
    V [cat=V, m=pastp];
    V -[aux.pass]-> AUX;
    e: V -[suj]-> SUJ;
    P [phon=par]; V -[p_obj.agt]-> P;
    P -[obj.p]-> A;
  }
  commands {
    del_node P;
    del_node AUX;
    add_edge V -[suj]-> A;
    add_edge V -[obj]-> SUJ;
    del_edge e;
  }
}

rule du2dele {
  pattern {
    A [cat="P+D", phon="du"]; N [cat=N];
    A -[obj.p]-> N;
    }
  commands {
    add_node D:> A; D.cat=D ; D.phon="le" ;
    A.cat=P; A.phon="de";
    add_edge N -[det]-> D;
  }
}

strat S1 { du2dele }
""")
```

---

The code for the two French sentences is given below:

  * (1.1) _La porte du jardin du voisin_
  * (1.2) _Le chien du voisin est pris par John_

```python_alt
sent_1_1 = grew.graph('''graph{
  W1 [phon=La, cat=D];
  W2 [phon=porte, cat=N];
  W3 [phon=du, cat="P+D"];
  W4 [phon=jardin, cat=N];
  W5 [phon=du, cat="P+D"];
  W6 [phon=voisin, cat=N];
  W2 -[det]-> W1;
  W2 -[dep]-> W3;
  W3 -[obj.p]-> W4;
  W4 -[dep]-> W5;
  W5 -[obj.p]-> W6;
}''')
```

![porte](/usage/python/_build/porte.svg)


```python_alt
sent_1_2 = grew.graph('''graph{
  W1 [phon=Le, cat=D];
  W2 [phon=chien, cat=N];
  W3 [phon=du, cat="P+D"];
  W4 [phon=voisin, cat=N];
  W5 [phon=est, cat=V];
  W6 [phon=pris, cat=V, m=pastp];
  W7 [phon=par, cat=P];
  W8 [phon=John, cat=N];
  W2 -[det]-> W1;
  W2 -[dep]-> W3;
  W3 -[obj.p]-> W4;
  W6 -[suj]-> W2;
  W6 -[aux.pass]-> W5;
  W6 -[p_obj.agt]-> W7;
  W7 -[obj.p]-> W8;
}''')
```

![lechienduvoisinestmangeparjohn](/usage/python/_build/lechienduvoisinestmangeparjohn.svg)

---

#### Apply one rule to a graph

As the strategy `S1` is defined as one rule `du2dele`, we can apply the rule to the sentence (1.1) with one of the two equivalent commands below:

```python_alt
grew.run(rs,sent_1_1,"S1")
grew.run(rs,sent_1_1,"du2dele")
```

The output contains two graphs resulting of the application of the rule to the first or the second *du* in the sentence.

#### 1.6.2.1. Alternative

```python_alt
grew.run(rs,sent_1_2,"Alt (passiveAgt, du2dele)")
```

#### 1.6.2.2. Sequence

```python_alt
grew.run(rs,sent_1_2,"Seq (du2dele, passiveAgt)")
```

#### 1.6.2.3. Pick

```python_alt
grew.run(rs,sent_1_1,"Pick (S1)")
```

#### 1.6.2.4. Iteration

```python_alt
grew.run(rs,sent_1_1,"Iter (S1)")
```

#### 1.6.2.5. Test
```python_alt
grew.run(rs,sent_1_1,"If(passiveAgt,Seq(passiveAgt, Iter(du2dele)), Iter(du2dele))")
grew.run(rs,sent_1_2,"If(passiveAgt,Seq(passiveAgt, Iter(du2dele)), Iter(du2dele))")
```

#### 1.6.2.6 Try
```python_alt
grew.run(rs,sent_1_1,"Try(passiveAgt)")
grew.run(rs,sent_1_2,"Try(passiveAgt)")
```

### 1.6.3 Using lexicons
This features will be available in an upcoming release of **Grew** which should appear soon!