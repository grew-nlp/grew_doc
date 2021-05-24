GREW?=grew_dev

all:
	mkdir -p _build
	${GREW} transform -quiet -grs adverb.grs -strat "adv" -config sequoia -i ../02_first_rule/frwiki_50.1000_00907.seq.conll -o _build/one_step_adv.conll
	${GREW} transform -quiet -grs adverb.grs -strat "Onf(adv)" -config sequoia -i ../02_first_rule/frwiki_50.1000_00907.seq.conll 2> _build/loop.log || true

clean:
	rm -rf _build
