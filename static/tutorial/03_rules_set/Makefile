all:
	mkdir -p _build
	grew transform -grs pos_rules.grs -strat "Onf(POS)" -config sequoia -i ../02_first_rule/frwiki_50.1000_00907.seq.conll -o _build/onf_pos.conll
	dep2pict _build/onf_pos.conll _build/onf_pos.svg

clean:
	rm -rf _build
