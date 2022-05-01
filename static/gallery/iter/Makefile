GREW?=grew

all:
	mkdir -p _build
	${GREW} transform -quiet -grs iter_package.grs -multi_json -i input.json -o _build/output.json
	${GREW} transform -quiet -i input.json -dot | dot -Tsvg -o _build/input.svg
	${GREW} transform -quiet -i _build/output__0.json -dot | dot -Tsvg -o _build/output__0.svg
	${GREW} transform -quiet -i _build/output__1.json -dot | dot -Tsvg -o _build/output__1.svg
	${GREW} transform -quiet -i _build/output__2.json -dot | dot -Tsvg -o _build/output__2.svg
	${GREW} transform -quiet -i _build/output__3.json -dot | dot -Tsvg -o _build/output__3.svg

clean:
	rm -rf _build
