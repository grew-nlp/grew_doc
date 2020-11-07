GREW=grew_dev

build:
	mkdir -p _build
	dep2pict max.conll _build/max.svg
	${GREW} transform -grs obl_loc.grs -strat "Onf(obl_loc)" -i max.conll -o _build/max_loc.conll
	dep2pict _build/max_loc.conll _build/max_loc.svg
	# ------
	dep2pict pomme.conll _build/pomme.svg
	${GREW} transform -grs transitive_coord.grs -strat "Onf(transitive_coord)" -i pomme.conll -o _build/pomme_enhanced.conll
	dep2pict _build/pomme_enhanced.conll _build/pomme_enhanced.svg

clean:
	rm -rf _build