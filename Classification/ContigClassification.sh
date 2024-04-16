for i in `ls *query.fa`;
do
	kraken2 --db /scratch/matthc8/kraken2db/ --threads 32  --classified-out /scratch/matthc8/722IP/MG/megahit/classified/${i:-9}Cl.fa --report /scratch/matthc8/722IP/MG/megahit/classified/${i:-9}.kreport --unclassified-out /scratch/matthc8/722IP/MG/megahit/classified/${i:-9}UC.fa --use-names ${i}
done
