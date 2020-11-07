build:
	mkdir -p _build
	# draw input
	grew_dev transform -i copy.json -dot | dot -Tsvg -o _build/copy.svg
	# apply copy.grs
	grew_dev transform -grs copy.grs -i copy.json -dot | dot -Tsvg -o _build/copy_1_out.svg
	# apply modify_and_copy.grs
	grew_dev transform -grs modify_and_copy.grs -i copy.json -dot | dot -Tsvg -o _build/copy_2_out.svg
	# apply copy_and_modify.grs
	grew_dev transform -grs copy_and_modify.grs -i copy.json -dot | dot -Tsvg -o _build/copy_3_out.svg
	#
	# draw input
	grew_dev transform -i reverse.json -dot | dot -Tsvg -o _build/reverse.svg
	# apply reverse
	grew_dev transform -grs reverse.grs -i reverse.json -dot | dot -Tsvg -o _build/reverse_out.svg

purge:
	rm -rf _build
