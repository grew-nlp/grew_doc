run:
	wget https://github.com/UniversalDependencies/UD_French-GSD/blob/r2.6/fr_gsd-ud-dev.conllu?raw=true -O fr_gsd-ud-dev.conllu
	grew_dev grep -pattern bleu.pat -i fr_gsd-ud-dev.conllu > output_grep
	grew_dev clean -i ../../doc/corpora/en_fr_zh.json
	grew_dev compile -i ../../doc/corpora/en_fr_zh.json
	grew_dev count -patterns "ADJ_NOUN.pat NOUN_ADJ.pat" -i ../../doc/corpora/en_fr_zh.json > output_count
	rm -f fr_gsd-ud-dev.conllu

clean:
	rm -f fr_gsd-ud-dev.conllu
	rm -f output_*
