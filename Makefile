selfdoc:
	@echo " * make run   --> run locally the server"
	@echo " * make talc2 --> install on the production server"
	@echo " * make build --> build the website	"

run:
	hugo server -w &
	open -a firefox -g http://localhost:1313/

build:
	@make -C static/parsing run
	@make -C static/parsing img
	@make -C static/deep_syntax run
	@make -C static/deep_syntax img
	hugo

talc2:
	#tar cf - public | ssh $(stalc2)/www/grew_doc tar xf -
	scp -r public/* $(stalc2)/www/grew_doc/

purge:
	@make -C static/parsing purge
	@make -C static/deep_syntax purge

