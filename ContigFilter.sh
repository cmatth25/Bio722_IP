
cd megahitOut/
for i in `echo */`;
do
	j=`echo ${i} | sed 's#/##g'`
	awk -v RS='>[^\n]+\n' 'length() >= 1000 {printf "%s", prt $0} {prt = RT}' <(gzip -dc ${i}/final.contigs.fa.gz) > ${j}_query.fa
done

gzip *.fa
