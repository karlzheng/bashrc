#!/bin/bash
: > tagfilelist.txt
while read line;
do
	echo $line
	find $line -name "*.h" -o -name "*.hpp" -o -name "*.c" -o -name "*.cc" -o -name "*.cpp" -o -name "*.java" >> tagfilelist.txt
done < $1
