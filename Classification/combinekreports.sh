#!/bin/bash

var1=$(ls -m *.breport | sed 's/,//g')
var2=$(ls -m *.breport | sed 's/_S.breport,//g')
python /scratch/matthc8/krakentools/KrakenTools-master/combine_kreports.py -r $var1 -o bracken_out/combined_bracken.breport --sample-names ${var2}
