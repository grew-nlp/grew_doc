from grewpy import Corpus, Request

pud_corpus = Corpus('data/fr_pud-ud-test.conllu')
all_tables = pud_corpus.count (Request ('e: G -> D'), clustering_keys=['e.label', 'G.upos', 'D.upos'])

print (all_tables)