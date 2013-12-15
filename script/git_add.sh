#!/bin/bash -

while read l
do
	if [ -d "$l" ];then
		git add "$l"
	fi
	if [ -f "$l" ];then
		git add "$l"
	fi
done < $1
