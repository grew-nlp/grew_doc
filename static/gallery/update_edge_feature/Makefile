GREW?=grew

all:
	mkdir -p _build
	dep2pict fr-ud-test_00018.conllu _build/fr-ud-test_00018.svg
	${GREW} transform -quiet -grs update_edge_feature.grs -config sud -i fr-ud-test_00018.conllu -o _build/output.conllu
	dep2pict _build/output.conllu -p 1 _build/output_1.svg
	dep2pict _build/output.conllu -p 2 _build/output_2.svg

clean:
	rm -rf _build
