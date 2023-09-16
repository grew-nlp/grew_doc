run:
	find . -name "*.ipynb" -exec jupyter nbconvert --execute --to notebook --inplace {} \;
	python ../../tools/ipynb2md.py
