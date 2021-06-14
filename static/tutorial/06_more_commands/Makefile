GREW?=grew
DEP2PICT?=dep2pict

all:
	mkdir -p _build
	${GREW} transform -quiet -config sequoia -grs amalgam1.grs -strat "Onf(amalgam)" -i ../02_first_rule/frwiki_50.1000_00907.seq.conll -o _build/onf_amalgam1.conll
	${DEP2PICT} _build/onf_amalgam1.conll _build/onf_amalgam1.svg
	#
	${GREW} transform -quiet -config sequoia -grs amalgam2.grs -strat "Onf(amalgam)" -i ../02_first_rule/frwiki_50.1000_00907.seq.conll -o _build/onf_amalgam2.conll
	${DEP2PICT} _build/onf_amalgam2.conll _build/onf_amalgam2.svg

clean:
	rm -rf _build
