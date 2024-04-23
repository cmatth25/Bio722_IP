#!/bin/bash
IFS=$'\n'       # make newlines the only separator
set -f          # disable globbing
for i in $(cat < "$1");
do 
	prefetch $i --max-size 100g
done

IFS=$'\n'       # make newlines the only separator
set -f          # disable globbing
for i in $(cat < "$1");
do
  fasterq-dump $i
done

gzip *.fastq
