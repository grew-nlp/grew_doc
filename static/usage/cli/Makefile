GREW?=grew

run:
	mkdir -p _build
	wget https://github.com/UniversalDependencies/UD_French-PUD/blob/r2.8/fr_pud-ud-test.conllu?raw=true -O _build/fr_pud-ud-test.conllu
	wget https://github.com/UniversalDependencies/UD_English-PUD/blob/r2.8/en_pud-ud-test.conllu?raw=true -O _build/en_pud-ud-test.conllu
	wget https://github.com/UniversalDependencies/UD_Chinese-PUD/blob/r2.8/zh_pud-ud-test.conllu?raw=true -O _build/zh_pud-ud-test.conllu
	${GREW} grep -pattern rouge.pat -i _build/fr_pud-ud-test.conllu > _build/output_grep
	${GREW} clean -i en_fr_zh.json
	${GREW} compile -i en_fr_zh.json
	${GREW} count -patterns "ADJ_NOUN.pat NOUN_ADJ.pat" -i en_fr_zh.json > _build/output_count

clean:
	rm -rf _build
