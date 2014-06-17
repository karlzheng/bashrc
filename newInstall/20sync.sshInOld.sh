#!/bin/bash

function syncInstList()
{
    dpkg -l | grep ^ii |awk '{print $2}' | grep -v "^linux-generic" | \
	grep -v "^linux-headers" | grep -v "^linux-image-" > /tmp/inst.list
    rsync -avP ~/inst.list ${NEWUSERNAME}@${NEWIP}:/tmp/
    rsync -avP ~/inst.list ${NEWUSERNAME}@${NEWIP}:~/
    rm /tmp/inst.list
}

function syncListedFile()
{
    python -c "open('/tmp/syncFile.list', 'w').\
	writelines(set(open('syncFile.list').readlines())-\
	set(open('alreadySyncFile.list').readlines()))"
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
		#rsync -avP ${l} ${NEWUSERNAME}@${NEWIP}:~/${l#${HOME}/}
		echo "rsync -avP ${l} ${NEWUSERNAME}@${NEWIP}:~/"
		rsync -avP ${l} ${NEWUSERNAME}@${NEWIP}:~/
	fi
    done < /tmp/syncFile.list
}

function installConfigInNew()
{
	ssh ${NEWUSERNAME}@${NEWIP} "cd ~/vimrc;./install.sh"
	ssh ${NEWUSERNAME}@${NEWIP} "cd bashrc;./install.sh"
}

function ssh-copy-id_2NEWIP()
{
	#http://roclinux.cn/?p=2551#more-2551
	ssh-copy-id ${NEWUSERNAME}@${NEWIP}
}

if [ "x${NEWUSERNAME}" == "x" ];then
	export NEWUSERNAME=$(whoami)
    echo "export NEWUSERNAME=$(whoami)"
fi

if [ "x${NEWIP}" == "x" ];then
    echo "pls export NEWIP env var"
    history -s "export NEWIP"
	exit 1
else
    #echo 'rsync -avP .ssh ${NEWUSERNAME}@${NEWIP}:~/'
	#rsync -avP .ssh ${NEWUSERNAME}@${NEWIP}:~/
	ssh-copy-id_2NEWIP
	syncInstList
    syncListedFile
	installConfigInNew
fi
