GREW?=grew
DEP2PICT?=dep2pict

build:
	mkdir -p _build
	${DEP2PICT} max.conll _build/max.svg
	${GREW} transform -quiet -grs obl_loc.grs -strat "Onf(obl_loc)" -i max.conll -o _build/max_loc.conll
	${DEP2PICT} _build/max_loc.conll _build/max_loc.svg
	# ------
	${DEP2PICT} pomme.conll _build/pomme.svg
	${GREW} transform -quiet -grs transitive_coord.grs -strat "Onf(transitive_coord)" -i pomme.conll -o _build/pomme_enhanced.conll
	${DEP2PICT} _build/pomme_enhanced.conll _build/pomme_enhanced.svg

clean:
	rm -rf _build