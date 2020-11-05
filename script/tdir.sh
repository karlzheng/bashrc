#!/bin/bash -l

level=2
only_dir=""

while [ $# -gt 0 ];
do
	case $1 in
		-l | -level)
			shift
			project="$1"
			;;
		-d | -dir)
			only_dir="-d"
			;;
		*)
			;;
	esac
	shift
done

prefix="/tmp/dir.level"

tree ${only_dir} -L ${level} | tree2dotx > ${prefix}.txt
dot -Tsvg -o ${prefix}.svg ${prefix}.txt

n ${prefix}.svg
