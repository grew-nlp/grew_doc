DEP2PICT?=dep2pict

build:
	mkdir -p _build
	find . -name "*.dep" -type f -print | sed "s/.dep$$//" | xargs -I {} make "{}.svg"
	mv *.svg _build

clean:
	rm -rf _build

.SUFFIXES: .svg .dep

.dep.svg:
	${DEP2PICT} $< $@
