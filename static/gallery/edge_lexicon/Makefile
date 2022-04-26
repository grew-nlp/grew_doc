GREW?=grew
DEP2PICT?=dep2pict

build:
	mkdir -p _build
	${GREW} transform -quiet -i input.json -dot | dot -Tsvg -o _build/input.svg
	${GREW} transform -quiet -grs edge_lexicon.grs -i input.json -json -o _build/output.json
	${GREW} transform -quiet -i _build/output.json -dot | dot -Tsvg -o _build/output.svg

clean:
	rm -rf _build


.SUFFIXES: .dot .svg .dep .conll

.dot.svg:
	dot -Tsvg $< -o $@

.dep.svg:
	${DEP2PICT} $< $@

.conll.svg:
	${DEP2PICT} $< $@


