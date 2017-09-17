selfdoc:
	@echo "make run"
	@echo "make img"

run:
	ln -s /Users/guillaum/gitlab/grew/POStoSSQ
	ln -s /Users/guillaum/gitlab/grew/SSQtoDSQ
	ln -s /Users/guillaum/gitlab/deep-sequoia/tools/sequoia.dom
	ln -s /Users/guillaum/gitlab/deep-sequoia/tools/sequoia_proj.grs
	echo "La souris a été mangée par le chat." | MElt -L -T > test.melt
	grew -det -grs POStoSSQ/grs/surf_synt_main.grs -strat full -i test.melt -f test.surf.conll
	grew -det -grs SSQtoDSQ/grs/main_dsq.grs -i test.surf.conll -f test.deep_and_surf.conll
	grew -det -grs sequoia_proj.grs -strat deep -i test.deep_and_surf.conll -f test.deep.conll
	rm -f POStoSSQ SSQtoDSQ sequoia.dom sequoia_proj.grs

img: figures

purge:
	@make clean
	rm -f test.* POStoSSQ SSQtoDSQ sequoia.dom sequoia_proj.grs

include ../Makefile