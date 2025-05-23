HUGO=hugo
GREW=grew
DEP2PICT=dep2pict

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
	@make -C content/grewpy
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/doc/commands
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/doc/conllu
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/doc/grs
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/doc/json
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/doc/rewriting
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/doc/rule
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/gallery/connected_components
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/gallery/edge_lexicon
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/gallery/flat
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/gallery/iter
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/gallery/ud2sud
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/gallery/update_edge_feature
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/tutorial/02_first_rule
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/tutorial/03_rules_set
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/tutorial/04_termination
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/tutorial/05_confluence
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/tutorial/tokenisation_change
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/tutorial/edge_capture
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/tutorial/edge_label
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/tutorial/relation_table
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/usage/cli
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/usage/grew_count
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/usage/grew_server
	@make GREW=${GREW} DEP2PICT=${DEP2PICT} -C static/usage/python

clean:
	@make -C static/doc/commands clean
	@make -C static/doc/conllu clean
	@make -C static/doc/grs clean
	@make -C static/doc/json clean
	@make -C static/doc/rewriting clean
	@make -C static/doc/rule clean
	@make -C static/gallery/connected_components clean
	@make -C static/gallery/edge_lexicon clean
	@make -C static/gallery/flat clean
	@make -C static/gallery/iter clean
	@make -C static/gallery/ud2sud clean
	@make -C static/gallery/update_edge_feature clean
	@make -C static/tutorial/02_first_rule clean
	@make -C static/tutorial/03_rules_set clean
	@make -C static/tutorial/04_termination clean
	@make -C static/tutorial/05_confluence clean
	@make -C static/tutorial/tokenisation_change clean
	@make -C static/tutorial/edge_capture clean
	@make -C static/tutorial/edge_label clean
	@make -C static/tutorial/relation_table clean
	@make -C static/usage/cli clean
	@make -C static/usage/grew_count clean
	@make -C static/usage/grew_server clean
	@make -C static/usage/python clean
