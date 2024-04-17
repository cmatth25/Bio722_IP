#!/bin/bash
#loop over folder containing translated kraken2 outputs with long form mpa formatted taxonomy.
#eukaryotic and viral reads removed because the the 5th field for those taxa are Kingdom level rather than Phyla.
#unclassified contigs and those classified to ranks above phyla also filtered out.
for i in `ls *tax.txt`;
do
	tail -n +2 ${i} | sed 's/\,/\|/g' | awk -F"|" -v OFS='\t' '{print $1, $5}' | grep 'P__' > ${i::-13}extax.tsv
done
