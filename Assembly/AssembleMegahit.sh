for i in `ls *_1.fastq.gz | sed 's/_1.fastq.gz//g'`;
do
	megahit -1 trimmed/${i}_1_t.fastq.gz -2 trimmed/${i}_2_t.fastq.gz -r trimmed/${i}_1_up.fastq.gz,trimmed/${i}_2_up.fastq.gz -o megahitOut/${i} --k-min 27 --k-step 20 -t 20
done

cd megahitOut/

for i in `pwd | ls`
do
  	gzip ${i}/final.contigs.fa
done

