for file in `ls *_query.fa`;
do
	mkdir ${file%_query.fa}_ASout
	antismash ${file}  --genefinding-tool prodigal --output-dir ${file%_query.fa}_ASout
done
