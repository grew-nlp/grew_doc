HUGO=hugo_old

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
	@make -C static/doc/commands
	@make -C static/doc/grs
	@make -C static/doc/rewriting
	@make -C static/doc/rule
	@make -C static/grs/deep_syntax
	@make -C static/grs/parsing
	@make -C static/tutorial/02_first_rule
	@make -C static/tutorial/03_rules_set
	@make -C static/tutorial/04_termination
	@make -C static/tutorial/05_confluence
	@make -C static/tutorial/06_more_commands
	@make -C static/usage/cli
	@make -C static/usage/python

lchn:
	${HUGO}
	scp -r public/* grew.lchn.fr:/home/guillaum/www/doc/

grew_server:
	${HUGO}
	scp -r public/usage/grew_server/index.html grew.lchn.fr:/home/guillaum/www/doc/usage/grew_server

tutorial:
	${HUGO}
	scp -r public/tutorial/* grew.lchn.fr:/home/guillaum/www/doc/tutorial

trans_14:
	${HUGO}
	scp -r public/trans_14/index.html grew.lchn.fr:/home/guillaum/www/doc/trans_14

grew_match_help:
	${HUGO}
	scp -r public/grew_match/help/index.html grew.lchn.fr:/home/guillaum/www/doc/grew_match/help

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

