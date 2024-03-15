
cd megahitOut/
for i in `echo */`;
do
	j=`echo ${i} | sed 's#/##g'`
	awk -v RS='>[^\n]+\n' 'length() >= 20000 {printf "%s", prt $0} {prt = RT}' <(gzip -dc ${i}/final.contigs.fa.gz) > ${j}_20000query.fa
done

gzip *.fa
