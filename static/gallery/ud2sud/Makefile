GREW?=grew

build:
	mkdir -p _build
	dep2pict ud.conllu _build/ud.svg
	${GREW} transform -quiet -grs ud2sud.grs -config sud -i ud.conllu -o _build/sud.conllu
	dep2pict _build/sud.conllu _build/sud.svg

test:
	${GREW} transform -quiet -grs ud2sud.grs -config sud -i ud.conllu -o sud_main.conllu
	diff sud_main.conllu _build/sud.conllu
	rm sud_main.conllu
	${GREW} transform -quiet -grs ud2sud.grs -config sud -strat main_iter -i ud.conllu -o sud_iter.conllu
	diff sud_iter.conllu _build/sud.conllu
	rm sud_iter.conllu

clean:
	rm -rf _build

