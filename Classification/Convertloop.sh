path=$PWD
[[ "$path" != */ ]] && path="${path}/"

for i in `ls *_extax.tsv`;
do
	python ContTaxConvert.py ${i} $path
done
