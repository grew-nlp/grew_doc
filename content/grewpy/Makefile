run:
	find . -name "*.ipynb" -exec jupyter nbconvert --execute --to notebook --inplace {} \;
	python3 ../../tools/ipynb2md.py
