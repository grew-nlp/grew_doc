GREW=grew_dev

build:
	mkdir -p _build
	ln -f -s ../../../../extern/POStoSSQ _build/POStoSSQ
	ln -f -s ../../../../extern/frenchLanguagePack-5.2.0.zip _build/frenchLanguagePack-5.2.0.zip
	ln -f -s ../../../../extern/talismane-core-6.0.0.jar _build/talismane-core-6.0.0.jar
	ln -f -s ../../../../extern/talismane-fr-5.2.0.conf _build/talismane-fr-5.2.0.conf
	echo "La souris a été mangée par le chat." > _build/data.txt
	cd _build && \
	java -Xmx1G -Dconfig.file=talismane-fr-5.2.0.conf -jar talismane-core-6.0.0.jar \
  --analyse \
  --endModule=posTagger \
  --sessionId=fr \
  --encoding=UTF8 \
  --inFile=data.txt \
  --outFile=data.tal && cd -
	sed -f tal2grew.sed _build/data.tal > _build/data.pos.conll
	${GREW} transform -grs _build/POStoSSQ/grs/surf_synt_main.grs -config sequoia -i _build/data.pos.conll -o _build/data.surf.conll
	dep2pict _build/data.surf.conll _build/data.surf.svg

clean:
	rm -rf _build