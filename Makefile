selfdoc:
	@echo " * make start --> run locally the server"
	@echo " * make stop  --> stop the server"
	@echo " * make lchn  --> install on the production server"
	@echo " * make build --> build the website	"

start:
	hugo server -w &
	open -a "Brave Browser" -g http://localhost:1313/

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

grew_server:
	hugo
	scp -r public/grew_server/index.html grew.lchn.fr:/home/guillaum/www/doc/grew_server

match_doc:
	hugo
	scp -r public/match_doc/index.html grew.lchn.fr:/home/guillaum/www/doc/match_doc

pattern:
	hugo
	scp -r public/pattern/index.html grew.lchn.fr:/home/guillaum/www/doc/pattern

complex_edges:
	hugo
	scp -r public/complex_edges/index.html grew.lchn.fr:/home/guillaum/www/doc/complex_edges

purge:
	@make -C static/parsing purge
	@make -C static/deep_syntax purge

