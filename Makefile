selfdoc:
	@echo " * make start --> run locally the server"
	@echo " * make stop  --> stop the server"
	@echo " * make lchn  --> install on the production server"
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

lchn:
	hugo
	scp -r public/* grew.lchn.fr:/home/guillaum/www/doc/

purge:
	@make -C static/parsing purge
	@make -C static/deep_syntax purge

