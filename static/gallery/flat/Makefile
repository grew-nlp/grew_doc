GREW?=grew
DEP2PICT?=dep2pict

build:
	mkdir -p _build
	find . -name "*.dot" -type f -print | sed "s/.dot$$//" | xargs -I {} make "{}.svg"
	find . -name "*.dep" -type f -print | sed "s/.dep$$//" | xargs -I {} make "{}.svg"
	find . -name "*.conll" -type f -print | sed "s/.conll$$//" | xargs -I {} make "{}.svg"
	mv *.svg _build
	${GREW} transform -quiet -grs rules.grs -strat "Iter (sh2c_1)" -i SH6.conll -o _build/C6_120.conll
	# select one of the output graphs
	${DEP2PICT} _build/C6_120.conll -p 42 _build/C6_120_example.svg
	${GREW} transform -quiet -grs rules.grs -strat "Iter (sh2c_2)" -i SH6.conll -o _build/C6_5.conll
	# select one of the output graphs
	${DEP2PICT} _build/C6_5.conll -p 3 _build/C6_5_example.svg


clean:
	rm -rf _build


.SUFFIXES: .dot .svg .dep .conll

.dot.svg:
	dot -Tsvg $< -o $@

.dep.svg:
	${DEP2PICT} $< $@

.conll.svg:
	${DEP2PICT} $< $@


