
# Examples from the book "Application of Graph Rewriting to Natural Language Processing"

The page below follows the first chapter which can be [downloaded in PDF from the editor website](https://media.wiley.com/product_data/excerpt/66/17863009/1786300966-587.pdf).

In Chapter 1 of the book (since 1.5), examples given use the Grew Python library.
Here are the necessary steps to run the book's examples.
We suppose that the [installation](../install) was completed and that a Python script is running.


### Note
Code for subsections 1.1 to 1.4 will be added very soon.


## 1.5. Using patterns with the GREW library
To run the next part of the chapter, the grew library must be imported and the grew tool must be started.
The two next lines are then required:

```python
import grew
grew.init()
```


### Build a graph with Grew syntax
```python
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

### Search for a specific pattern
Each line below can be executed separately.

```python
grew.search ("pattern { X[cat=V] }", g)
grew.search ("pattern { X[cat=DET] }", g)
grew.search ("pattern { X[cat=ADJ] }", g)
grew.search ("pattern { X[cat=V]; Y[]; X -[suj]-> Y }", g)
grew.search ("pattern { X[cat=V]; X -[suj]-> Y }", g)
grew.search ("pattern { X[cat=V]; e:X -[suj]-> Y }", g)
grew.search("pattern { X[] } without { *->X }", g)
```


### 1.5.2 Common pitfalls

```python
g0 = grew.graph('''graph {
  W1 [phon=ils, cat=PRO];
  W2 [phon="s'", cat=PRO];
  W3 [phon=aiment, cat=V];
  W3 -[suj]-> W1;
  W3 -[obj]-> W1;
}''')
```

```python
grew.search ("pattern { X -[suj|obj]-> Y }", g0)
```

```python
m1 = 'pattern{ P[phon="en",cat=P]; V[cat=V]; V-[obj]-> *}'
m2 = 'pattern{ P[phon="en",cat=P]; V[cat=V]; V-[obj]-> O}'
```


```python
g1 = grew.graph('''graph{
W1 [phon="en", cat=P];
W2 [phon="prend", cat=V];
W2 -[obj]->W1;
}''')
```


```python
grew.search(m1, g1)
grew.search(m2, g1)
```


```python
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


```python
grew.search(m1, g2)
grew.search(m2, g2)
```



```python
g3 = grew.graph('''graph{
  W1 [phon=John, cat=NP];
  W2 [phon=reads, cat=V ];
  W3 [phon=the, cat=Det];
  W4 [phon=book, cat=N];
  W2 -[suj]-> W1;
  W2 -[obj]-> W4;
  W4 -[det]-> W3;
}''')
```


```python
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


```python
m3 = "pattern{Y-[suj]->X} without{Y-[obj]->Z; Y-[mod]->T}"
m4 = "pattern{Y-[suj]->X} without{Y-[obj]->Z} without{Y-[mod]->T}"
```

```python
grew.search(m3, g3)
grew.search(m4, g3)
grew.search(m3, g4)
grew.search(m4, g4)
```

```python
g5 = grew.graph('''graph{
  W1 [phon=dors, cat=V, m=imp];
  W2 [phon="!", cat=PONCT];
}''')
```

```python
m5 = "pattern { X[cat=V, t=fut] }"
m6 = "pattern { X[cat=V] } without{ X[t<>fut] }"
```

```python
grew.search(m5, g5)
grew.search(m6, g5)
```



```python
grew.search("pattern { e : X -> Y ; f : X -> Y }", g0)
```

### 1.6 Graph rewriting

```python
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


```python
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

```python
grew.run(r, g, 'passiveAgt')
```

```python
rule = """rule du2dele {
  pattern {
    A [cat="P+D", phon="du"]; N [cat=N];
    A -[obj.p]-> N;
    }
  commands {
    add_node D:> A; D.cat=D ; D.phon="le" ;
    A.cat=P; A.phon="de";
    add_edge N -[det]-> D;
  }
}"""
```
