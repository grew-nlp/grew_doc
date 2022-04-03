GREW?=grew

run:
	mkdir -p _build
	wget https://github.com/UniversalDependencies/UD_French-PUD/blob/r2.9/fr_pud-ud-test.conllu?raw=true -O _build/fr_pud-ud-test.conllu
	wget https://github.com/UniversalDependencies/UD_English-PUD/blob/r2.9/en_pud-ud-test.conllu?raw=true -O _build/en_pud-ud-test.conllu
	wget https://github.com/UniversalDependencies/UD_Chinese-PUD/blob/r2.9/zh_pud-ud-test.conllu?raw=true -O _build/zh_pud-ud-test.conllu
	${GREW} grep -pattern rouge.pat -i _build/fr_pud-ud-test.conllu > _build/output_grep
	${GREW} grep -pattern rouge.pat -key N.Gender -i _build/fr_pud-ud-test.conllu > _build/output_grep_key
	${GREW} grep -pattern rouge.pat -whether "M << N" -i _build/fr_pud-ud-test.conllu > _build/output_grep_whether
	${GREW} clean -i en_fr_zh.json
	${GREW} compile -i en_fr_zh.json
	${GREW} count -patterns "ADJ_NOUN_pre.pat ADJ_NOUN_post.pat" -i en_fr_zh.json > _build/output_count
	${GREW} count -patterns ADJ_NOUN_pre.pat -key N.Number -i en_fr_zh.json > _build/output_count_key
	${GREW} count -patterns ADJ_NOUN.pat -whether "A << N" -i en_fr_zh.json > _build/output_count_whether

clean:
	rm -rf _build
