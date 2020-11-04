#!/bin/bash -l

level=2

while [ $# -gt 0 ];
do
	case $1 in
		-l | -level)
			shift
			project="$1"
			;;
		*)
			;;
	esac
	shift
done

prefix="/tmp/dir.level"

tree -d -L ${level} | tree2dotx > ${prefix}.txt
dot -Tsvg -o ${prefix}.svg ${prefix}.txt

n ${prefix}.svg
