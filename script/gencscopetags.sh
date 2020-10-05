#!/bin/bash

echo "$0 : $(pwd) : parameters:$@"
if [ -n "$1" ]; then
    echo "find files in dir:$1"
    #find $1 -iname "Makefile" -o -iname "*.h" -o -iname "*.hpp" -o -iname "*.c" -o -iname "*.cc" -o -iname "*.cpp" -o -iname "*.java" -o -iname "*.s" > cscope.files
	find "$1" -type f -a -regextype posix-extended -regex ".*(\.((c$)|(h$)|(cc$)|(hh$)|(cpp$)|(cxx$)|(hpp$)|(java$)|(s$))|Makefile|MAKEFILE|Kconfig)" > cscope.files
else
    echo "find files in current dir"
	if [ "$(uname -s)" == "Darwin" ];then
		: > cscope.files
		file_suffix_list=(c h hh hpp cc cpp java s)
		for fs in ${file_suffix_list[@]};do
			find "." -type f -a -regex ".*\.${fs}$"  >> cscope.files
		done
		file_list=(Makefile Kconfig)
		for fs in ${file_list[@]};do
			find "." -iname ${fs} >> cscope.files
		done
	else
		find "." -type f -a -regextype posix-extended -regex ".*(\.((c$)|(h$)|(cc$)|(hh$)|(cpp$)|(cxx$)|(hpp$)|(java$)|(s$))|Makefile|MAKEFILE|Kconfig)" > cscope.files
	fi
fi
echo "end find"
awk '{print "\""$0"\""}' cscope.files > cscope.files.tmp
mv cscope.files.tmp cscope.files
echo "begin cs"
date
#cscope -bkqU -i cscope.files
if [ -d arch/arm/configs ];then
    cscope -bkq -i cscope.files
else
    cscope -bq -i cscope.files
fi
echo "end cs"

