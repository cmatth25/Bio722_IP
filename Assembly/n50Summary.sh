for i in `ls -d *_quast/`; do echo ${i::-7} | tr '\n' '\t' ; grep 'N50' ${i}report.txt | sed 's/N50//g' | sed 's/\ //g'; done >> N50.txt
