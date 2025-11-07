GREW?=grew

run:
 	mkdir -p data
 	wget https://github.com/UniversalDependencies/UD_French-PUD/raw/refs/tags/r2.16/fr_pud-ud-test.conllu -O data/fr_pud-ud-test.conllu
 	wget https://github.com/UniversalDependencies/UD_English-PUD/raw/refs/tags/r2.16/en_pud-ud-test.conllu -O data/en_pud-ud-test.conllu
 	wget https://github.com/UniversalDependencies/UD_Chinese-PUD/raw/refs/tags/r2.16/zh_pud-ud-test.conllu -O data/zh_pud-ud-test.conllu
	${GREW} compile -CORPUSBANK .
	${GREW} grep -request "pattern { e: X -[dislocated]-> Y }" -i data/fr_pud-ud-test.conllu \
		> _build/output_grep
	${GREW} grep -request "pattern { e: X -[dislocated]-> Y }" -i en_fr_zh.json \
		> _build/output_grep_multi
	${GREW} grep -request "pattern { e: X -[dislocated]-> Y }" -key X.upos -i data/fr_pud-ud-test.conllu \
		> _build/output_grep_key
	${GREW} grep -request "pattern { e: X -[dislocated]-> Y }" -key "{X << Y}" -i data/fr_pud-ud-test.conllu \
		> _build/output_grep_whether
	${GREW} grep -request "pattern { e: X -[dislocated]-> Y }" -key X.upos -key "{Y << X}" -i data/fr_pud-ud-test.conllu \
		> _build/output_grep_key_whether
	${GREW} count -request AN.req -request NA.req -i en_fr_zh.json \
		> _build/output_count.json
	${GREW} count -request AN.req -request NA.req -i en_fr_zh.json -tsv \
		> _build/output_count.tsv
	${GREW} count -request AN.req -key N.Number -i en_fr_zh.json \
		> _build/output_count_key.json
	${GREW} count -request AN.req -key N.Number -i en_fr_zh.json -tsv \
		> _build/output_count_key.tsv
	${GREW} count -request ADJ_NOUN.req -key "{A << N}" -i en_fr_zh.json -tsv \
		> _build/output_count_whether.tsv

clean:
	rm -rf _build
