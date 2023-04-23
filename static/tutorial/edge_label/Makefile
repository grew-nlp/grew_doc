GREW?=grew_dev

all:
	mkdir -p _build
	dep2pict --no_root take_a_walk.conllu _build/take_a_walk.svg
	${GREW} transform -quiet -grs del_add.grs -strat "del_add" -config sud -i take_a_walk.conllu -o _build/take_a_walk_del_add.conllu
	${GREW} transform -quiet -grs del_add_with_name.grs -strat "del_add_with_name" -config sud -i take_a_walk.conllu -o _build/take_a_walk_del_add_with_name.conllu
	${GREW} transform -quiet -grs change_whole_label.grs -strat "change_whole_label" -config sud -i take_a_walk.conllu -o _build/take_a_walk_change_whole_label.conllu
	${GREW} transform -quiet -grs change_features.grs -strat "change_features" -config sud -i take_a_walk.conllu -o _build/take_a_walk_change_features.conllu
	dep2pict --no_root _build/take_a_walk_del_add.conllu _build/take_a_walk_del_add.svg
	dep2pict --no_root _build/take_a_walk_del_add_with_name.conllu _build/take_a_walk_del_add_with_name.svg
	dep2pict --no_root _build/take_a_walk_change_whole_label.conllu _build/take_a_walk_change_whole_label.svg
	dep2pict --no_root _build/take_a_walk_change_features.conllu _build/take_a_walk_change_features.svg

clean:
	rm -rf _build
