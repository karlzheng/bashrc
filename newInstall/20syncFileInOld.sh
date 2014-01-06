#!/bin/bash

function syncListedFile()
{
    python -c "open('/tmp/syncFile.list', 'w').\
	writelines(set(open('syncFile.list').readlines())-\
	set(open('alreadySyncFile.list')))"
    IFS=$'\n'
    local l
    while read l;do
	l=$(echo $l | tr -d '\r'|tr -d '\n')
	l=${l%/}
	l=${l/\~/${HOME}}
	if [ -f "${l}" -o -d "${l}" ];then
	    #echo "exist: ${l}"
	    echo ${l#${HOME}/}
	    rsync -avP ${l} $(whoami)@${NEWIP}:~/${l#${HOME}/}
	fi
    done < /tmp/syncFile.list
}

if [ "x${NEWIP}" == "x" ];then
    echo "pls export NEWIP env var"
else
    dpkg -l | grep ^ii |awk '{print $2}' | grep -v "^linux-generic" | \
	grep -v "^linux-headers" | grep -v "^linux-image-" > ~/inst.list
    rsync -avP ~/inst.list $(whoami)@${NEWIP}:~/
    rm ~/inst.list

    syncListedFile
fi
