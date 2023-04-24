GREW?=grew_dev

all:
	mkdir -p _build
	dep2pict --no_root take_a_walk.conllu _build/take_a_walk.svg
	${GREW} transform -quiet -grs change_features.grs -strat "change_features" -config sud -i take_a_walk.conllu -o _build/take_a_walk_change_features.conllu
	dep2pict --no_root _build/take_a_walk_change_features.conllu _build/take_a_walk_change_features.svg
	dep2pict --no_root trap.conllu _build/trap.svg
	${GREW} transform -quiet -grs change_features.grs -strat "change_features" -config sud -i trap.conllu -o _build/trap_change_features.conllu
	dep2pict --no_root _build/trap_change_features.conllu _build/trap_change_features.svg
	${GREW} transform -quiet -grs del_add.grs -strat "del_add" -config sud -i trap.conllu -o _build/trap_del_add.conllu
	dep2pict --no_root _build/trap_del_add.conllu _build/trap_del_add.svg

clean:
	rm -rf _build
