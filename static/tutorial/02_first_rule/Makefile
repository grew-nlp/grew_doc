GREW?=grew_dev
DEP2PICT?=dep2pict

all:
	mkdir -p _build
	${DEP2PICT} frwiki_50.1000_00907.seq.conll _build/frwiki_50.1000_00907.seq.svg
	${DEP2PICT} frwiki_50.1000_00907.sud.conllu _build/frwiki_50.1000_00907.sud.svg
	${GREW} transform -quiet -grs adjective.grs -strat "adj" -config sequoia -i frwiki_50.1000_00907.seq.conll -o _build/one_step_adj.conll
	${DEP2PICT} _build/one_step_adj.conll _build/one_step_adj.svg
	${GREW} transform -quiet -grs preposition.grs -strat "prep" -config sequoia -i frwiki_50.1000_00907.seq.conll -o _build/one_step_prep.conll
	${GREW} transform -quiet -grs noun.grs -strat "noun" -config sequoia -i frwiki_50.1000_00907.seq.conll -o _build/one_step_noun.conll
	# ---
	${GREW} transform -quiet -grs noun.grs -strat "Onf(noun)" -config sequoia -i frwiki_50.1000_00907.seq.conll -o _build/onf_noun.conll

clean:
	rm -rf _build
