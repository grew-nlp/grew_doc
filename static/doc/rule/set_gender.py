import pprint

from grewpy import Graph, GRS

graph = Graph("""1\tle\tle\tDET\t_\t_\t2\tdet\t_\t_
2\tgarçon\tgarçon\tNOUN\t_\t_\t3\tsubj\t_\t_
3\tvoit\tvoir\tVERB\t_\t_\t0\troot\t_\t_
4\tla\tle\tDET\t_\t_\t5\tdet\t_\t_
5\tmaison\tmaison\tNOUN\t_\t_\t3\tcomp:obj\t_\t_
""")

rule = GRS("""
rule set_gender {
  pattern { N [upos=NOUN, !Gender, lemma=lex.noun] }
  commands { N.Gender = lex.Gender }
}
#BEGIN lex
noun\tGender
%-------------
garçon\tMasc
maison\tFem
#END
""")

output = rule.apply(graph, strat = "Onf(set_gender)")

print (output.to_conll())
