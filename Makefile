HUGO=hugo

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
	@make -C static/gallery/update_edge_feature

clean:
	@make -C static/doc/commands clean
	@make -C static/doc/grs clean
	@make -C static/doc/rewriting clean
	@make -C static/doc/rule clean
	@make -C static/grs/deep_syntax clean
	@make -C static/grs/parsing clean
	@make -C static/tutorial/02_first_rule clean
	@make -C static/tutorial/03_rules_set clean
	@make -C static/tutorial/04_termination clean
	@make -C static/tutorial/05_confluence clean
	@make -C static/tutorial/06_more_commands clean
	@make -C static/usage/cli clean
	@make -C static/usage/python clean
	@make -C static/gallery/update_edge_feature clean

