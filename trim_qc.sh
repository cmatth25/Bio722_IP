#fastp trim
for i in `ls *_1.fastq.gz | sed 's/.fastq.gz//g'`;
do
	j=`echo ${i} | sed 's/_1/_2/g'`
	fastp -q 15 -u 40 -i ${i}.fastq.gz -I ${j}.fastq.gz -o trimmed/${i}_t.fastq.gz -O trimmed/${j}_t.fastq.gz --unpaired1 trimmed/${i}_up.fastq.gz --unpaired2 trimmed/${j}_up.fastq.gz --detect_adapter_for_pe
done

#FastQC
cd trimmed/
fastqc *.fastq.gz -o fastQC
cd fastQC/
multiqc .

