#!/bin/bash

IN=Ensembl2PlantReactome_PE_Pathway_ath_fmt.txt

for GS in $(cut -f2 $IN | sort -u) ; do
  NAME=$(grep -w $GS $IN | head -1 | cut -f2-3 | sed 's/\t/_/' | tr ' ' '_' )
  grep -w $GS $IN | cut -f1 | paste -s | sed "s/^/${NAME}\t/"
done > plant_reactome.gmt

