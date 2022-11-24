GREW?=grew

build:
	mkdir -p _build
	${GREW} transform -quiet -grs single.grs -config basic -strat p_1_nfs -i input.json -json -o _build/p_1_nfs.json
	${GREW} transform -quiet -grs single.grs -config basic -strat p_1_onf -i input.json -json -o _build/p_1_onf.json
	${GREW} transform -quiet -grs single.grs -config basic -strat union -i input.json -json -o _build/union.json
	${GREW} transform -quiet -grs single.grs -config basic -strat all_nfs -i input.json -json -o _build/all_nfs.json

clean:
	rm -rf _build
