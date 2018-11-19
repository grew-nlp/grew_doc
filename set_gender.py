import grew
grew.init()

g = grew.graph('''graph {
  W1 [form="le", lemma="le", cat=DET];
  W2 [form="garçon", lemma="garçon", cat=NOUN];
  W3 [form="voit", lemma="voir", cat=VERB];
  W4 [form="la", lemma="le", cat=DET];
  W5 [form="maison", lemma="maison", cat=NOUN];
  }''')

r = grew.grs('''
rule set_gender {
  pattern { N [upos=NOUN, !Gender, lemma=lex.noun] }
  commands { N.Gender = lex.Gender }
}
#BEGIN lex
noun\tGender
%-------------
garçon\tMasc
maison\tFem
maison\tMasc
#END
''')

output = grew.run(r, g, 'Iter(set_gender)')

print (output)
