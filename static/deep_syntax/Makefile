selfdoc:
	@echo "make run"
	@echo "make img"

run:
	ln -s /Users/guillaum/gitlab/grew/POStoSSQ
	ln -s /Users/guillaum/gitlab/grew/SSQtoDSQ
	ln -s /Users/guillaum/gitlab/deep-sequoia/tools/sequoia.dom
	ln -s /Users/guillaum/gitlab/deep-sequoia/tools/sequoia_proj.grs
	echo "La souris a été mangée par le chat." | MElt -L -T > test.melt
	grew transform -grs POStoSSQ/grs/surf_synt_main.grs -i test.melt -o test.surf.conll
	grew transform -grs SSQtoDSQ/grs/main_dsq.grs -i test.surf.conll -o test.deep_and_surf.conll
	grew transform -grs sequoia_proj.grs -strat deep -i test.deep_and_surf.conll -o test.deep.conll
	rm -f POStoSSQ SSQtoDSQ sequoia.dom sequoia_proj.grs

img: figures

purge:
	@make clean
	rm -f test.* POStoSSQ SSQtoDSQ sequoia.dom sequoia_proj.grs

include ../Makefile