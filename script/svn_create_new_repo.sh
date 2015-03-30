#!/bin/sh

if [ $# -lt 1 ];then
	echo "$0 new_repo old_repo"
	exit 1
fi
if [ -d $1 ];then
	echo "exist $1 dir. exit"
	exit
fi

svnadmin create $1

if [ $# -ge 2 ];then
	if [ -d $2 ];then
		/bin/cp $2/conf/authz $1/conf/authz
		/bin/cp $2/conf/passwd $1/conf/passwd
		/bin/cp $2/conf/svnserve.conf $1/conf/svnserve.conf
	fi
fi
