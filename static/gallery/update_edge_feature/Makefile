GREW?=grew
DEP2PICT?=dep2pict

all:
	mkdir -p _build
	${DEP2PICT} fr-ud-test_00018.conllu _build/fr-ud-test_00018.svg
	${GREW} transform -quiet -grs update_edge_feature.grs -config sud -i fr-ud-test_00018.conllu -o _build/output.conllu
	${DEP2PICT} _build/output.conllu -p 1 _build/output_1.svg
	${DEP2PICT} _build/output.conllu -p 2 _build/output_2.svg

clean:
	rm -rf _build
