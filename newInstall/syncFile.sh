#!/bin/bash

function syncListedFile()
{
    IFS=$'\n'
    local l
    while read l;do
	l=$(echo $l | tr -d '\r'|tr -d '\n')
	l=${l%/}
	l=${l/\~/${HOME}}
	if [ -f "${l}" -o -d "${l}" ];then
	    #echo "exist: ${l}"
	    rsync -avP ${l} $(whoami)@${NEWIP}:~/ 
	fi
    done < sync.list
}

if [ "x${NEWIP}" == "x" ];then
    echo "pls export NEWIP env var"
else
    syncListedFile
fi

