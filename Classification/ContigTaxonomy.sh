#!/bin/bash

#1 kraken output file 2 kraken report

python /scratch/matthc8/krakentools/KrakenTools-master/kraken2_translate.py --classification ${1} --report ${2} --output taxonomy/${1::-8}_tax.txt --mpa-format
