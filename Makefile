selfdoc:
	@echo " * make start --> run locally the server"
	@echo " * make stop  --> stop the server"
	@echo " * make talc2 --> install on the production server"
	@echo " * make build --> build the website	"

start:
	hugo server -w &
	open -a firefox -g http://localhost:1313/

stop:
	killall hugo

build:
	@make -C static/parsing run
	@make -C static/parsing img
	@make -C static/deep_syntax run
	@make -C static/deep_syntax img
	hugo

talc2:
	@echo "OBSOLETE"
#	tar cf - public | ssh $(stalc2)/www/grew_doc tar xf -
#	hugo
#	scp -r public/* $(stalc2)/www/grew_doc/

lchn:
	hugo
	scp -r public/* grew.lchn.fr:/home/guillaum/www/doc/

purge:
	@make -C static/parsing purge
	@make -C static/deep_syntax purge

