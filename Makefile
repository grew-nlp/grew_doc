HUGO=${hugo_old}

selfdoc:
	@echo " * make start --> run locally the server"
	@echo " * make stop  --> stop the server"
	@echo " * make lchn  --> install on the production server"
	@echo " * make build --> build the website	"

start:
	${HUGO} server -w &
	open -a "Brave Browser" -g http://localhost:1313/

stop:
	killall ${HUGO}

build:
	@make -C static/parsing run
	@make -C static/parsing img
	@make -C static/deep_syntax run
	@make -C static/deep_syntax img
	${HUGO}

lchn:
	${HUGO}
	scp -r public/* grew.lchn.fr:/home/guillaum/www/doc/

grew_server:
	${HUGO}
	scp -r public/grew_server/index.html grew.lchn.fr:/home/guillaum/www/doc/grew_server

match_doc:
	${HUGO}
	scp -r public/match_doc/index.html grew.lchn.fr:/home/guillaum/www/doc/match_doc

pattern:
	${HUGO}
	scp -r public/pattern/index.html grew.lchn.fr:/home/guillaum/www/doc/pattern

commands:
	${HUGO}
	scp -r public/commands/index.html grew.lchn.fr:/home/guillaum/www/doc/commands

complex_edges:
	${HUGO}
	scp -r public/complex_edges/index.html grew.lchn.fr:/home/guillaum/www/doc/complex_edges

purge:
	@make -C static/parsing purge
	@make -C static/deep_syntax purge

