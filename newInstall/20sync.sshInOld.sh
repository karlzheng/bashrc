#!/bin/bash

function syncInstList()
{
    dpkg -l | grep ^ii |awk '{print $2}' | grep -v "^linux-generic" | \
	grep -v "^linux-headers" | grep -v "^linux-image-" > ~/inst.list
    rsync -avP ~/inst.list $(whoami)@${NEWIP}:~/
    rm ~/inst.list
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
		#rsync -avP ${l} $(whoami)@${NEWIP}:~/${l#${HOME}/}
		echo "rsync -avP ${l} $(whoami)@${NEWIP}:~/"
		rsync -avP ${l} $(whoami)@${NEWIP}:~/
	fi
    done < /tmp/syncFile.list
}

function installConfigInNew()
{
	ssh $(whoami)@${NEWIP} "cd ~/vimrc;./install.sh"
	ssh $(whoami)@${NEWIP} "cd bashrc;./install.sh"
}

function ssh-copy-id_2NEWIP()
{
	#http://roclinux.cn/?p=2551#more-2551
	ssh-copy-id $(whoami)@${NEWIP}
}

if [ "x${NEWIP}" == "x" ];then
    echo "pls export NEWIP env var"
else
    #echo 'rsync -avP .ssh $(whoami)@${NEWIP}:~/'
	#rsync -avP .ssh $(whoami)@${NEWIP}:~/
	ssh-copy-id_2NEWIP

	syncInstList
    syncListedFile
	installConfigInNew
fi
