selfdoc:
	@echo " * make run --> run locally the server"

run:
	hugo server -w

talc2:
	hugo
	scp -r public/* $(stalc2)/www/grew_doc/
