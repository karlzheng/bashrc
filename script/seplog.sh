#!/bin/bash -l

function seplog()
{
	local fn=$(lf)
	read -p "seplog ${fn} y|n ?" c
	if [ "x${c}" != "x" ];then
		fn=$(find . -regex '.*\.\(log\|txt\)')
		read -p "seplog ${fn} y|n ?" c
		if [ "x${c}" != "x" ];then
			return;
		fi
	fi
	if [ "x${fn}" == "x" ];then
		echo "Not Found *.log | *.txt"
		return;
	fi
	local log_dir=$(echo ${fn%\.*})
	mkdir -p ${log_dir}
	while read l; do
		echo ${l}
		local kfn=$(echo "${l}" | sed s/[[:space:]]//g)
		echo grep "${l}" "${fn}"
		grep -q -Hn "${l}" "${fn}"
		if [ $? == 0 ];then
			grep -Hn "${l}" "${fn}" | tee ${log_dir}/${kfn}
		fi
	done < ~/log.keyword.txt

	read -p "cd ${log_dir} y|n ?" c
	if [ "x${c}" == "xy" -o "x${c}" == "xY" -o "x${c}" == "x" ];then
		cd ${log_dir}
		read -p "vi * y|n ?" c
		if [ "x${c}" == "xy" -o "x${c}" == "xY" -o "x${c}" == "x" ];then
			vi *
		fi
	fi
	#find . -name "*" -type f -size 0c | xargs -n 1 rm -f
}

seplog "$@"
