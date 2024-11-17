from grewpy import Corpus, Request

pud_corpus = Corpus('data/fr_pud-ud-test.conllu')
nsubj_table = pud_corpus.count (Request ('pattern {G -[nsubj]-> D}'), clustering_keys=['G.upos', 'D.upos'])

print (nsubj_table)