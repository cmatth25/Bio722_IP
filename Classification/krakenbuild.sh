module load StdEnv/2020 
module load gcc/9.3.0
module load kraken2/2.1.3

#includes archaea, bacteria, plasmid, viral, human libraries
#arg for database directory build.

kraken2-build --standard --threads 32 --db ${1}
