GREW?=grew

build:
	mkdir -p _build
	${GREW} transform -quiet -grs single.grs -config basic -strat p_1_nfs -i input.gr -gr -o _build/p_1_nfs.gr
	${GREW} transform -quiet -grs single.grs -config basic -strat p_1_onf -i input.gr -gr -o _build/p_1_onf.gr
	${GREW} transform -quiet -grs single.grs -config basic -strat union -i input.gr -gr -o _build/union.gr
	${GREW} transform -quiet -grs single.grs -config basic -strat all_nfs -i input.gr -gr -o _build/all_nfs.gr

clean:
	rm -rf _build
