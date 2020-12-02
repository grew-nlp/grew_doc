all:
	mkdir -p _build
	grew transform -config sequoia -grs amalgam1.grs -strat "Onf(amalgam)" -i ../02_first_rule/frwiki_50.1000_00907.seq.conll -o _build/onf_amalgam1.conll
	dep2pict _build/onf_amalgam1.conll _build/onf_amalgam1.svg
	#
	grew transform -config sequoia -grs amalgam2.grs -strat "Onf(amalgam)" -i ../02_first_rule/frwiki_50.1000_00907.seq.conll -o _build/onf_amalgam2.conll
	dep2pict _build/onf_amalgam2.conll _build/onf_amalgam2.svg

clean:
	rm -rf _build
