#!/bin/bash

function gencscopetags.sh.func()
{
	echo "$0 : $(pwd) : parameters:$@"

	if [ -n "$1" ]; then
		local file_dir="$1"
	else
		local file_dir="."
	fi

	echo "find files in dir: ${file_dir}"
	local regex_posix="-regextype posix-extended"
	if [ "$(uname -s)" == "Darwin" ];then
		regex_posix=""
	fi

	: > cscope.files
	local file_suffix_list=(c h hh hpp cc cpp cxx hpp java s)
	for ext in ${file_suffix_list[@]};do
		find ${file_dir} -type f -a ${regex_posix} -regex ".*\.${ext}$"  >> cscope.files
	done

	local file_list=(Makefile MAKEFILE Kconfig)
	for fn in ${file_list[@]};do
		find ${file_dir} -iname ${fn} >> cscope.files
	done
	echo "end find"

	awk '{print "\""$0"\""}' cscope.files > cscope.files.tmp
	mv cscope.files.tmp cscope.files

	echo "$(date) begin cscope"
	#cscope -bkqU -i cscope.files
	if [ -d arch/arm/configs ];then
		cscope -bkq -i cscope.files
	else
		cscope -bq -i cscope.files
	fi
	echo "$(date) begin cscope"
}

gencscopetags.sh.func "$@"
