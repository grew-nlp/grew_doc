GREW?=grew
DEP2PICT?=dep2pict

build:
	mkdir -p _build
	python3 set_gender.py > _build/with_gender.conll
	${DEP2PICT} --no_root _build/with_gender.conll _build/with_gender.svg
	# ------
	${DEP2PICT} --no_root max.conll _build/max.svg
	${GREW} transform -quiet -grs obl_loc.grs -strat "Onf(obl_loc)" -i max.conll -o _build/max_loc.conll
	${DEP2PICT}  --no_root _build/max_loc.conll _build/max_loc.svg
	# ------
	${DEP2PICT} --no_root pomme.conll _build/pomme.svg
	${GREW} transform -quiet -grs transitive_coord.grs -strat "Onf(transitive_coord)" -i pomme.conll -o _build/pomme_enhanced.conll
	${DEP2PICT} --no_root _build/pomme_enhanced.conll _build/pomme_enhanced.svg

clean:
	rm -rf _build