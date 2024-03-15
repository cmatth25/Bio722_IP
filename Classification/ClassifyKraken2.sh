#only paired, fix?
for i in `ls *_1.fastq.gz | sed 's/_1.fastq.gz//g'`;
do
	kraken2 --db /2/scratch/keaton/maxikraken2_1903_140GB/ --threads 12 --paired --classified-out kraken/${i}_C#.fastq --report kraken2/${i}.txt --unclassified-out kraken2/${i}_UC#.fastq trimmed/${i}_1_t.fastq.gz trimmed/${i}_2_t.fastq.gz 
done

cd kraken2/
gzip *.fastq
