POStoSSQ=/Users/guillaum/gitlab/grew/POStoSSQ
SSQtoDSQ=/Users/guillaum/gitlab/grew/SSQtoDSQ
sequoia_proj.grs=/Users/guillaum/gitlab/deep-sequoia/tools/sequoia_proj.grs

selfdoc:
	@echo "make run"
	@echo "make img"

run:
	echo "La souris a été mangée par le chat." | MElt -L -T > test.melt
	grew transform -grs $(POStoSSQ)/grs/surf_synt_main.grs -i test.melt -o test.surf.conll
	grew transform -grs $(SSQtoDSQ)/grs/main_dsq.grs -i test.surf.conll -o test.deep_and_surf.conll
	grew transform -grs $(sequoia_proj.grs) -strat deep -i test.deep_and_surf.conll -o test.deep.conll

img: figures

purge:
	@make clean
	rm -f test.*

include ../Makefile