figures:
	find . -name "*.dot" -type f -print | sed "s/.dot$$//" | xargs -I {} make "{}.svg"
	find . -name "*.dep" -type f -print | sed "s/.dep$$//" | xargs -I {} make "{}.svg"
	find . -name "*.conll" -type f -print | sed "s/.conll$$//" | xargs -I {} make "{}.svg"

clean:
	find . -name "*.dot" -type f -print | sed "s/.dot$$//" | xargs -I {} rm -f "{}.svg"
	find . -name "*.dep" -type f -print | sed "s/.dep$$//" | xargs -I {} rm -f "{}.svg"
	find . -name "*.conll" -type f -print | sed "s/.conll$$//" | xargs -I {} rm -f "{}.svg"

.SUFFIXES: .dot .svg .dep .conll

.dot.svg:
	dot -Tsvg $< -o $@

.dep.svg:
	dep2pict $< $@

.conll.svg:
	dep2pict $< $@


