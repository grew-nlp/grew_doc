GREW=grew_dev

build:
	mkdir -p _build
	${GREW} transform -i fr-ud-dev_00327.conllu -o _build/fr-ud-dev_00327.json -json
	${GREW} transform -i abc.json -dot | dot -Tsvg -o _build/abc.svg


clean:
	rm -rf _build