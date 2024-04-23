module load StdEnv/2020
module load bracken/2.7

#accepts 1 arg for bracken build read length

for i in `ls *.kreport`;
do
        bracken -d /scratch/matthc8/kraken2db/ -i ${i} -o /scratch/matthc8/722IP/MG/kraken2/bracken/${i::-8}_S.bracken -w /scratch/matthc8/722IP/MG/kraken2/bracken/${i::-8}_S.breport -r ${1} -l S
done
