#!/bin/bash -
#===============================================================================
#
#          FILE:  patch2dir.sh
#
#         USAGE:  ./patch2dir.sh file.patch
#
#   DESCRIPTION:
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Karl Zheng (), ZhengKarl#gmail.com
#       COMPANY: Alibaba
#       CREATED: 2011年12月10日 10时49分09秒 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

if [ $# -lt 1 ];then
    echo "$0 file.patch"
    exit 1
fi

file="$1"
if [ -f "$(pwd)/$1" ];then
    file="$(pwd)/$1"
fi

cd /dev/shm
if [ -d a -o -f a ];then
    if [ -d a.old -o -f a.old ];then
	/bin/rm a.old -rf
    fi
    mv a a.old
fi
if [ -d b -o -f b ];then
    if [ -d b.old -o -f b.old ];then
	/bin/rm b.old -rf
    fi
    mv b b.old
fi

mkdir -p a
mkdir -p b

#python - "$@" << EEOOFF
python - "$file" << EEOOFF
#!/usr/bin/env python
#encoding:utf8
#===============================================================================
#
#          FILE:  patch.py
#
#         USAGE:  ./patch.py file.patch
#
#   DESCRIPTION:
#
#        AUTHOR: Karl Zheng
#       COMPANY: Alibaba
#       CREATED: 2011年10月18日 15时25分15秒 CST
#      REVISION:  ---
#===============================================================================

import os
import sys
import re

lc = 0
data = ""

def process_ln_cb(fd):
    fd.close()

def process_ln(ln):
    global lc
    global data
    if re.search('diff --git a/.*b/', ln):
	lc += 1
	nl = data[lc]
	if re.search('new file mode', nl):
	    lc += 1
	    nl = data[lc]
	if re.search('old mode', nl):
	    lc += 1
	    nl = data[lc]
	if re.search('new mode', nl):
	    lc += 1
	    nl = data[lc]
	if re.search('deleted file', nl):
	    lc += 1
	    nl = data[lc]
	if re.search('index .*...*', nl):
	    lc += 1
	    nl = data[lc]
	if re.search('diff --git a/.*b/', nl):
	    lc -= 1
	    return False
	if re.search('Binary files', nl):
	    #lc += 1
	    nl = data[lc]
	    return False

	file1 = data[lc][4:].strip()
	lc += 1
	file2 = data[lc][4:].strip()
	dir1=os.popen("dirname '"+file1+"'").read().strip()
	dir2=os.popen("dirname '"+file2+"'").read().strip()
	os.system("mkdir -p '"+dir1+"'")
	os.system("mkdir -p '"+dir2+"'")
	os.system("touch '"+file1+"'")
	os.system("touch '"+file2+"'")

	#print file1
	#print file2
	fd1 = open(file1, "w")
	fd2 = open(file2, "w")

	lc += 1
	while lc < len(data):
	    nl = data[lc]
	    if re.search('diff --git a/.*b/', nl):
		lc -= 1
		process_ln_cb(fd1)
		process_ln_cb(fd2)
		os.system("touch --date='+1 min' '"+file2+"'")
		return True
	    if re.search('@@ ', nl):
		lc += 1
		continue
	    if re.search('^\+', nl):
		nl = nl[1:]
		fd2.write(nl)
		#print nl
	    else:
		if re.search('^-', nl):
		    nl = nl[1:]
		    fd1.write(nl)
		    #print nl
		else:
		    if nl.find('\\ No newline at end of file') == -1:
			fd1.write(nl[1:])
			fd2.write(nl[1:])
	    lc += 1

	process_ln_cb(fd1)
	process_ln_cb(fd2)

	#os.system("touch --date='next second' '"+file2+"'")
	os.system("touch --date='+1 min' '"+file2+"'")

    return True

def main(argv):
    global lc
    global data
    fd = open(sys.argv[1], "r")
    data = fd.readlines()

    while lc < len(data):
	ln = data[lc]
	#print ln
	#sys.stdout.write(ln)
	process_ln(ln)
	lc += 1

if __name__ == '__main__':
    main(sys.argv)
EEOOFF

type bcompare
if [ $? == 0 ];then
    bcompare a b &
fi
