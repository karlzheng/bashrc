#!/bin/sh

while read l
do
	#echo $l
	if [ ! -d "$l" ]; then
		echo "$l"
	fi
done < $1
