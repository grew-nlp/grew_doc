selfdoc:
	@echo " * make run --> run locally the server"

run:
	hugo server -w &
	open -a firefox -g http://localhost:1313/

talc2:
	hugo
	scp -r public/* $(stalc2)/www/grew_doc/
