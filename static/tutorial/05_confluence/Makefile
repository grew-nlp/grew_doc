GREW?=grew_dev

all:
	mkdir -p _build
	${GREW} transform -quiet -config sequoia -grs aux_verb.grs -strat "Onf(v)" -i ../02_first_rule/frwiki_50.1000_00907.seq.conll -o _build/onf_aux_verb.conll
	${GREW} transform -quiet -config sequoia -grs aux_verb.grs -strat "Iter(v)" -i ../02_first_rule/frwiki_50.1000_00907.seq.conll -o _build/iter_aux_verb.conll
	${GREW} transform -quiet -config sequoia -grs aux_verb_confluent.grs -strat "Iter(v)" -i ../02_first_rule/frwiki_50.1000_00907.seq.conll -o _build/iter_aux_verb_confluent.conll
	${GREW} transform -quiet -grs del_xpos.grs -strat "Iter(del_xpos)" -i 14_nodes.conllu 2> _build/wrong_loop.log || true

clean:
	rm -rf _build
