GREW?=grew

build:
	mkdir -p _build
	# draw input
	${GREW} transform -quiet -i copy.json -dot | dot -Tsvg -o _build/copy.svg
	# apply copy.grs
	${GREW} transform -quiet -grs copy.grs -i copy.json -dot | dot -Tsvg -o _build/copy_1_out.svg
	# apply modify_and_copy.grs
	${GREW} transform -quiet -grs modify_and_copy.grs -i copy.json -dot | dot -Tsvg -o _build/copy_2_out.svg
	# apply copy_and_modify.grs
	${GREW} transform -quiet -grs copy_and_modify.grs -i copy.json -dot | dot -Tsvg -o _build/copy_3_out.svg
	#
	# draw input
	${GREW} transform -quiet -i reverse.json -dot | dot -Tsvg -o _build/reverse.svg
	# apply reverse
	${GREW} transform -quiet -grs reverse.grs -i reverse.json -dot | dot -Tsvg -o _build/reverse_out.svg
	#
	# Example 4:
	${GREW} transform -quiet -config basic -i shift.json -dot | dot -Tsvg -o _build/shift.svg
	${GREW} transform -quiet -config basic -grs shift_steps.grs -strat one -i shift.json -dot | dot -Tsvg -o _build/shift_one.svg
	${GREW} transform -quiet -config basic -grs shift_steps.grs -strat two -i shift.json -dot | dot -Tsvg -o _build/shift_two.svg
	${GREW} transform -quiet -config basic -grs shift.grs -i shift.json -dot | dot -Tsvg -o _build/shift_rewritten.svg



clean:
	rm -rf _build
