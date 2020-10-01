#!/bin/bash
set -x

IDX=../ref/Arabidopsis_thaliana.TAIR10.cdna+ncrna.all.fa.gz.idx

for FQZ1 in *R1_001.fastq.gz ; do
  FQZ2=$(echo $FQZ1 | sed 's/_R1_/_R2_/')
  echo $FQZ1 $FQZ2
  skewer -q 20 -t 16 $FQZ1 $FQZ2
  FQT1=$(echo $FQZ1 | sed 's/fastq.gz/fastq-trimmed-pair1.fastq/')
  FQT2=$(echo $FQZ1 | sed 's/fastq.gz/fastq-trimmed-pair2.fastq/')
  BASE=$(echo $FQZ1 | cut -d '_' -f1)
  kallisto quant -o $BASE -i $IDX -t 16 $FQT1 $FQT2
done

for TSV in */*abundance.tsv ; do
  NAME=$(echo $TSV | cut -d '/' -f1)
  cut -f1,4 $TSV | sed 1d | sed "s/^/${NAME}\t/"
done > 3col.tsv

