GREW?=grew_dev

all:
	mkdir -p _build
	# python3 nsubj_table.py > _build/nsubj_table.out
	python3 nsubj_table.py | grep -v "failed to open socket" | grep -v "connected to port" > _build/nsubj_table.out
	python3 all_tables.py | grep -v "failed to open socket" | grep -v "connected to port" > _build/all_tables.out

clean:
	rm -rf _build
