path=$PWD
[[ "$path" != */ ]] && path="${path}/"

for i in `ls *.json`;
do
	python ParseJSON-commandline.py ${i} $path
done
