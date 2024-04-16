#!/bin/bash
for i in `ls *.fastq.gz | sed 's/.fastq.gz//g'`;
do
	 /usr/local/BBmap/removehuman.sh in=${i}.fastq.gz out=/2/scratch/CraigM/IPP/Metagenomes/MGtotrim/trimmed/clean/${i}_clean.fastq.gz t=18 path=/2/scratch/CraigM/bowtie2ref/
done
