build:
	# --- mod_copy ---
	grew_dev transform -i mod_copy.gr -dot -quiet | dot -Tsvg -o _mod_copy_in.svg
	grew_dev transform -grs mod_copy.grs -strat "mod_copy" -i mod_copy.gr -dot -quiet | dot -Tsvg -o _mod_copy_out.svg
	# --- copy_mod ---
	grew_dev transform -i copy_mod.gr -dot -quiet | dot -Tsvg -o _copy_mod_in.svg
	grew_dev transform -grs copy_mod.grs -strat "copy_mod" -i copy_mod.gr -dot -quiet | dot -Tsvg -o _copy_mod_out.svg
	# --- reverse ---
	grew_dev transform -i reverse.gr -dot -quiet | dot -Tsvg -o _reverse_in.svg
	grew_dev transform -grs reverse.grs -strat "Onf(reverse)" -i reverse.gr -dot -quiet | dot -Tsvg -o _reverse_out.svg
	# --- copy_sub ---
	grew_dev transform -i copy_sub.gr -dot -quiet | dot -Tsvg -o _copy_sub_in.svg
	grew_dev transform -grs copy_sub.grs -strat "copy_sub" -i copy_sub.gr -dot -quiet | dot -Tsvg -o _copy_sub_out.svg

clean:
	rm -f _*
