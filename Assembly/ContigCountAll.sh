#!/bin/bash
for i in `ls *.contigs.fa.gz`; do echo ${i::-14} | tr '\n' '\t'; zcat ${i} | grep '^>' | wc -l; done >> all_contigs.tsv
