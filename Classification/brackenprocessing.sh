#!/bin/bash
#1=combined kreport formatted bracken output 2=number of samples 3 = level in quotes (Species = S, family = F, phylum = P)
var1=$(echo "$((${2}+3))")
tail -n +$var1 ${1} | awk 'NR==1{for(i=1;i<=NF;i++) if($i!~/[^ ]+_lvl$/){a[i]; printf $i FS}printf RS;next}
          {for(i=1;i<=NF;i++) if(i in a) printf $i FS; printf RS}' | awk -v var="$3" 'NR==1 {print;next} $(NF-2) == var'> process_bracken.breport
