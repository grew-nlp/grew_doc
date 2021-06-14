GREW?=grew_dev
DEP2PICT?=dep2pict

build:
	mkdir -p _build
	ln -f -s ../../../../extern/SSQtoDSQ _build/SSQtoDSQ
	ln -f -s ../../../../extern/sequoia_proj.grs _build/sequoia_proj.grs
	${GREW} transform -quiet -grs _build/SSQtoDSQ/grs/main_dsq.grs -config sequoia -i test.surf.conll -o _build/test.deep_and_surf.conll
	${DEP2PICT} _build/test.deep_and_surf.conll _build/test.deep_and_surf.svg
	${GREW} transform -quiet -grs _build/sequoia_proj.grs -config sequoia -strat deep -i _build/test.deep_and_surf.conll -o _build/test.deep.conll
	${DEP2PICT} _build/test.deep.conll _build/test.deep.svg

clean:
	rm -rf _build
