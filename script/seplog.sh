#!/bin/bash -l

function seplog()
{
	#local fn=$(lf)
	local fn=$(find . -maxdepth 1 -regex '.*\.\(log\|txt\|c\)' | xargs -I{} ls -lt "{}" | head -n 1 | awk '{print $NF}')

	if [ "x${fn}" == "x" ];then
		echo "Not Found *.log | *.txt"
		return;
	fi

	read -p "seplog ${fn} y|n ?" c
	if [ "x${c}" != "x" ];then
		return;
	fi

	local log_dir=$(echo ${fn%\.*})
	local filter_file="${log_dir}/${fn}.filter.txt"

	if [ -d "${log_dir}" ];then
		[ -d "${log_dir}.old" ] && /bin/rm -rf ${log_dir}.old
		mv ${log_dir} ${log_dir}.old
	fi

	mkdir -p ${log_dir}

	while read l; do
		echo ${l}
		echo ${l} | grep -q '^#'
		if [ $? == 0 ];then
			continue;
		fi
		local kfn=$(echo "${l}" | sed s/[[:space:]]//g)
		echo grep "${l}" "${fn}"
		grep -q -aHn "${l}" "${fn}"
		if [ $? == 0 ];then
			grep -aHn "${l}" "${fn}" >> ${filter_file}
		fi
	done < ~/log.keyword.mk

	sort -n -k 2 -t : ${filter_file} -o ${filter_file}

	uniq ${filter_file} ${filter_file}.uniq
	mv ${filter_file}.uniq ${filter_file}

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
