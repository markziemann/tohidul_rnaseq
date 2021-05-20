#!/bin/bash

grep '>' Arabidopsis_thaliana.TAIR10.cdna.all.fa \
| sed 's/gene_symbol:/\n/' \
| cut -d ' ' -f1 \
| paste -s -d '\t' \
| tr '>' '\n' \
| awk '{OFS="\t"}{print $0,$1}' \
| tr -s '\t' \
| cut -f-2 > Arabidopsis_thaliana.TAIR10.46.geneaccession2symbol.tsv

