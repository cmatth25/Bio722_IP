
cd megahitOut/
for i in `echo */`;
do
	j=`echo ${i} | sed 's#/##g'`
        awk -v size="$1" -v RS='>[^\n]+\n' 'length() >= size  {printf "%s", prt $0} {prt = RT}' <(gzip -dc ${i}/final.contigs.fa.gz) > ${j}_query.fa
done

gzip *.fa
