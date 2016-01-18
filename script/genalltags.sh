#!/bin/bash

function rm_tag_file()
{
	read -p "rm files: $* y|n" c
	if [ "x${c}" == "xy" -o "x${c}" == "xY" -o "x${c}" == "x" ];then
		local IFS=$'\n'
		echo "/bin/rm -rf $@"
		while [ "x$1" != x ];do
			if [ -f "$1" -o -d "$1" ];then
				local d=${1%/}
				/bin/mv $d $d.dir.tmp
				/bin/rm -rf $d.dir.tmp &
			fi
			shift
		done
	else
		echo "Removing $@ cancled !!"
	fi
}
echo "$#"
if [ $# -ge 1 -a $1=="clean" ];then
	rm_tag_file filenametags fullfilenametags cscope.files cscope.po.out cscope.out cscope.in.out tags
else
	echo "$(date) lookuptags.sh $1"
	lookuptags.sh $1
	echo "$(date) gencscopetags.sh $1"
	gencscopetags.sh
	echo "$(date) gentags.sh  $1"
	gentags.sh $1
	date
fi
