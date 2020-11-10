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
	#
	# Example 4:
	grew_dev transform -config basic -i shift.gr -dot | dot -Tsvg -o _build/shift.svg
	grew_dev transform -config basic -grs shift_steps.grs -strat one -i shift.gr -dot | dot -Tsvg -o _build/shift_one.svg
	grew_dev transform -config basic -grs shift_steps.grs -strat two -i shift.gr -dot | dot -Tsvg -o _build/shift_two.svg
	grew_dev transform -config basic -grs shift.grs -i shift.gr -dot | dot -Tsvg -o _build/shift_rewritten.svg



purge:
	rm -rf _build
