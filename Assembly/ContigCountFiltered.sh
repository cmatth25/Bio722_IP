#!/bin/bash
cd Filtered/10000/
for i in `ls *query.fa`; do echo ${i::-15} | tr '\n' '\t'; cat ${i} | grep '^>' | wc -l; done >> ../../10000_contigs.tsv
