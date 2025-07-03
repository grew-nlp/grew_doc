GREW?=grew

run:
	mkdir -p _build
	# wget https://github.com/UniversalDependencies/UD_French-PUD/blob/r2.16/fr_pud-ud-test.conllu?raw=true -O _build/fr_pud-ud-test.conllu
	# wget https://github.com/UniversalDependencies/UD_English-PUD/blob/r2.16/en_pud-ud-test.conllu?raw=true -O _build/en_pud-ud-test.conllu
	# wget https://github.com/UniversalDependencies/UD_Chinese-PUD/blob/r2.16/zh_pud-ud-test.conllu?raw=true -O _build/zh_pud-ud-test.conllu
	${GREW} compile -CORPUSBANK .
	${GREW} grep -request dislocated.req -i _build/fr_pud-ud-test.conllu > _build/output_grep
	${GREW} grep -request dislocated.req -i en_fr_zh.json > _build/output_grep_multi
	${GREW} grep -request dislocated.req -key X.upos -i _build/fr_pud-ud-test.conllu > _build/output_grep_key
	${GREW} grep -request dislocated.req -key "{Y << X}" -i _build/fr_pud-ud-test.conllu > _build/output_grep_whether
	${GREW} grep -request dislocated.req -key X.upos -key "{Y << X}" -i _build/fr_pud-ud-test.conllu > _build/output_grep_key_whether
	${GREW} count -request ADJ_NOUN_pre.req -request ADJ_NOUN_post.req -i en_fr_zh.json > _build/output_count.json
	${GREW} count -request ADJ_NOUN_pre.req -request ADJ_NOUN_post.req -i en_fr_zh.json -tsv > _build/output_count.tsv
	${GREW} count -request ADJ_NOUN_pre.req -key N.Number -i en_fr_zh.json > _build/output_count_key.json
	${GREW} count -request ADJ_NOUN_pre.req -key N.Number -i en_fr_zh.json -tsv > _build/output_count_key.tsv
	${GREW} count -request ADJ_NOUN.req -key "{A << N}" -i en_fr_zh.json > _build/output_count_whether.json
	${GREW} count -request ADJ_NOUN.req -key "{A << N}" -i en_fr_zh.json -tsv > _build/output_count_whether.tsv

clean:
	rm -rf _build
