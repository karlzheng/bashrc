#!/bin/bash -
#===============================================================================
#
#          FILE:  af.sh
#
#         USAGE:  ./af.sh < file.c
#
#   DESCRIPTION:
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Karl Zheng (), ZhengKarl#gmail.com;
#                http://www.weibo.com/zhengkarl
#       COMPANY: Alibaba
#       CREATED: 2011年12月10日 10时49分09秒 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

filename=$(basename $0)
: > /tmp/$filename.txt
while read line
do
	echo "$line" >> /tmp/$filename.txt
done

python - /tmp/$filename.txt << EEOOFF
#!/usr/bin/env python
#encoding:utf8
#===============================================================================
#
#          FILE: wakelock_align_output.py
#
#         USAGE: 1. execute: adb shell cat /proc/wake_lock > wake_lock.log
#                2. execute: python wakelock_align_output.py wake_lock.log
#
#   DESCRIPTION:
#
#        AUTHOR: Karl Zheng
#       COMPANY: Alibaba
#       CREATED: 2011年10月18日 15时25分15秒 CST
#      REVISION:  ---
#===============================================================================

import sys

def stripline(l):
    wl = []
    l = l.strip()
    d = {}
    if l.startswith('//'):
	d[l] = 1
	wl.append(d)
	return wl
    if l.startswith('/*'):
	if l.endswith('*/'):
	    d[l] = 1
	    wl.append(d)
	    return wl
    cs = l.find('/*')
    if cs != -1:
	ce = l.find('*/')
	s1 = l[0:cs]
	s2 = l[cs:ce + 2]
	words = s1.strip().split()
	for w in words:
	    d = {}
	    d[w] = 0
	    wl.append(d)
	d = {}
	d[s2] = 1
	wl.append(d)
	return wl
    cs = l.find('//')
    if cs != -1:
	s1 = l[0:cs]
	s2 = l[cs:]
	words = s1.strip().split()
	for w in words:
	    d = {}
	    d[w] = 0
	    wl.append(d)
	d = {}
	d[s2] = 1
	wl.append(d)
	return wl
    else:
	words = l.strip().split()
	for w in words:
	    d = {}
	    d[w] = 0
	    wl.append(d)

    return wl

    #for w in wl:
	#print w.keys().pop()

    #i = 0
    #state = 0
    #wi = ""
    #tmp = ""
    #tc = ""
    #while i < len(l):
	#if state == 0:
	    #if l[i] == '/':
		#state = 1
		#tmp += l[i]
	    #else
		#tmp += l[i]
		#w += l[i]
	#else:
	    #if state == 1:
		#if l[i] == '/':
		    #tmp += l[i:len(l)-1]
		    #wi  += l[i:len(l)-1]
		#if l[i] == '*':
		    #state = 2
		#else:
		    #print ""
	#w.append(tmp)

	#i += 1

def main(argv):
    wl = [] # seperated words line
    if len(argv) > 1:
	filename = argv[1]
    else:
	print "No file is designated!!"
	sys.exit(1)
    ifd = open(filename, "rb")

    lines = ifd.readlines()

    for l in lines:
	wl.append(stripline(l))

    mwpl = 0
    for ld in wl: # line dict
	if (len(ld) > mwpl):
	    mwpl = len(ld)

    wordlen = range(0, mwpl)
    i = 0
    while i < mwpl:
	wordlen[i] = 0
	i += 1

    for ld in wl:
	i = 0
	while i < len(ld):
	    wd = ld[i]
	    w = wd.keys().pop().strip()
	    if wd[w] != 1:
		if (wordlen[i] < len(w)):
		    wordlen[i] = len(w)
	    i += 1

    for ld in wl:
	i = 0
	while i < len(ld):
	    wd = ld[i]
	    w = wd.keys().pop().strip()

	    if (i != len(ld) - 1):
		print w,
		if wd[w] != 1:
		    if (wordlen[i] > len(w)):
			print ' '*(wordlen[i]-len(w)-1),
	    else:
		print w

	    i += 1

	if len(ld) == 0:
	    print ""

    ifd.close()

if __name__ == '__main__':
    main(sys.argv)
EEOOFF
