selfdoc:
	@echo "make run"
	@echo "make img"

run:
	ln -f -s /Users/guillaum/gitlab/grew/POStoSSQ
	echo "La souris a été mangée par le chat." | MElt -L -T > test.melt
	grew transform -grs POStoSSQ/grs/surf_synt_main.grs -i test.melt -o test.surf.conll
	cat tdm80_ch01.txt | MElt -L -T > tdm80_ch01.melt
	grew transform -grs POStoSSQ/grs/surf_synt_main.grs -i tdm80_ch01.melt -o tdm80_ch01.conll
	rm -f POStoSSQ

img: figures

purge:
	@make clean
	rm -f *.melt *.conll POStoSSQ

include ../Makefile