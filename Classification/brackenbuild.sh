module load StdEnv/2020
module load gcc/9.3.0
module load kraken2/2.1.3 
module load bracken/2.7

#args: 1 - kraken2 database 2 - read length for brackenbuild

bracken-build  -d ${1} -t 32 -l ${2}
