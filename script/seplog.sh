#!/bin/bash -l

function seplog()
{
	local fn=$(lf)
	read -p "seplog ${fn} y|n ?" c
	if [ "x${c}" != "x" ];then
		#fn=$(find . -regex '.*\.\(log\|txt\)')
		fn=$(find . -maxdepth 1 -regex '.*\.\(log\|txt\)' | xargs ls -lt | head -n 1 | awk '{print $NF}')
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
	local filter_file="${log_dir}/${fn}.filter.txt"

	mkdir -p ${log_dir}
	while read l; do
		echo ${l}
		local kfn=$(echo "${l}" | sed s/[[:space:]]//g)
		echo grep "${l}" "${fn}"
		grep -q -Hn "${l}" "${fn}"
		if [ $? == 0 ];then
			grep -Hn "${l}" "${fn}" | tee ${log_dir}/${kfn}
			cat ${log_dir}/${kfn} >> ${filter_file}
		fi
	done < ~/log.keyword.txt
	sort ${filter_file} -o ${filter_file}
	/bin/cp ${fn} ${log_dir}/${fn}
	#vi ${filter_file} ${log_dir}/${fn}
	vim -c "BESHighlight" ${filter_file} ${log_dir}/${fn}

	#read -p "cd ${log_dir} y|n ?" c
	#if [ "x${c}" == "xy" -o "x${c}" == "xY" -o "x${c}" == "x" ];then
		#cd ${log_dir}
		#read -p "vi * y|n ?" c
		#if [ "x${c}" == "xy" -o "x${c}" == "xY" -o "x${c}" == "x" ];then
			#vi *
		#fi
	#fi
	#find . -name "*" -type f -size 0c | xargs -n 1 rm -f
}

seplog "$@"
