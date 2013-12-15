#!/bin/sh

date_str="$(date +%F_%H%M%S)"

if [ $# -lt 2 ];then
	target_file="file.tar"
else
	target_file="$2"
fi

if [ -f "$target_file" ];then
    echo "mv $target_file old.${date_str}.${target_file}"
    mv "$target_file" old.${date_str}.${target_file}
fi

while read line
do
	if [ -d "$line" -o -f "$line" -o -L "$line" ]; then
		tar rvf "$target_file" $line
	fi
done < $1

echo "target_file is " "$target_file"
