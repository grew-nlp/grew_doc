selfdoc:
	@echo "make run"
	@echo "make img"

run:
	ln -s /Users/guillaum/gitlab/grew/POStoSSQ
	echo "La souris a été mangée par le chat." | MElt -L -T > test.melt
	grew -det -grs POStoSSQ/grs/surf_synt_main.grs -strat full -i test.melt -f test.conll
	cat tdm80_ch01.txt | MElt -L -T > tdm80_ch01.melt
	grew -det -grs POStoSSQ/grs/surf_synt_main.grs -strat full -i tdm80_ch01.melt -f tdm80_ch01.conll
	rm -f POStoSSQ

img: figures

purge:
	@make clean
	rm -f *.melt *.conll POStoSSQ

include ../Makefile