#!/bin/bash -l
function lst.grep()
{
	local key_file="${HOME}/tmp/tee.log"
	local sf=A3600.lst
	local of="${HOME}/tmp/tmp_work_file/2.c"

	read -p "Sure grep $(fa) in ${sf} to ${of} y|n ?" c
	if [ "x${c}" != "xy" -a "x${c}" != "x" ];then
		echo "Cancel!!!"
		return
	fi

	#grep ASSERT $(fa) -A 45 |
	grep 'Possible Backtrace:' -A 20 $(fa) | \
		sed -e 's/\[.*]//' | \
		grep 'Thread' -B 20 | \
		grep -v  'Possible Backtrace:' | \
		grep -v 'Thread' | \
		sed -e 's/[[:space:]]//g' |
		tr A-Z a-z > ${key_file}

	#sort -n -k 2 -t : ${filter_file} -o ${filter_file}
	#uniq ${filter_file} ${filter_file}.uniq
	#mv ${filter_file}.uniq ${filter_file}
	#/bin/cp ${fn} ${log_dir}/${fn}

	echo "" > ${of}

	while read l; do
		echo ${l}
		l=$(echo ${l} | tr -d '\r' | tr -d '\n')
		if [ "x${l}" == "x" ];then
			continue;
		fi
		echo grep -aiHn -B 25 -A 25 "${l}" "${sf}" >> ${of}
		grep -aiHn -B 25 -A 25 "${l}" "${sf}" >> ${of}
		echo "" >> ${of}
	done < ${key_file}

	sed -i"" -e 's#-/#- /#' ${of}
}

lst.grep "$@"
