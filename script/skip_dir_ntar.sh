#!/bin/sh

date_str="$(date +%F_%H%M%S)"

if [ $# -lt 2 ];then
	target_file="file.tar"
else
	target_file="$2"
fi

while read line
do
	if [ -d $line ]; then
		echo "$line is a dir, skipped"
	else
		tar rvf "$target_file" $line
	fi
done < $1

echo "target_file is " "$target_file"
