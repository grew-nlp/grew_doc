GREW?=grew
DEP2PICT?=dep2pict

build:
	mkdir -p _build
	${GREW} transform -quiet -grs cc.grs -i two_cc.json -multi_json -o _build/two_cc_output.json
	${GREW} transform -quiet -i two_cc.json -dot | dot -Tsvg -o _build/two_cc.svg
	${GREW} transform -quiet -i _build/two_cc_output__0.json -dot | dot -Tsvg -o _build/two_cc_output__0.svg
	${GREW} transform -quiet -i _build/two_cc_output__1.json -dot | dot -Tsvg -o _build/two_cc_output__1.svg
	${DEP2PICT} fr-ud-train_04997.conllu _build/fr-ud-train_04997.svg
	${GREW} transform -quiet -grs del_appos.grs -i fr-ud-train_04997.conllu -o _build/fr-ud-train_04997_no_appos.conllu
	${DEP2PICT} _build/fr-ud-train_04997_no_appos.conllu _build/fr-ud-train_04997_no_appos.svg
	${GREW} transform -quiet -grs cc.grs -i _build/fr-ud-train_04997_no_appos.conllu -o _build/fr-ud-train_04997_split.conllu
	${DEP2PICT} -p 1 _build/fr-ud-train_04997_split.conllu _build/fr-ud-train_04997_cc1.svg
	${DEP2PICT} -p 2 _build/fr-ud-train_04997_split.conllu _build/fr-ud-train_04997_cc2.svg
	${DEP2PICT} -p 3 _build/fr-ud-train_04997_split.conllu _build/fr-ud-train_04997_cc3.svg

clean:
	rm -rf _build


.SUFFIXES: .dot .svg .dep .conll

.dot.svg:
	dot -Tsvg $< -o $@

.dep.svg:
	${DEP2PICT} $< $@

.conll.svg:
	${DEP2PICT} $< $@


