GREW?=grew_dev
DEP2PICT?=dep2pict

all:
	mkdir -p _build
	${GREW} transform -quiet -grs pos_rules.grs -strat "Onf(POS)" -config sequoia -i ../02_first_rule/frwiki_50.1000_00907.seq.conll -o _build/onf_pos.conll
	${DEP2PICT} _build/onf_pos.conll _build/onf_pos.svg

clean:
	rm -rf _build
