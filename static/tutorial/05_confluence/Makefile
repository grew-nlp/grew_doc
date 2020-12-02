all:
	mkdir -p _build
	grew transform -config sequoia -grs aux_verb.grs -strat "Onf(v)" -i ../02_first_rule/frwiki_50.1000_00907.seq.conll -o _build/onf_aux_verb.conll
	grew transform -config sequoia -grs aux_verb.grs -strat "Iter(v)" -i ../02_first_rule/frwiki_50.1000_00907.seq.conll -o _build/iter_aux_verb.conll
	grew transform -config sequoia -grs aux_verb_confluent.grs -strat "Iter(v)" -i ../02_first_rule/frwiki_50.1000_00907.seq.conll -o _build/iter_aux_verb_confluent.conll

clean:
	rm -rf _build
