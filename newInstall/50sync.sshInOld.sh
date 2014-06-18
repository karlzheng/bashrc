#!/bin/bash

function syncPersonalFiles()
{
    local IFS=$'\n'
    local l
    local ol
    while read l;do
	l=$(echo $l | tr -d '\r'|tr -d '\n')
	l=${l%/}
	ol=l
	l=${l/\~/${HOME}}
	if [ -f "${l}" -o -d "${l}" ];then
	    echo ${l#${HOME}/}
		echo "rsync -avP ${l} ${NEWUSERNAME}@${NEWIP}:~/"
		rsync -avP ${l} ${NEWUSERNAME}@${NEWIP}:~/
	fi
    done < personalFile.list
}

if [ "x${NEWUSERNAME}" == "x" ];then
	export NEWUSERNAME=$(whoami)
    echo "export NEWUSERNAME=$(whoami)"
    history -s "export NEWUSERNAME=$(whoami)"
fi

if [ "x${NEWIP}" == "x" ];then
    echo "pls export NEWIP env var"
    history -s "export NEWIP"
	exit 1
else
    syncPersonalFiles
fi
