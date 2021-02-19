GREW=grew_dev

build:
	mkdir -p _build
	ln -f -s ../../../../extern/SSQtoDSQ _build/SSQtoDSQ
	ln -f -s ../../../../extern/sequoia_proj.grs _build/sequoia_proj.grs
	${GREW} transform -grs _build/SSQtoDSQ/grs/main_dsq.grs -config sequoia -i test.surf.conll -o _build/test.deep_and_surf.conll
	dep2pict _build/test.deep_and_surf.conll _build/test.deep_and_surf.svg
	${GREW} transform -grs _build/sequoia_proj.grs -config sequoia -strat deep -i _build/test.deep_and_surf.conll -o _build/test.deep.conll
	dep2pict _build/test.deep.conll _build/test.deep.svg

clean:
	rm -rf _build
