build:
	mkdir -p _build
	grew transform -grs cc.grs -i two_cc.json -json -o _build/two_cc_output.json
	head -n 9 _build/two_cc_output.json > _build/cc1.json
	tail -n 5 _build/two_cc_output.json > _build/cc2.json
	grew transform -i two_cc.json -dot | dot -Tsvg -o _build/two_cc.svg
	grew transform -i _build/cc1.json -dot | dot -Tsvg -o _build/cc1.svg
	grew transform -i _build/cc2.json -dot | dot -Tsvg -o _build/cc2.svg
  # ----------
	dep2pict fr-ud-train_04997.conllu _build/fr-ud-train_04997.svg
	grew transform -grs del_appos.grs -i fr-ud-train_04997.conllu -o _build/fr-ud-train_04997_no_appos.conllu
	dep2pict _build/fr-ud-train_04997_no_appos.conllu _build/fr-ud-train_04997_no_appos.svg
	grew transform -grs cc.grs -i _build/fr-ud-train_04997_no_appos.conllu -o _build/fr-ud-train_04997_split.conllu
	dep2pict -p 1 _build/fr-ud-train_04997_split.conllu _build/fr-ud-train_04997_cc1.svg
	dep2pict -p 2 _build/fr-ud-train_04997_split.conllu _build/fr-ud-train_04997_cc2.svg
	dep2pict -p 3 _build/fr-ud-train_04997_split.conllu _build/fr-ud-train_04997_cc3.svg
clean:
	rm -rf _build


.SUFFIXES: .dot .svg .dep .conll

.dot.svg:
	dot -Tsvg $< -o $@

.dep.svg:
	dep2pict $< $@

.conll.svg:
	dep2pict $< $@


