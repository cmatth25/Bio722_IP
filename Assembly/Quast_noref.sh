#Compute canada
module load StdEnv/2020
module load gcc/9.3.0
module load python/3.10
module load quast/5.2.0

#arg 1 is the directory containing contigs to QC
#metaquast is finicky about connecting to NCBI for blast, timed out for most of the runs without successfully downloading refs
#run here with no refs for summary of contigs, but not properly QC'd

for file in ${1}/*contigs.fa.gz
do
        mkdir ${file%.contigs.fa.gz}_quast/;
        metaquast.py ${file} --max-ref-num 0 --threads 32 -o ${file%.contigs.fa.gz}_quast/
done
