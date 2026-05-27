

run: SUD_English-PUD/en_pud-sud-test.conllu
	rm -f ud-treebanks-v2.18
	ln -s ${RESOURCES}/ud-treebanks-v2.18
	find . -name "*.ipynb" -exec jupyter nbconvert --execute --to notebook --inplace {} \;
	python3 ../../tools/ipynb2md.py

SUD_English-PUD/en_pud-sud-test.conllu:
	wget https://grew.fr/download/SUD_2.18/SUD_English-PUD.tgz
	tar zxvf SUD_English-PUD.tgz
	rm -f SUD_English-PUD.tgz
